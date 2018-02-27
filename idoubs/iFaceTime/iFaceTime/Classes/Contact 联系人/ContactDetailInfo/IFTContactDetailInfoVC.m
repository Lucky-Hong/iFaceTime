//
//  IFTContactDetailInfoVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/27.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactDetailInfoVC.h"
#import "IFTContactInfoCell.h"
#import "ITFContactInfoHeadBgView.h"
#import "IFTContactInfoBottomControl.h"

@interface IFTContactDetailInfoVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTContactDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人详情";
    
    [self.view addSubview:self.tableView];
    
    IFTContactInfoBottomControl *bottomControl = [[NSBundle mainBundle] loadNibNamed:@"IFTContactInfoBottomControl" owner:nil options:nil][0];
    [self.view addSubview:bottomControl];
    [bottomControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@80);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = [UIView new];
        
        ITFContactInfoHeadBgView *headView = [[NSBundle mainBundle] loadNibNamed:@"ITFContactInfoHeadBgView" owner:nil options:nil][0];
        self.tableView.tableHeaderView = headView;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTContactInfoCell *cell = [IFTContactInfoCell cellWithTableView:tableView];
    
    
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
    
}
- (IBAction)makeCall:(id)sender {
    DONG_Log(@"打电话");
}

- (IBAction)editContantInfo:(id)sender {
    DONG_Log(@"编辑");
}

- (IBAction)shareContant:(id)sender {
    DONG_Log(@"分享");
}

- (IBAction)deleteCallRecords:(id)sender {
    DONG_Log(@"清空记录");
}

@end
