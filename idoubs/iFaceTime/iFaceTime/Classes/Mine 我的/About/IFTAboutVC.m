//
//  IFTAboutVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/1.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTAboutVC.h"
#import "IFTAboutCell.h"

@interface IFTAboutVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(310);
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 200));
        make.centerX.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        float height = 200;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTAboutCell *cell = [IFTAboutCell cellWithTableView:tableView];
    [cell setModel:nil index:indexPath];
    
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    
}


@end
