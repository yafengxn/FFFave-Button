//
//  FFFaveButton.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DotColors : NSObject
{
    @public
    UIColor *first;
    UIColor *second;
}

+ (instancetype)dotColorsWithFirst:(UIColor *)firstColor Second:(UIColor *)secondColor;
@end

@class FFFaveButton;
@protocol FFFaveButtonDelegate <NSObject>

- (void)faveButton:(FFFaveButton *)button didSelected:(BOOL)selected;

- (NSArray<DotColors *> *)dotColorsWithFaveButton:(FFFaveButton *)button;

@end

@class FFFaveIcon;
@interface FFFaveButton : UIButton
@property (nonatomic, weak) id<FFFaveButtonDelegate> ff_delegate;
@property (nonatomic, assign) NSInteger sparkGroupCount;
@property (nonatomic, strong) UIImage *favecIconImage;
@property (nonatomic, strong) FFFaveIcon *faveIcon;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *dotFirstColor;
@property (nonatomic, strong) UIColor *dotSecondColor;
@property (nonatomic, strong) UIColor *circleFromColor;
@property (nonatomic, strong) UIColor *circleToColor;

- (instancetype)initWithFrame:(CGRect)frame faveIconNormal:(UIImage *)image;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
