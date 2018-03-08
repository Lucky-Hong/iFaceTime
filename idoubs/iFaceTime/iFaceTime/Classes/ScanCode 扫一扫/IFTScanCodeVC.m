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
//  IFTScanCodeVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTScanCodeVC.h"
//#import "DTHScanQRCodesVC.h"
//#import "LBXScanResult.h"
//#import "LBXScanWrapper.h"
#import "LBXScanVideoZoomView.h"
#import "LBXScanViewController.h"

@interface IFTScanCodeVC ()

@end

@implementation IFTScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"扫一扫";
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor blackColor];
    // 返回键
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.frame = CGRectMake(10, 30, 30, 20);
    goBackBtn.enlargedEdge = 15;
    [goBackBtn setImage:[UIImage imageNamed:@"GoBack"] forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackBtn];
    // titile
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"扫一扫";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(goBackBtn);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
}

- (void)goBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
