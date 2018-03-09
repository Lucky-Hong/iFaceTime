//
//  IFTCallRecordsContainerCell.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/27.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTCallRecordsContainerCell : UITableViewCell

@property (nonatomic, assign) BOOL cellShouldScroll;

+ (instancetype _Nullable)cellWithTableView:(UITableView *_Nonnull)tableView;

@end
