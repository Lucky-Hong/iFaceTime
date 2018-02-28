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
//  IFTMessageVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMessageVC.h"

@interface IFTMessageVC () 

@end

@implementation IFTMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"消息";
//     [self.navigationController.tabBarItem setBadgeValue:@"3"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
