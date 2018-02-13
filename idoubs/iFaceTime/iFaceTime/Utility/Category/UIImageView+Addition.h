//
//  UIImageView+Addition.h
//  SevenColorMovies
//
//  Created by yesdgq on 16/7/19.
//  Copyright © 2016年 yesdgq. All rights reserved.
//  图形圆角处理

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
// 圆形
- (instancetype)initWithRoundingRectImageView;

- (void)zy_cornerRadiusRoundingRect;
// 边线
- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
