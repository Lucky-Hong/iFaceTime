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
//  IFTContactVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactVC.h"
#import "CYLTabBarController.h"
#import "IFTMyGroupCell.h"
#import "IFTContactCell.h"
#import "IFTSection1Model.h"
#import "IFTContainerCell.h"
#import "IFTSearchBarView.h"

@interface IFTContactVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *section1ModelArray;


@end

@implementation IFTContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"联系人";
    
    self.section1ModelArray = [NSMutableArray arrayWithCapacity:0];
    IFTSection1Model *myGroupMdoel = [IFTSection1Model initWithTitle:@"我的群组" iconName:@"MyGroup"];
    IFTSection1Model *convenienceServicesMdoel = [IFTSection1Model initWithTitle:@"便民服务" iconName:@"ConvenienceServices"];
    [_section1ModelArray addObject:myGroupMdoel];
    [_section1ModelArray addObject:convenienceServicesMdoel];
    
    [self setupTableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
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

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMyGroupCell *cell = [IFTMyGroupCell cellWithTableView:tableView];
        [cell setModel:_section1ModelArray IndexPath:indexPath];
        return cell;
        
    } else if (indexPath.section == 1) {
        IFTContainerCell *cell = [IFTContainerCell cellWithTableView:tableView];
        return cell;
    }
    return nil;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else {
        return CYL_IS_IPHONE_X ? kMainScreenHeight -64 - 65 : kMainScreenHeight -64 - 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#EBEBF2"];
    if (section == 0) {
        return view;
    } else {
        return nil;
    }
}

// headerView
//- (UIView *)drawSectionHeaderView:(NSInteger)section {
//
//
//}

// sectionHeader点击
- (void)headerViewPress:(UIButton *)sender
{
    //    DTHGroupModel *groupModel = _dataArray[sender.tag];
    //    UIImageView *arrowIV = objc_getAssociatedObject(sender, &arrowIVKey);
    
    //    if (groupModel.isOpened) {
    //
    //        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //            arrowIV.transform = CGAffineTransformRotate(arrowIV.transform, -M_PI/2); // 在现在的基础上旋转指定角度
    //        } completion:^(BOOL finished) {
    //        }];
    //
    //    } else {
    //
    //        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //            arrowIV.transform = CGAffineTransformRotate(arrowIV.transform, M_PI/2); // 在现在的基础上旋转指定角度
    //        } completion:^(BOOL finished) {
    //        }];
    //
    //    }
    //    groupModel.isOpened = !groupModel.isOpened;
    //    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
