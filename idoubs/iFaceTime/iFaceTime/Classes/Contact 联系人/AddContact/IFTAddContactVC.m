//
//  IFTAddContactVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTAddContactVC.h"
#import "IFTAddContactCell.h"

@interface IFTAddContactVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation IFTAddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"添加联系人";
    
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setUpSubViews {
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 210) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
        
    // tableHeaderView
        UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
        headerBgView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        _tableView.tableHeaderView = headerBgView;
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"手机号/昵称/CA卡号";
        textField.font = [UIFont systemFontOfSize:14];
        textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.backgroundColor = [UIColor whiteColor];
        [headerBgView addSubview:textField];
        _searchTextField = textField;
        [textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(headerBgView);
            make.height.equalTo(@40);
            make.centerY.equalTo(headerBgView);
        }];
        
    
        
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTAddContactCell *cell = [IFTAddContactCell cellWithTableView:tableView];
    [cell setModel:nil index:indexPath];
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        IFTAboutVC *aboutVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"IFTAboutVC");
//        [self.navigationController pushViewController:aboutVC animated:YES];
//    } else if (indexPath.section == 1 && indexPath.row == 1) {
//
//    } else if (indexPath.section == 1 && indexPath.row == 2) {
//
//    }
}

@end
