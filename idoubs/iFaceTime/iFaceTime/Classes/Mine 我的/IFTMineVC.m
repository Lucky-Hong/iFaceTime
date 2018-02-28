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
//  IFTMineVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineVC.h"
#import "IFTMineHeaderView.h"
#import "IFTMineCellTwo.h"
#import "IFTMineCellOne.h"


@interface IFTMineVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"我的";
    
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
        float height = IPHONE_X ? kMainScreenHeight-64-65-169:kMainScreenHeight-64-49-169;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // tableHeaderView
        IFTMineHeaderView *headView = [[NSBundle mainBundle] loadNibNamed:@"IFTMineHeaderView" owner:nil options:nil][0];
        self.tableView.tableHeaderView = headView;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMineCellOne *cell = [IFTMineCellOne cellWithTableView:tableView];
        return cell;
    } else {
       IFTMineCellTwo *cell = [IFTMineCellTwo cellWithTableView:tableView];
        return cell;
    }
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 55;
    }
    if (indexPath.section == 1) {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (IBAction)viewContactDetailInfo:(id)sender {
    
    DONG_Log(@"查看详情");
}


@end
