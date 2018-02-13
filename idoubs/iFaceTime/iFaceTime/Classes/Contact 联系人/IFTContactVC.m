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

@interface IFTContactVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"联系人";
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
            IFTMyGroupCell *cell = [IFTMyGroupCell cellWithTableView:tableView];
            return cell;
        
    } else if (indexPath.section == 1) {
            IFTContactCell *cell = [IFTContactCell cellWithTableView:tableView];
        
            return cell;
            
        }
    return nil;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    return 40;
    } else {
        return kMainScreenHeight - 64 - 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    if (section == 1) {
        return view;
    } else {
        return nil;
    }
}

// headerView
- (UIView *)drawSectionHeaderView:(NSInteger)section
{
//    UIView *view = [_headerViewArray objectAtIndex:section];
//    if ([view isKindOfClass:[UIView class]]) {
//        return view;
//    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
//        headerView.backgroundColor = [UIColor colorWithHex:DTH_BackgroundColor2];

        // 按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:headerView.bounds];
        [button setTag:section];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(headerViewPress:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];

        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
//        DTHGroupModel *groupModel = _dataArray[section];
//        titleLabel.text = groupModel.groupName;
        titleLabel.textColor = [UIColor colorWithHex:@""];
        titleLabel.font = [UIFont systemFontOfSize:17.f];
        [headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.left.equalTo(headerView).offset(15);
            make.centerY.equalTo(headerView.mas_centerY);

        }];

        // 更多
        UILabel *moreLabel = [[UILabel alloc] init];
//        moreLabel.text = groupModel.isOpened? @"收起" : @"更多";
        moreLabel.textColor = [UIColor colorWithHex:@""];
        moreLabel.font = [UIFont systemFontOfSize:17.f];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        //    moreLabel.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.right.equalTo(headerView).offset(-30);
            make.centerY.equalTo(headerView.mas_centerY);

        }];

        // 箭头
        UIImageView *arrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_Right"]];
        // 如果是打开 图片要先旋转 刷新section是会重新调用这里
//        if (groupModel.isOpened) {
//            arrowIV.transform = CGAffineTransformRotate(arrowIV.transform, M_PI/2); // 在现在的基础上旋转指定角度
//        }

        // 关联函数
//        objc_setAssociatedObject(button, &arrowIVKey, arrowIV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        [headerView addSubview:arrowIV];
//        [arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(24, 24));
//            make.right.equalTo(headerView).offset(-15);
//            make.centerY.equalTo(headerView.mas_centerY);
//
//        }];
//        [_headerViewArray replaceObjectAtIndex:section withObject:headerView];
        return headerView;
//    }
}

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
