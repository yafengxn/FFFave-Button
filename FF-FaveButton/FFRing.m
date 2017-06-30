//
//  FFRing.m
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/26.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import "FFRing.h"
#import "FFFaveButton.h"
#import "UIView+FrameExtension.h"

static NSString *kCollapseAnimation = @"collapseAnimation";

@interface FFRing()<CAAnimationDelegate>

@end

@implementation FFRing

+ (instancetype)createRingWithButton:(FFFaveButton *)button
                              radius:(CGFloat)radius
                           lineWidth:(CGFloat)lineWidth
                           fillColor:(UIColor *)color {
    FFRing *ring = [[FFRing alloc] initWithRadius:radius lineWidth:lineWidth fillColor:color];
    ring.backgroundColor = [UIColor clearColor];
    [button.superview insertSubview:ring belowSubview:button];
    ring.center = button.center;
    
    return ring;
}

- (instancetype)initWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth fillColor:(UIColor *)color {
    if (self = [super initWithFrame:CGRectZero]) {
        _fillColor = color;
        _radius = radius;
        _lineWidth = lineWidth;
        
        [self applyInit];
    }
    return self;
}

- (void)applyInit {
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:centerView];
    centerView.backgroundColor = [UIColor clearColor];
    centerView.center = self.center;
    centerView.width = self.width;
    centerView.height = self.height;
    
    CAShapeLayer *circle = [self createRingLayerWithRadius:_radius
                                                 lineWidth:_lineWidth
                                                 fillColor:[UIColor clearColor]
                                               strokeColor:_fillColor];
    [centerView.layer addSublayer:circle];
    self.ringLayer = circle;
}

- (CAShapeLayer *)createRingLayerWithRadius:(CGFloat)radius
                                  lineWidth:(CGFloat)lineWidth
                                  fillColor:(UIColor *)fillColor
                                strokeColor:(UIColor *)strokeColor
{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                              radius:radius - _lineWidth / 2
                                                          startAngle:0
                                                            endAngle:2 * M_PI
                                                           clockwise:YES];
    
    CAShapeLayer *ringLayer = [[CAShapeLayer alloc] init];
    ringLayer.path = circlePath.CGPath;
    ringLayer.fillColor = fillColor.CGColor;
    ringLayer.lineWidth = 3;
    ringLayer.strokeColor = strokeColor.CGColor;
    
    return ringLayer;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(false, @"initWithCoder: has not implemented");
    return nil;
}


- (void)animateToRadius:(CGFloat)radius toColor:(UIColor *)toColor duration:(CGFloat)duration delay:(CGFloat)delay {
    [self layoutIfNeeded];
    
    self.width = radius * 2;
    self.height = radius * 2;
    
    CGFloat fittedRadius = radius - _lineWidth / 2;
    
    CABasicAnimation *fillColorAnimation = [self animationFillColorFrom:self.fillColor
                                                                toColor:toColor
                                                               duration:duration
                                                                  delay:delay];
    CABasicAnimation *lineWidthAnimation = [self animationLineWidth:_lineWidth
                                                           duration:duration
                                                              delay:delay];
    CABasicAnimation *lineColorAnimation = [self animationStrokeColor:toColor
                                                             duration:duration
                                                                delay:delay];
    CABasicAnimation *circlePathAnimation = [self animationCirclePath:fittedRadius
                                                             duraiton:duration
                                                                delay:delay];
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                        [self layoutIfNeeded];
                     } completion:nil];
    
    [self.ringLayer addAnimation:fillColorAnimation forKey:nil];
    [self.ringLayer addAnimation:lineWidthAnimation forKey:nil];
    [self.ringLayer addAnimation:lineColorAnimation forKey:nil];
    [self.ringLayer addAnimation:circlePathAnimation forKey:nil];
}

- (void)animateColapseWithRadius:(CGFloat)radius duration:(CGFloat)duration delay:(CGFloat)delay {
    CABasicAnimation *lineWidthAnimation = [self animationLineWidth:0
                                                           duration:duration
                                                              delay:delay];
    CABasicAnimation *circlePathAnimation = [self animationCirclePath:radius
                                                             duraiton:duration
                                                                delay:delay];
    circlePathAnimation.delegate = self;
    [circlePathAnimation setValue:kCollapseAnimation forKey:kCollapseAnimation];
    [self.ringLayer addAnimation:lineWidthAnimation forKey:nil];
    [self.ringLayer addAnimation:circlePathAnimation forKey:nil];
}

- (CABasicAnimation *)animationFillColorFrom:(UIColor *)fromColor
                                     toColor:(UIColor *)toColor
                                    duration:(CGFloat)duration
                                       delay:(CGFloat)delay
{
    CABasicAnimation *fillColorAnimaiton = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimaiton.fromValue = (__bridge id)(fromColor.CGColor);
    fillColorAnimaiton.toValue = (__bridge id)(toColor.CGColor);
    fillColorAnimaiton.duration = duration;
    fillColorAnimaiton.beginTime = CACurrentMediaTime() + delay;
    fillColorAnimaiton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return fillColorAnimaiton;
}

- (CABasicAnimation *)animationStrokeColor:(UIColor *)strokeColor duration:(CGFloat)duration delay:(CGFloat)delay {
    CABasicAnimation *strokeColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnimation.toValue = (__bridge id _Nullable)(strokeColor.CGColor);
    strokeColorAnimation.duration = duration;
    strokeColorAnimation.beginTime = CACurrentMediaTime() + delay;
    strokeColorAnimation.fillMode = kCAFillModeForwards;
    strokeColorAnimation.removedOnCompletion = NO;
    strokeColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return strokeColorAnimation;
}

- (CABasicAnimation *)animationLineWidth:(CGFloat)lineWidth
                                duration:(CGFloat)duration
                                   delay:(CGFloat)delay {
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.toValue = @(lineWidth);
    lineWidthAnimation.duration = duration;
    lineWidthAnimation.beginTime = CACurrentMediaTime() + delay;
    lineWidthAnimation.fillMode = kCAFillModeForwards;
    lineWidthAnimation.removedOnCompletion = NO;
    lineWidthAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return lineWidthAnimation;
}

- (CABasicAnimation *)animationCirclePath:(CGFloat)radius
                                 duraiton:(CGFloat)duration
                                    delay:(CGFloat)delay {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:YES];
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnimation.toValue = (__bridge id _Nullable)(path.CGPath);
    circleAnimation.duration = duration;
    circleAnimation.beginTime = CACurrentMediaTime() + delay;
    circleAnimation.fillMode = kCAFillModeForwards;
    circleAnimation.removedOnCompletion = NO;
    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return circleAnimation;
}

#pragma mark - MARK
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim valueForKey:kCollapseAnimation]) {
        [self removeFromSuperview];
    }
}



@end
