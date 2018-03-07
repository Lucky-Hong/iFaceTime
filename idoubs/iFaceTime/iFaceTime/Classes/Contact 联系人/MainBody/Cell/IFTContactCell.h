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
//  IFTContactCell.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/13.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFTContactModel.h"

@interface IFTContactCell : UITableViewCell

@property (nonatomic, strong) IFTContactModel *contactModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
