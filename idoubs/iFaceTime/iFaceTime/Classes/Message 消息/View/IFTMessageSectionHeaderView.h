//
//  IFTMessageSectionHeaderView.h
//  iFaceTime
//
//  Created by yesdgq on 2018/3/1.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTMessageSectionHeaderView : UIControl
@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightIV;
@property (weak, nonatomic) IBOutlet UIView *separaor;
@property (weak, nonatomic) IBOutlet UIButton *sectionHeaderButton;

@end
