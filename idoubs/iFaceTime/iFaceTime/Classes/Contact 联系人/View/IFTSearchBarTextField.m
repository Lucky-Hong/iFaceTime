//
//  IFTSearchBarTextField.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTSearchBarTextField.h"

@implementation IFTSearchBarTextField

// leftView 偏倚设置
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += (self.frame.size.width/2-70); // 像右边偏
    return iconRect;
}

// UITextField 文字与输入框的距离
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset(bounds, 0, 0);
//}
//
//// 控制文本的位置
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset(bounds, 0, 0);
//}
//
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 140, 0);
}

@end
