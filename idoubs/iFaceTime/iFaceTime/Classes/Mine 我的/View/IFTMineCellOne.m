//
//  IFTMineCellOne.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/28.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineCellOne.h"

@interface IFTMineCellOne()

@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UISwitch *featureSwitch;

@end

@implementation IFTMineCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _featureSwitch.transform = CGAffineTransformMakeScale( 0.8, 0.8); // 缩放
    _featureSwitch.onTintColor = [UIColor colorWithHex:@"#00AEFF"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTMineCellOne";
    IFTMineCellOne *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _promptLabel.hidden = YES;
        [_leftIV setImage:[UIImage imageNamed:@"NoDistrub"]];
        _titleLabel.text = @"陌生人勿扰";
    } else {
        _promptLabel.hidden = NO;
        [_leftIV setImage:[UIImage imageNamed:@"FamilyCloud"]];
        _titleLabel.text = @"家庭云账户";
    }
    _featureSwitch.tag = indexPath.row;
}

- (IBAction)changeSwitchStatus:(id)sender {
    UISwitch *featureSwitch = sender;
    if (featureSwitch.isOn && featureSwitch.tag == 1) {
        _promptLabel.hidden = NO;
    } else {
        _promptLabel.hidden = YES;
    }
}


@end
