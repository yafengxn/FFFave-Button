//
//  Easing.h
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat EaseIn(CGFloat _t, CGFloat b, CGFloat c, CGFloat d);
CGFloat EaseOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d);
CGFloat EaseInOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d);

CGFloat ElasticEaseIn(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p);
CGFloat ElasticEaseOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p);
CGFloat ElasticEaseInOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p);

