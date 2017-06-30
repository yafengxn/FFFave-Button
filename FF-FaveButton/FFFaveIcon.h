//
//  FFFaveIcon.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFFaveIcon : UIView

+ (instancetype)createFaveIconOnView:(UIView *)view icon:(UIImage *)icon color:(UIColor *)color;

- (void)animationSelect:(BOOL)selected fillColor:(UIColor *)color duration:(CGFloat)duration delay:(CGFloat)delay;

@end
