//
//  FFRing.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/26.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>



@class FFFaveButton;
@interface FFRing : UIView
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) CAShapeLayer *ringLayer;

+ (instancetype)createRingWithButton:(FFFaveButton *)button radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth fillColor:(UIColor *)color;

- (instancetype)initWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth fillColor:(UIColor *)color;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;

- (void)animateToRadius:(CGFloat)radius toColor:(UIColor *)toColor duration:(CGFloat)duration delay:(CGFloat)delay;

- (void)animateColapseWithRadius:(CGFloat)radius duration:(CGFloat)duration delay:(CGFloat)delay;

@end
