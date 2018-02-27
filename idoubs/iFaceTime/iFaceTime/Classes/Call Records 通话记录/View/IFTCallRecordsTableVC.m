//
//  IFTCallRecordsTableVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/25.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTCallRecordsTableVC.h"
#import "IFTCallRecordsCell.h"

@interface IFTCallRecordsTableVC ()

@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation IFTCallRecordsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 25;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTCallRecordsCell *cell = [IFTCallRecordsCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DONG_Log(@"===============");
    
}

#pragma mark - UIScrollView

// 判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    DONG_Log(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    DONG_Log(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //                if (!self.fingerIsTouch) {// 这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //                    return;
        //                }
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CallRecordsLeaveTop" object:nil]; // 到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll? YES:NO;
}



@end
