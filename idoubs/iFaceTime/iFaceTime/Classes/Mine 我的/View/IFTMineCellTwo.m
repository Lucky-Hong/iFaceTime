//
//  IFTMineCellTwo.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/28.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineCellTwo.h"


@interface IFTMineCellTwo()

@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFTMineCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTMineCellTwo";
    IFTMineCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [_leftIV setImage:[UIImage imageNamed:@"About"]];
        _titleLabel.text = @"关于我们";
    } else if (indexPath.row == 1) {
        [_leftIV setImage:[UIImage imageNamed:@"Update"]];
        _titleLabel.text = @"检查更新";
    } else {
        [_leftIV setImage:[UIImage imageNamed:@"Share"]];
        _titleLabel.text = @"分享亲情通话";
    }
}

@end
