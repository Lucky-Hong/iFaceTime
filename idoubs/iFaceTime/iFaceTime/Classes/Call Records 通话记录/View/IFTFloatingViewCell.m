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
    NSArray *dataArray = model;
    if (indexPath.row < dataArray.count) {
        NSDictionary *dict = dataArray[indexPath.row];
        [_leftIV setImage:[UIImage imageNamed:dict.allKeys.firstObject]];
        _titleLabel.text = dict.allValues.firstObject;
    }
}

@end
