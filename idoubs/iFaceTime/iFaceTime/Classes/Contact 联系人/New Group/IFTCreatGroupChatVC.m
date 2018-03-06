//
//  IFTCreatGroupChatVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/6.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTCreatGroupChatVC.h"
#import "IFTContactCell.h"
#import "IFTCreatGroupChatHeaderView.h"

@interface IFTCreatGroupChatVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation IFTCreatGroupChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"创建群聊";
    
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
    UIButton *startGroupChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startGroupChatBtn setBackgroundImage:[UIImage imageNamed:@"StartGroupChatBtnBG"] forState:UIControlStateNormal];
    [startGroupChatBtn setTitle:@"发起群聊" forState:UIControlStateNormal];
    startGroupChatBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    startGroupChatBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:startGroupChatBtn];
    [startGroupChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64-50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        _tableView.tableFooterView = [UIView new];
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        [_tableView setEditing:YES];
        
        IFTCreatGroupChatHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"IFTCreatGroupChatHeaderView" owner:nil options:nil][0];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTContactCell *cell = [IFTContactCell cellWithTableView:tableView];
//    [cell setModel:self.dataArray indexPath:indexPath];
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#EBEBF2"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DONG_Log(@"------------------------");
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
