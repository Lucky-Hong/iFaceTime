//
//  IFTMineInfoSection3Cell.h
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTMineInfoSection3Cell : UITableViewCell

+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;
- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath;

@end
