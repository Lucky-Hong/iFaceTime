/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  IFTSlideHeaderLabel.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTSlideHeaderLabel.h"

@implementation IFTSlideHeaderLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.scale = 0.0;
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale*71.f/255.f green:scale*135.f/255.f blue:scale*252.f/255.f alpha:1];
    CGFloat minScale = 1.0;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale); // label的size大小变换
}

@end
