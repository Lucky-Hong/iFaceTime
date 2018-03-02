//
//  IFTMineInfo.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineInfo.h"
#import "IFTMineInfoSection1Cell.h"
#import "IFTMineInfoSection2Cell.h"
#import "IFTMineInfoSection3Cell.h"

@interface IFTMineInfo () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTMineInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"个人信息";
    
    [self.view addSubview:self.tableView];
   
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMineInfoSection1Cell *cell = [IFTMineInfoSection1Cell cellWithTableView:tableView];
        return cell;
    } else if (indexPath.section == 1) {
        IFTMineInfoSection2Cell *cell = [IFTMineInfoSection2Cell cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    } else {
        IFTMineInfoSection3Cell *cell = [IFTMineInfoSection3Cell cellWithTableView:tableView];
        return cell;
    }
    
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    } else if (indexPath.section ==1) {
        return 50;
    } else {
        return 250;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    
}

@end
