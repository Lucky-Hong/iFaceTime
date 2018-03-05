//
//  IFTAddContactCell.h
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTAddContactCell : UITableViewCell

+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;
- (void)setModel:(nullable id)model indexPath:(nullable NSIndexPath *)indexPath;

@end
