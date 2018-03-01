//
//  IFTAboutCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/1.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTAboutCell.h"

@interface IFTAboutCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFTAboutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTAboutCell";
    IFTAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.titleLabel.text = @"功能介绍";
    } else if (indexPath.row == 1) {
        self.titleLabel.text = @"服务协议";
    } else if (indexPath.row == 2) {
        self.titleLabel.text = @"隐私政策";
    } else if (indexPath.row == 3) {
        self.titleLabel.text = @"版本信息";
    }
    
}

@end
