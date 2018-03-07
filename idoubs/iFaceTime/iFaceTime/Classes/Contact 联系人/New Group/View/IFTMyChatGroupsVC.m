//
//  IFTMyChatGroupsVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/7.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMyChatGroupsVC.h"
#import "IFTManageGroupsCell.h"
#import "IFTSearchBarView.h"

@interface IFTMyChatGroupsVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation IFTMyChatGroupsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"我的群组";
    
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setUpSubViews {
    self.dataArray = [NSMutableArray arrayWithObjects:@"美丽画", @"亲情通话", @"紧急会议", @"不见不散", nil];
    [self.view addSubview:self.tableView];

}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64-50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        _tableView.tableFooterView = [UIView new];
        
        // tableHeaderView
        UIView *tableHeadBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 51)];
        tableHeadBgView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        self.tableView.tableHeaderView = tableHeadBgView;
        IFTSearchBarView *searchBar = [[IFTSearchBarView alloc] init];
        [tableHeadBgView addSubview:searchBar];
        [searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tableView.tableHeaderView.mas_left).offset(15);
            make.right.equalTo(self.tableView.tableHeaderView.mas_right).offset(-15);
            make.centerY.equalTo(self.tableView.tableHeaderView.mas_centerY);
            make.height.equalTo(@32);
        }];    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTManageGroupsCell *cell = [IFTManageGroupsCell cellWithTableView:tableView];
    [cell setModel:self.dataArray indexPath:indexPath];
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
