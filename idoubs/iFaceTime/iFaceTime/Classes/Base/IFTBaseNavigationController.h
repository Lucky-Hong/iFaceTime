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
//  IFTBaseNavigationController.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/9.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTBaseNavigationController : UINavigationController

@property (nonatomic, strong) UIPanGestureRecognizer *popRecognizer;

@end
