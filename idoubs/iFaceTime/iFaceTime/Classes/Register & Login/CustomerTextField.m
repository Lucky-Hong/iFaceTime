/*
 *    |  ___  \    /  ___ \   | |\   | |   / _______|
 *    | |    \ |  | /    \ |  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |___ / /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  CustomerTextField.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/9.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "CustomerTextField.h"

@implementation CustomerTextField

// leftView 便宜设置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds {
//    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 15; // 像右边偏15
//    return iconRect;
//}

// UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds {

    return CGRectInset(bounds, 30, 0);

}

// 控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {

    return CGRectInset(bounds, 30, 0);
}


@end
