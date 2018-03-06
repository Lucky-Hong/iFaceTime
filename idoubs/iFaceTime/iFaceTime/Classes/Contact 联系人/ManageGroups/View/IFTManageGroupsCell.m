//
//  IFTManageGroupsCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/5.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTManageGroupsCell.h"

@interface IFTManageGroupsCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFTManageGroupsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTManageGroupsCell";
    IFTManageGroupsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    return cell;
}

- (void)setModel:(nullable id)model indexPath:(nullable NSIndexPath *)indexPath {
    NSArray *dataArray = model;
    if (indexPath.row < dataArray.count) {
        _titleLabel.text = dataArray[indexPath.row];
    }
}

@end
