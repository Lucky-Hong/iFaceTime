//
//  IFTBaseTableView.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/25.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTBaseTableView.h"

@implementation IFTBaseTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
