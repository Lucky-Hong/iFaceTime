//
//  IFTEditContactVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/7.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTEditContactVC.h"

@interface IFTEditContactVC ()

@end

@implementation IFTEditContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"编辑联系人";
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)selectGroup:(id)sender {
    DONG_Log(@"选择分组");
}

- (IBAction)deleteContact:(id)sender {
    
}

- (IBAction)commitEditInfo:(id)sender {
    
}

@end
