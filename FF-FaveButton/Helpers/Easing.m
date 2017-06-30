//
//  Easing.m
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import "Easing.h"

CGFloat EasingIn(CGFloat _t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat t = _t;
    
    if (t == 0) return b;
    t /= d;
    if (t == 1) return b + c;
    
    CGFloat p = d * 0.3;
    CGFloat a = c;
    CGFloat s = p / 4;
    
    t  -= 1;
    return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * M_PI) / p)) + b;
}

CGFloat EaseOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat t = _t;
    
    if (t == 0) return b;
    t /= d;
    if (t == 1) return b + c;
    
    CGFloat p = d * 0.3;
    CGFloat a = c;
    CGFloat s = p / 4;
    
    return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / p) + c + b);
}

CGFloat EaseInOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat t = _t;
    
    if (t == 0) return b;
    t /= d;
    if (t == 1) return b + c;
    
    CGFloat p = d * 0.3;
    CGFloat a = c;
    CGFloat s = p / 4;
    
    if (t < 1) {
        t -= 1;
        return -0.5*(a*pow(2,10*t) * sin((t*d-s)*(2*M_PI)/p )) + b;
    }
    t -= 1;
    return a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p )*0.5 + c + b;
}

CGFloat ElasticEaseIn(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p) {
    CGFloat t = _t;
    CGFloat a = _a;
    CGFloat p = _p;
    CGFloat s = 0.0;
    
    if (t == 0) return b;
    
    t /= d;
    if (t == 1) return b + c;
    
    if (a < fabs(c)) {
        a = c;
        s = p / 4;
    } else {
        s = p/(2*M_PI) * asin (c/a);
    }
    
    t -= 1;
    return -(a*pow(2,10*t) * sin( (t*d-s)*(2*M_PI)/p )) + b;
}

CGFloat ElasticEaseOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p) {
    CGFloat t = _t;
    CGFloat a = _a;
    CGFloat p = _p;
    CGFloat s = 0.0;
    
    if (t == 0) return b;
    
    t /= d;
    if (t == 1) return b + c;
    
    if (a < fabs(c)) {
        a = c;
        s = p / 4;
    } else {
        s = p/(2*M_PI) * asin (c/a);
    }
    
    return (a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p ) + c + b);
}

CGFloat ElasticEaseInOut(CGFloat _t, CGFloat b, CGFloat c, CGFloat d, CGFloat _a, CGFloat _p) {
    CGFloat t = _t;
    CGFloat a = _a;
    CGFloat p = _p;
    CGFloat s = 0.0;
    
    if (t == 0) return b;
    t /= d/2;
    
    if (t == 2) return b + c;
    
    if (a < fabs(c)) {
        a = c;
        s = p/4;
    } else {
        s = p/(2*M_PI) * asin (c/a);
    }
    
    if (t < 1) {
        t -= 1;
        return -0.5*(a*pow(2,10*t) * sin( (t*d-s)*(2*M_PI)/p )) + b;
    }
    t -= 1;
    return a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p )*0.5 + c + b;
}
