//
//  FFSpark.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/26.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat distanceVertical = 4.0;
static const CGFloat distanceHorizontal = 0.0;
static const NSString *kExpandKey = @"expandKey";
static const NSString *kDotSizeKey = @"dotSizeKey";


@interface DotRadius : NSObject<NSCopying>
{
    @public
    CGFloat first;
    CGFloat second;
}
@end

@class FFFaveButton;
@interface FFSpark : UIView

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *firstColor;
@property (nonatomic, strong) UIColor *secondColor;
@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) DotRadius *dotRadius;

@property (nonatomic, strong) UIView *dotFirst;
@property (nonatomic, strong) UIView *dotSecond;


+ (instancetype)createSparkWithFaveButton:(FFFaveButton *)button
                                   radius:(CGFloat)radius
                               firstColor:(UIColor *)fristColor
                              secondColor:(UIColor *)secondColor
                                    angle:(CGFloat)angle
                                dotRadius:(DotRadius *)dotRadius;

- (instancetype)initWithRadius:(CGFloat)radius
                    firstColor:(UIColor *)firstColor
                   secondColor:(UIColor *)secondColor
                         angle:(CGFloat)angle
                     dotRadius:(DotRadius *)dotRadius;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;

- (void)animateIgniteShowWithRadius:(CGFloat)radius
                           duration:(CGFloat)duration
                              delay:(CGFloat)delay;

- (void)animateIgniteHideWithDuration:(CGFloat)duration
                                delay:(CGFloat)delay;

@end
