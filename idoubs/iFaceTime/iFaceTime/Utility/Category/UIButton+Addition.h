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
//  UIButton+Addition.h
//  SevenColorMovies
//
//  Created by yesdgq on 16/8/3.
//  Copyright © 2016年 yesdgq. All rights reserved.
//  

#import <UIKit/UIKit.h>

typedef void(^ActionHandler)();

@interface UIButton (Addition)

// 扩张的边界大小
@property (nonatomic, assign) CGFloat enlargedEdge;
// 设置四个边界扩充的大小
- (void)setEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

// 将target-action改造为block
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionHandler)action;

@end

