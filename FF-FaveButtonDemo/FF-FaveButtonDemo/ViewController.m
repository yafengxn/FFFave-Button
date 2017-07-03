//
//  ViewController.m
//  FF-FaveButtonDemo
//
//  Created by yafengxn on 2017/6/22.
//  Copyright © 2017年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "FFFaveButton.h"


static UIColor* color(NSInteger rgbColor) {
    return [UIColor colorWithRed:((CGFloat)((rgbColor & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((rgbColor & 0x00FF00) >> 8)) / 255.0
                            blue:((CGFloat)((rgbColor & 0x0000FF) >> 0)) / 255.0
                           alpha:1.0];
}

@interface ViewController ()<FFFaveButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat margin = (self.view.bounds.size.width - 44 * 4) / 5;
    NSArray *imageArray = [NSArray arrayWithObjects:@"heart", @"like", @"smile", @"star", nil];
    for (NSInteger i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        FFFaveButton *faveButton = [[FFFaveButton alloc] initWithFrame:CGRectMake(margin + i * (margin + 44), 200, 44, 44) faveIconNormal:image];
        
        if (i == 0) {
            [faveButton setSelectedColor:[UIColor colorWithRed:223/255.0
                                                         green:28/255.0
                                                          blue:71/255.0
                                                         alpha:1.0]];
        } else if (i == 1) {
            [faveButton setSelectedColor:[UIColor colorWithRed:41/255.0
                                                         green:133/255.0
                                                          blue:255/255.0
                                                         alpha:1.0]];
        } else if (i == 2) {
            [faveButton setSelectedColor:[UIColor colorWithRed:68/255.0
                                                         green:181/255.0
                                                          blue:87/255.0
                                                         alpha:1.0]];
        } else {
            [faveButton setSelectedColor:[UIColor orangeColor]];
        }
        
        faveButton.ff_delegate = self;
        [self.view addSubview:faveButton];
    }
}


#pragma mark - FFFaveButtonDelegate
- (void)faveButton:(FFFaveButton *)button didSelected:(BOOL)selected {
    
}

- (NSArray<DotColors *> *)dotColorsWithFaveButton:(FFFaveButton *)button {
    return @[
             [DotColors dotColorsWithFirst:color(0x7DC2F4) Second:color(0xE2264D)],
             [DotColors dotColorsWithFirst:color(0xF8CC61) Second:color(0x9BDFBA)],
             [DotColors dotColorsWithFirst:color(0xAF90F4) Second:color(0x90D1F9)],
             [DotColors dotColorsWithFirst:color(0xE9A966) Second:color(0xF8C852)],
             [DotColors dotColorsWithFirst:color(0xF68FA7) Second:color(0xF6A2B8)],
             ];
}


@end
