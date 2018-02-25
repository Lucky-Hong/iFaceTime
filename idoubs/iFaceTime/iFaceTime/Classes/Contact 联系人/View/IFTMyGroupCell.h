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
//  IFTMyGroupCell.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/13.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTMyGroupCell : UITableViewCell

+ (instancetype _Nullable )cellWithTableView:(UITableView *_Nonnull)tableView;
- (void)setModel:(nonnull id)model IndexPath:(nullable NSIndexPath *)indexPath;

@end
