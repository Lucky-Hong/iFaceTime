//
//  IFTMoreFunctionView.h
//  iFaceTime
//
//  Created by yesdgq on 2018/3/5.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectRowBlock)(NSIndexPath *indexPath);

@interface IFTMoreFunctionView : UIView

@property (nonatomic, copy) SelectRowBlock selectRowBlock;

@end
