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
//  IFTSearchBarView.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTSearchBarView.h"

@implementation IFTSearchBarView

{
    UIImageView *_leftView;
    UILabel *_placeHolderLaber;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setViews];
    }
    
    return self;
}

/**
 * ios11 导航栏中masonry布局会有冲突
 * 不能使用masonry
 */
- (void)setViews {
    // 搜索textField
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth
                                                              (self.frame)-30, 29)];
    _searchTF.delegate = self;
    _searchTF.borderStyle = UITextBorderStyleNone;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.enablesReturnKeyAutomatically = YES;
    _searchTF.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
//    _searchTF.placeholder =  @"搜索";
    //    _searchTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.textColor =[UIColor colorWithHex:@"#AAAAAA"];
    _searchTF.font = [UIFont systemFontOfSize:14.f];
    _searchTF.tintColor = [UIColor colorWithHex:@"#02a2e5"];
    
    //    [_searchTF setValue:[UIColor colorWithHex:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_searchTF setValue:[UIFont systemFontOfSize:12.f] forKeyPath:@"_placeholderLabel.font"];
    
    [self addSubview:_searchTF];
    [_searchTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    // 搜索图标 leftView
    _leftView = [[UIImageView alloc] init];
    _leftView.image = [UIImage imageNamed:@"Search"];
    _leftView.contentMode = UIViewContentModeCenter;
    [self addSubview:_leftView];
    [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-30);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(_leftView.image.size);
    }];
    // placeHolder
    _placeHolderLaber = [[UILabel alloc] init];
    _placeHolderLaber.text = @"搜索";
    _placeHolderLaber.textColor = [UIColor colorWithHex:@"#AAAAAA"];
    _placeHolderLaber.font = [UIFont systemFontOfSize:14.f];
    _placeHolderLaber.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_placeHolderLaber];
    [_placeHolderLaber mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftView).offset(13);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    self.layer.cornerRadius = 6;
    self.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![string isEqualToString:@""]) {
        _leftView.hidden = YES;
        _placeHolderLaber.hidden = YES;
    }
    if ([string isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _leftView.hidden = NO;
        _placeHolderLaber.hidden = NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _leftView.hidden = NO;
    _placeHolderLaber.hidden = NO;
    return YES;
}

@end
