//
//  IFTCreatGroupChatHeaderView.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/6.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTCreatGroupChatHeaderView.h"
#import "IFTAddContectSearchTextField.h"

@interface IFTCreatGroupChatHeaderView()

@property (nonatomic, strong) IFTAddContectSearchTextField *searchTF;

@end

@implementation IFTCreatGroupChatHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    _searchTF = [[IFTAddContectSearchTextField alloc] init];
    [self addSubview:_searchTF];
    _searchTF.placeholder = @"搜索";
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@50);
    }];
}

@end
