//
//  IFTMineInfoSection2Cell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineInfoSection2Cell.h"

@interface IFTMineInfoSection2Cell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeIV;

@end

@implementation IFTMineInfoSection2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTMineInfoSection2Cell";
    IFTMineInfoSection2Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _titleLabel.text = @"账户名称";
        _contectLabel.text = @"可爱的小黄鸭";
        _qrCodeIV.hidden = YES;
    } else if (indexPath.row == 1) {
        _titleLabel.text = @"CA卡号";
        _contectLabel.text = @"8897000083138421";
        _qrCodeIV.hidden = YES;
    } else {
        _titleLabel.text = @"我的二维码";
        _contectLabel.hidden = YES;
    }
}

@end
