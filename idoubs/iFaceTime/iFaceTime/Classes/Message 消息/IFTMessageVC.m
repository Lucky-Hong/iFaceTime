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
//  IFTMessageVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMessageVC.h"
#import "IFTSearchBarView.h"
#import "IFTMessageCell.h"
#import "IFTMessageSectionHeaderView.h"
#import <objc/runtime.h>

@interface IFTMessageVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groupDataArray;
@property (nonatomic, assign) BOOL section1IsOpened;
@property (nonatomic, assign) BOOL section2IsOpened;

@end

@implementation IFTMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"消息";
    [self.navigationController.tabBarItem setBadgeValue:@"1"];
    
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
    _section1IsOpened = YES;
    [self.view addSubview:self.tableView];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        float height = IPHONE_X ? kMainScreenHeight-64-65:kMainScreenHeight-64-49;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
        }];
       
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_section1IsOpened == YES) {
            return 6;
        } else {
            return 0;
        }
    } else {
        if (_section2IsOpened == YES) {
            return 2;
        } else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMessageCell *cell = [IFTMessageCell cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    } else {
        IFTMessageCell *cell = [IFTMessageCell cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    }
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 60;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self drawSectionHeaderView:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

static char rightViewKey;
- (IFTMessageSectionHeaderView *)drawSectionHeaderView:(NSInteger)section {
    UIView *headerBgView = [UIView new];
    headerBgView.backgroundColor = [UIColor whiteColor];
    IFTMessageSectionHeaderView *sectionHeaderView = [[NSBundle mainBundle] loadNibNamed:@"IFTMessageSectionHeaderView" owner:nil options:nil][0];
    sectionHeaderView.sectionHeaderButton.tag = section;
    if (section == 0) {
        [sectionHeaderView.leftIV setImage:[UIImage imageNamed:@"AddContact"]];
        sectionHeaderView.titleLabel.text = @"好友添加信息";
        if (_section1IsOpened) {
            sectionHeaderView.rightIV.transform = CGAffineTransformRotate(sectionHeaderView.rightIV.transform, M_PI); // 在现在的基础上旋转指定角度
        }
    } else if (section == 1) {
        [sectionHeaderView.leftIV setImage:[UIImage imageNamed:@"Exchange"]];
        sectionHeaderView.titleLabel.text = @"交易提醒";
        if (_section2IsOpened) {
            sectionHeaderView.rightIV.transform = CGAffineTransformRotate(sectionHeaderView.rightIV.transform, M_PI); // 在现在的基础上旋转指定角度
        }
    }
    
    // 关联函数
    objc_setAssociatedObject(sectionHeaderView.sectionHeaderButton, &rightViewKey, sectionHeaderView.rightIV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return sectionHeaderView;
}


- (IBAction)clickSectionHeader:(id)sender {
    UIButton *button = sender;
    UIImageView *rightView = objc_getAssociatedObject(sender, &rightViewKey);
    if (button.tag == 0) {
        _section1IsOpened = !_section1IsOpened;
    } else {
        _section2IsOpened = !_section2IsOpened;
        
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        rightView.transform = CGAffineTransformRotate(rightView.transform, M_PI); // 在现在的基础上旋转指定角度
    } completion:^(BOOL finished) {
    }];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
