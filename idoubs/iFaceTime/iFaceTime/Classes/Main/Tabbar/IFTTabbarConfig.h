//
//  IFTTabbarConfig.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface IFTTabbarConfig : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;

@end
