//
//  IFTMyQrCodeVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/9.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMyQrCodeVC.h"
#import "ZXingWrapper.h"

@interface IFTMyQrCodeVC ()

@property (nonatomic, strong) UIView *qrBgView;
@property (nonatomic, strong) UIImageView* qrImgView;
@property (nonatomic, strong) UIImageView* logoImgView;

@end

@implementation IFTMyQrCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"我的二维码";
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)setupSubViews {
    UIView *qrCodeBg = [[UIView alloc] initWithFrame:CGRectMake( (CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)*4/5)/2, 160, CGRectGetWidth(self.view.frame)*4/5, CGRectGetWidth(self.view.frame)*4/5)];
    [self.view addSubview:qrCodeBg];
    qrCodeBg.center = self.view.center;
    qrCodeBg.backgroundColor = [UIColor whiteColor];
    qrCodeBg.layer.shadowOffset = CGSizeMake(0, 2);
    qrCodeBg.layer.shadowRadius = 2;
    qrCodeBg.layer.shadowColor = [UIColor blackColor].CGColor;
    qrCodeBg.layer.shadowOpacity = 0.5;
    
    
    _qrImgView = [[UIImageView alloc] init];
    _qrImgView.frame = CGRectMake(0, 0, CGRectGetWidth(qrCodeBg.frame), CGRectGetWidth(qrCodeBg.frame));
    _qrImgView.center = CGPointMake(CGRectGetWidth(qrCodeBg.frame)/2, CGRectGetHeight(qrCodeBg.frame)/2);
    [qrCodeBg addSubview:_qrImgView];
    _qrImgView.backgroundColor = [UIColor redColor];
    self.qrBgView = qrCodeBg;
    
    [self createQRCodeWithContent:@"20002" avatar:@"Image-12"];
}

- (void)createQRCodeWithContent:(NSString *)contentStr avatar:(NSString *)img {
    _qrImgView.image = [ZXingWrapper createCodeWithString:contentStr size:_qrImgView.bounds.size CodeFomart:kBarcodeFormatQRCode];
    
    CGSize logoSize = CGSizeMake(30, 30);
    self.logoImgView = [self roundCornerWithImage:[UIImage imageNamed:img] size:logoSize];
    _logoImgView.bounds = CGRectMake(0, 0, logoSize.width, logoSize.height);
    _logoImgView.center = CGPointMake(CGRectGetWidth(_qrImgView.frame)/2, CGRectGetHeight(_qrImgView.frame)/2);
    [_qrImgView addSubview:_logoImgView];
}

- (UIImageView*)roundCornerWithImage:(UIImage*)logoImg size:(CGSize)size {
    // logo圆角
    UIImageView *backImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    backImage.frame = CGRectMake(0, 0, size.width, size.height);
    backImage.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    logImage.image =logoImg;
    CGFloat diff  =2;
    logImage.frame = CGRectMake(diff, diff, size.width - 2 * diff, size.height - 2 * diff);
    
    [backImage addSubview:logImage];
    
    return backImage;
}

@end
