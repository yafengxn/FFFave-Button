//
//  FFFaveIcon.m
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import "FFFaveIcon.h"
#import "UIView+FrameExtension.h"
#import "Easing.h"

@interface FFFaveIcon ()
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) CAShapeLayer *iconLayer;
@property (nonatomic, strong) CALayer *iconMask;
@property (nonatomic, assign) CGRect contentRegion;
@property (nonatomic, copy) NSArray *tweenVlues;
@end

@implementation FFFaveIcon

+ (instancetype)createFaveIconOnView:(UIView *)onView icon:(UIImage *)icon color:(UIColor *)color {
    FFFaveIcon *faveIcon = [[FFFaveIcon alloc] initWithFrame:onView.bounds icon:icon color:color];
    onView.backgroundColor = [UIColor clearColor];
    [onView addSubview:faveIcon];
    faveIcon.center = CGPointMake(onView.bounds.size.width/2, onView.bounds.size.height/2);
    
    return faveIcon;
}


- (instancetype)initWithFrame:(CGRect)region icon:(UIImage *)icon color:(UIColor *)color {
    if (self = [super initWithFrame:CGRectZero]) {
        _iconColor = color;
        _iconImage = icon;
        _contentRegion = region;
        
        [self applyInit];
    }
    
    return self;
}

- (void)applyInit {
    CGPoint center = [self centerInRect:_contentRegion];
    CGRect maskRegion = [self rect:_contentRegion scaleBy:0.7 rectCenteredAt:center];
    CGPoint shapeOrigin = CGPointMake(-center.x, -center.y);
    
    _iconMask = [CALayer layer];
    _iconMask.contents = (__bridge id)_iconImage.CGImage;
    _iconMask.contentsScale = [UIScreen mainScreen].scale;
    _iconMask.bounds = maskRegion;
    
    _iconLayer = [CAShapeLayer layer];
    _iconLayer.fillColor = _iconColor.CGColor;
    _iconLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(shapeOrigin.x, shapeOrigin.y, _contentRegion.size.width, _contentRegion.size.height)].CGPath;
    _iconLayer.mask = _iconMask;
    
    [self.layer addSublayer:_iconLayer];
}


- (void)animationSelect:(BOOL)isSelected fillColor:(UIColor *)color duration:(CGFloat)duration delay:(CGFloat)delay {
    if (nil == _tweenVlues) {
        _tweenVlues = [self generateTweenValuesFrom:0 to:1.0 duration:duration];
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.iconLayer.fillColor = color.CGColor;
    [CATransaction commit];
    
    CGFloat selectedDelay = isSelected? delay : 0;
    
    if (isSelected) {
        self.alpha = 0.0;
        [UIView animateWithDuration:0
                              delay:selectedDelay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.alpha = 1.0;
                         } completion:nil];
    }
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = _tweenVlues;
    scaleAnimation.duration = duration;
    scaleAnimation.beginTime = CACurrentMediaTime() + selectedDelay;
    [self.iconMask addAnimation:scaleAnimation forKey:nil];
}

- (NSArray *)generateTweenValuesFrom:(CGFloat)fromValue
                                  to:(CGFloat)toValue
                            duration:(CGFloat)duration {
    NSMutableArray *mArray = [NSMutableArray array];
    CGFloat fps = 60;
    CGFloat tpf = duration / fps;
    CGFloat c = toValue - fromValue;
    CGFloat d = duration;
    CGFloat t = 0.0;
    
    while (t < d) {
        CGFloat scale = ElasticEaseOut(t, fromValue, c, d, c+0.001, 0.39988);
        [mArray addObject:@(scale)];
        t += tpf;
    }
    
    return [mArray copy];
}


#pragma MARK
- (CGRect)rect:(CGRect)rect scaleBy:(CGFloat)scale rectCenteredAt:(CGPoint)center {
    CGFloat dx = rect.size.width / 2;
    CGFloat dy = rect.size.height / 2;
    CGPoint origin = CGPointMake(center.x - dx, center.y - dy);
    
    return CGRectMake(origin.x, origin.y, rect.size.width*scale, rect.size.height*scale);
}

- (CGPoint)centerInRect:(CGRect)rect {
    return CGPointMake(rect.size.width / 2, rect.size.height / 2);
}



@end
