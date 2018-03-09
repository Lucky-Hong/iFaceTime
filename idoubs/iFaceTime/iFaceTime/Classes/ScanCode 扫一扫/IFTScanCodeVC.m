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
#import "LBXScanVideoZoomView.h"


@interface IFTScanCodeVC ()


@end

@implementation IFTScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    // 设置配置信息
    [self setConfiguration];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
    [self drawBottomItems];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setConfiguration {
    self.cameraInvokeMsg = @"相机启动中";
    // 是否需要扫码图像
    self.isNeedScanImage = NO;
    // 当前选择的扫码库
    self.libraryType = SLT_ZXing;
    // 开启只识别矩形框内图像功能
    self.isOpenInterestRect = YES;
    
    // 创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    // 矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    // 矩形框(视频显示透明区)域离界面左边及右边距离，默认60
    style.xScanRetangleOffset = 60;
    // 默认扫码区域为正方形，如果扫码区域不是正方形，设置宽高比
    style.whRatio = 1;
    // 扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    // 扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 2;
    // 扫码框周围4个角的宽度
    style.photoframeAngleW = 18;
    // 扫码框周围4个角的高度
    style.photoframeAngleH = 18;
    // 显示矩形框
    style.isNeedShowRetangle = YES;
    // 扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    // 线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    // 网格图片
    //style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    // 角标颜色
    style.colorAngle = [UIColor colorWithRed:0./255 green:174./255. blue:255./255. alpha:1.0];
    // 背景颜色
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    self.style = style;
    
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

- (void)drawBottomItems {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 150);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHex:@"#00AEFF"];
    label.text = @"扫描二维码";
    label.font = [UIFont systemFontOfSize:12.f];
    [self.view addSubview:label];
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.equalTo(self.view.mas_top).offset(430);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)goBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 扫码结果

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    if (!array ||  array.count < 1) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    // 可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    NSString *strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }


    [DONG_AlertShowTool presentAlertViewWithTitle:@"扫码结果" message:strResult confirmTitle:@"确定" handler:^{
        [self reStartDevice];
    }];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult {
    if (!strResult) {
        strResult = @"识别失败";
        [DONG_AlertShowTool presentAlertViewWithTitle:@"扫码失败" message:strResult cancelTitle:@"返回" defaultTitle:@"重新扫码" distinct:YES cancel:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } confirm:^{
           [self reStartDevice];
        }];
    }
}




@end
