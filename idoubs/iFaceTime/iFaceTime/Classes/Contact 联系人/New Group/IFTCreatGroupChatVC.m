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
#import "IFTMyChatGroupsVC.h"

@interface IFTCreatGroupChatVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *startGroupChatBtn;

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation IFTCreatGroupChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"创建群聊";
    [self setupTitleLabel];
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_startGroupChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}

- (void)setupTitleLabel {
    // 创建一个Label
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    _titleLabel = titleLabel;
    // 设置文字居中显示
    titleLabel.textAlignment = NSTextAlignmentCenter;
    // 设置titleLabel自动换行
    titleLabel.numberOfLines = 0;
    // 设置有属性的text
    titleLabel.attributedText = [self getTitleStringWithRemainingAmount:4];
    // 设置导航栏的titleView
    self.navigationItem.titleView = titleLabel;
}

- (NSMutableAttributedString *)getTitleStringWithRemainingAmount:(NSInteger)remainingAmount {
    NSString *prefix = @"创建群聊";
    NSString *remainingAmountTitile = [NSString stringWithFormat:@"可邀请（%ld）人", (long)remainingAmount];
    // 获取标题的字符串
    NSString * str = [NSString stringWithFormat:@"%@\n%@", prefix, remainingAmountTitile];
    // 创建一个带有属性的字符串比如说颜色，字体等文字的属性
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    // 字体大小
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:[str rangeOfString:remainingAmountTitile]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:[str rangeOfString:prefix]];
    // 颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[str rangeOfString:remainingAmountTitile]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[str rangeOfString:prefix]];
    
    return attrStr;
}

- (void)setUpSubViews {
    [self.view addSubview:self.tableView];
    
    UIButton *startGroupChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startGroupChatBtn setBackgroundImage:[UIImage imageNamed:@"StartGroupChatBtnBG"] forState:UIControlStateNormal];
    [startGroupChatBtn setTitle:@"发起群聊" forState:UIControlStateNormal];
    startGroupChatBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    startGroupChatBtn.titleLabel.textColor = [UIColor whiteColor];
    startGroupChatBtn.enabled = NO;
    _startGroupChatBtn = startGroupChatBtn;
    [self.view addSubview:startGroupChatBtn];
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
    NSArray *selectedArray = [tableView indexPathsForSelectedRows];
    if (selectedArray.count > 0) {
        if (selectedArray.count > 4) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [MBProgressHUD showError:@"群组成员已满"];
            return;
        }
        _titleLabel.attributedText = [self getTitleStringWithRemainingAmount:4-selectedArray.count];
        _startGroupChatBtn.enabled = YES;
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedArray = [tableView indexPathsForSelectedRows];
    if (selectedArray.count == 0) {
        _startGroupChatBtn.enabled = NO;
    }
    _titleLabel.attributedText = [self getTitleStringWithRemainingAmount:4-selectedArray.count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)selectGroupExisting:(id)sender {
    IFTMyChatGroupsVC *myGroupsVC = [[IFTMyChatGroupsVC alloc] init];
    [self.navigationController pushViewController:myGroupsVC animated:YES];
}


@end
