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
#import "IFTEditContactVC.h"

@interface IFTContactDetailInfoVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTContactDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人详情";
    
    [self.view addSubview:self.tableView];
    [self setupBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupBottomView {
    IFTContactInfoBottomControl *bottomControl = [[NSBundle mainBundle] loadNibNamed:@"IFTContactInfoBottomControl" owner:nil options:nil][0];
    [self.view addSubview:bottomControl];
    [bottomControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@65);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64-65) style:UITableViewStylePlain];
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
    return [self setupSectionHeaderView:section];
}

#pragma mark - ScrollViewDelegate  重载使sectionHeader跟着滑动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 25;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UIView *)setupSectionHeaderView:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.textColor = [UIColor colorWithHex:@"#333333"];
    leftLabel.font = [UIFont systemFontOfSize:12];
    leftLabel.text = @"2018年02月28日";
    [view addSubview:leftLabel];
    [leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.height.equalTo(view);
    }];
    
    return view;
}

#pragma mark - IBOutlet

- (IBAction)makeCall:(id)sender {
    DONG_Log(@"打电话");
}

- (IBAction)editContantInfo:(id)sender {
    IFTEditContactVC *editVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"IFTEditContactVC.h");
    [self.navigationController pushViewController:editVC animated:YES];
}

- (IBAction)shareContant:(id)sender {
    DONG_Log(@"分享");
}

- (IBAction)deleteCallRecords:(id)sender {
    DONG_Log(@"清空记录");
}

@end
