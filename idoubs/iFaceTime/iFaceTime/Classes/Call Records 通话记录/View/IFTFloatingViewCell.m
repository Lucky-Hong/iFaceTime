//
//  IFTFloatingViewCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/5.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTFloatingViewCell.h"

@interface IFTFloatingViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFTFloatingViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTFloatingViewCell";
    IFTFloatingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model indexPath:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [_leftIV setImage:[UIImage imageNamed:@"AddContact"]];
        _titleLabel.text = @"添加联系人";
    } else if (indexPath.row == 1) {
        [_leftIV setImage:[UIImage imageNamed:@"DeleteRecords"]];
        _titleLabel.text = @"清空记录";
    }
}

@end
