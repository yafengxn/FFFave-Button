//
//  FFFaveButton.m
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import "FFFaveButton.h"
#import "FFFaveIcon.h"
#import "FFRing.h"
#import "FFSpark.h"

@implementation DotColors
+ (instancetype)dotColorsWithFirst:(UIColor *)firstColor Second:(UIColor *)secondColor {
    DotColors *dotColor = [[DotColors alloc] init];
    dotColor->first = firstColor;
    dotColor->second = secondColor;
    return dotColor;
}
@end

static const CGFloat kDuration = 1.0;
static const CGFloat kExpandDuration = 0.1298;
static const CGFloat kCollapseDuration = 0.1089;
static const CGFloat kFaveIconShowDelay = kExpandDuration + kCollapseDuration / 2;

struct DotRadiusFactors {
    CGFloat first;
    CGFloat second;
};

static const struct DotRadiusFactors dotRadiusFactors = {
    .first = 0.0633,
    .second = 0.04
};


@implementation FFFaveButton

- (instancetype)initWithFrame:(CGRect)frame faveIconNormal:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        _favecIconImage = image;
        _sparkGroupCount = 7;
        [self applyInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame faveIconNormal:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self applyInit];
    }
    return self;
}

- (void)applyInit {
    if (_favecIconImage == nil) {
        _favecIconImage = [self imageForState:UIControlStateNormal];
    }
    NSAssert(_favecIconImage != nil, @"please provide an image for normal state.");
    
    [self setImage:[UIImage new] forState:UIControlStateNormal];
    [self setImage:[UIImage new] forState:UIControlStateSelected];
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateSelected];
    
    _faveIcon = [self createFaveIcon:_favecIconImage];
    
    [self addActions];
}

- (FFFaveIcon *)createFaveIcon:(UIImage *)image{
    return [FFFaveIcon createFaveIconOnView:self icon:image color:self.normalColor];
}

- (NSArray *)createSparksWithRadius:(CGFloat)radius {
    NSMutableArray *mArray = [NSMutableArray array];
    NSInteger steps = 360 / self.sparkGroupCount;
    CGFloat base = self.bounds.size.width;
    
    DotRadius *dotRadius = [DotRadius new];
    dotRadius->first = base * dotRadiusFactors.first;
    dotRadius->second = base *dotRadiusFactors.second;
    CGFloat offset = 10.0;
    
    for (NSInteger index = 0; index < self.sparkGroupCount; index ++) {
        CGFloat theta = steps * index + offset;
        DotColors *color = [self dotColorsAtIndex:index];
        
        FFSpark *spark = [FFSpark createSparkWithFaveButton:self
                                                     radius:radius
                                                 firstColor:color->first
                                                secondColor:color->second
                                                      angle:theta
                                                  dotRadius:dotRadius];
        [mArray addObject:spark];
    }
    
    return [mArray copy];
}


- (void)setSelected:(BOOL)selected {
    [self animatedSelect:selected duration:kDuration];
    [super setSelected:selected];
}

- (void)animatedSelect:(BOOL)isSelected duration:(CGFloat)duration {
    UIColor *color = isSelected ? self.selectedColor : self.normalColor;
    
    [_faveIcon animationSelect:isSelected fillColor:color duration:duration delay:kFaveIconShowDelay];
    
    if (isSelected) {
        CGFloat radius = self.bounds.size.width * 1.3 / 2;
        CGFloat igniteFromRadius = radius * 0.8;
        CGFloat igniteToRadius   = radius * 1.1;
        
        FFRing *ring = [FFRing createRingWithButton:self
                                             radius:0.01
                                          lineWidth:3
                                          fillColor:self.circleFromColor ];
        NSArray *sparks = [self createSparksWithRadius:igniteFromRadius];
        
        [ring animateToRadius:radius toColor:self.circleToColor duration:kExpandDuration delay:0];
        [ring animateColapseWithRadius:radius duration:kCollapseDuration delay:kExpandDuration];
        
        for (FFSpark *spark in sparks) {
            [spark animateIgniteShowWithRadius:igniteToRadius duration:0.4 delay:kCollapseDuration/3.0];
            [spark animateIgniteHideWithDuration:0.7 delay:0.2];
        }
    }
}

- (DotColors *)dotColorsAtIndex:(NSInteger)index {
    if (self.ff_delegate && [self.ff_delegate respondsToSelector:@selector(dotColorsWithFaveButton:)]) {
        NSArray *colors = [self.ff_delegate dotColorsWithFaveButton:self];
        
        NSInteger colorIndex = 0;
        for (NSInteger i = 0; i < colors.count; i++) {
            if (i == index) {
                colorIndex = i;
            } else {
                colorIndex = index % colors.count;
            }
        }
        
        return colors[colorIndex];
    }
    
    DotColors *dotColor = [[DotColors alloc] init];
    dotColor->first = self.dotFirstColor;
    dotColor->second = self.dotSecondColor;
    return dotColor;
}

- (void)addActions {
    [self addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toggle:(UIButton *)button {
    button.selected = !button.isSelected;
    
    CGFloat delay = DISPATCH_TIME_NOW + kDuration * NSEC_PER_SEC;
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        if (self.ff_delegate && [self.ff_delegate respondsToSelector:@selector(faveButton:didSelected:)]) {
            [self.ff_delegate faveButton:self didSelected:self.isSelected];
        }
    });
}


#pragma mark - defaultColor
- (UIColor *)normalColor {
    if (_normalColor == nil) {
        _normalColor = [UIColor colorWithRed:137/255.0 green:156/255.0 blue:167/255.0 alpha:1];
    }
    return _normalColor;
}
- (UIColor *)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor colorWithRed:226/255.0 green:38/255.0 blue:77/255.0 alpha:1];
    }
    return _selectedColor;
}
- (UIColor *)dotFirstColor {
    if (_dotFirstColor == nil) {
        _dotFirstColor = [UIColor colorWithRed:152/255.0 green:219/255.0 blue:36/255.0 alpha:1];
    }
    return _dotFirstColor;
}
- (UIColor *)dotSecondColor {
    if (_dotSecondColor == nil) {
        _dotSecondColor = [UIColor colorWithRed:247/255.0 green:188/255.0 blue:48/255.0 alpha:1];
    }
    return _dotSecondColor;
}
- (UIColor *)circleFromColor {
    if (_circleFromColor == nil) {
        _circleFromColor = [UIColor colorWithRed:221/255.0 green:70/255.0 blue:136/255.0 alpha:1];
    }
    return _circleFromColor;
}

- (UIColor *)circleToColor {
    if (_circleToColor == nil) {
        _circleToColor = [UIColor colorWithRed:205/255.0 green:143/255.0 blue:246/255.0 alpha:1];
    }
    return _circleToColor;
}
@end
