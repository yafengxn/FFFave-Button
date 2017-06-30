//
//  UIView+FrameExtension.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExtension)

@property CGPoint center;
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

- (void)setAnchorPoint:(CGPoint)anchorPoint;
- (void)setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint;

@end
