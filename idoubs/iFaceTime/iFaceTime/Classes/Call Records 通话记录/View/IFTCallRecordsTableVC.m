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




@end
