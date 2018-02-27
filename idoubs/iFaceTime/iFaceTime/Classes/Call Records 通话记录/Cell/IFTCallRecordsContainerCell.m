//
//  IFTCallRecordsContainerCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/27.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTCallRecordsContainerCell.h"
#import "IFTContactListTableVC.h"

@implementation IFTCallRecordsContainerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTCallRecordsContainerCell";
    IFTCallRecordsContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[IFTCallRecordsContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//#pragma mark - Setter
//
//- (void)setCellShouldScroll:(BOOL)cellShouldScroll {
//    for (IFTContactListTableVC *vc in _childViewControllers) {
//        vc.canScroll = cellShouldScroll;
//        if (!cellShouldScroll) { // 如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
//            vc.tableView.contentOffset = CGPointZero;
//        }
//    }
//    _cellShouldScroll = cellShouldScroll;
//}

@end
