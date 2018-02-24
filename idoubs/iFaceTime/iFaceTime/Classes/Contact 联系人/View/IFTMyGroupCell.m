//
//  IFTMyGroupCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/13.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMyGroupCell.h"
#import "IFTSection1Model.h"

@interface IFTMyGroupCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFTMyGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTMyGroupCell";
    IFTMyGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nonnull id)model IndexPath:(nullable NSIndexPath *)indexPath {
    NSArray *dataArray = model;
    IFTSection1Model *dataModel = dataArray[indexPath.row];
    [self.iconIV setImage:[UIImage imageNamed:dataModel.iconName]];
    self.titleLabel.text = dataModel.title;
}

@end
