/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  IFTContactCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/13.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactCell.h"

@interface IFTContactCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation IFTContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        self.accessoryType = UITableViewCellAccessoryNone;
//    }
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTContactCell";
    IFTContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    cell.multipleSelectionBackgroundView = [UIView new];
    cell.tintColor = [UIColor colorWithHex:@"#40C953"];
    return cell;
}

- (void)setContactModel:(IFTContactModel *)contactModel {
    _nameLabel.text = contactModel.name;
    [_avatarIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Default_Icon"]];
    _contactModel = contactModel;
}

@end
