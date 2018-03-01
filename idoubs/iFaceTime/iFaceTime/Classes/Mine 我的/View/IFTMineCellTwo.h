//
//  IFTMineCellTwo.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/28.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTMineCellTwo : UITableViewCell

+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;
- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath;

@end
