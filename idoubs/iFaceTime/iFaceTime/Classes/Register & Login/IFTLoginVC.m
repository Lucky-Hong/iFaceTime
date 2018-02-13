//
//  IFTLoginVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/8.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTLoginVC.h"
#import "IFTRegisterVC.h"
#import "CustomerTextField.h"
#import "IFTForgetPasswordVC.h"
#import "CYLTabBarController.h"
#import "IFTScanCodeVC.h"
#import "IFTPulsButton.h"
#import "IFTTabbarConfig.h"
#import "AppDelegate.h"

@interface IFTLoginVC () <UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@property (nonatomic, strong) CustomerTextField *telephoneNoTF;
@property (nonatomic, strong) CustomerTextField *passwordTF;

@end

@implementation IFTLoginVC

{
    UIView *line1;
    UIView *line2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextField];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupTextField {
    self.telephoneNoTF = [[CustomerTextField alloc] init];
    self.telephoneNoTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PhoneTF_Left_Icon"]];
    self.telephoneNoTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneNoTF.placeholder = @"请输入手机号";
    self.telephoneNoTF.font = [UIFont systemFontOfSize:14];
    self.telephoneNoTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.telephoneNoTF];
    
    line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHex:@"#C5C5CB"];
    [self.view addSubview:line1];
    
    self.passwordTF = [[CustomerTextField alloc] init];
    self.passwordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Password_Left_Icon"]];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.font = [UIFont systemFontOfSize:14];
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTF];
    
    line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHex:@"#C5C5CB"];
    [self.view addSubview:line2];
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
 
    [self.telephoneNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(269);
        make.size.mas_equalTo(CGSizeMake(180, 20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [line1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.telephoneNoTF.mas_bottom).offset(8);
        make.height.equalTo(@1);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(180, 20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(8);
        make.height.equalTo(@1);
    }];
}

- (IBAction)login:(id)sender {
    [self initializeTabbar];
}



- (IBAction)gotoRegister:(id)sender {
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    IFTRegisterVC *registerVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"IFTRegisterVC");
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (IBAction)fogetPassword:(id)sender {
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    IFTForgetPasswordVC *forgetVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"IFTForgetPasswordVC");
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    DONG_Log(@"有反馈吗");
}

#pragma mark - Tabbar设置

- (void)initializeTabbar {
    [IFTPulsButton registerPlusButton];
    IFTTabbarConfig *tabBarControllerConfig = [[IFTTabbarConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    tabBarController.delegate = self;
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    appDelegate.window.rootViewController = tabBarController;
//    [appDelegate.window makeKeyAndVisible];
    [self customizeInterfaceWithTabBarController:tabBarController];
    [self.navigationController pushViewController:tabBarController animated:YES];
//    [self presentViewController:tabBarController animated:YES completion:nil];
    
}

- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    // 设置导航栏
    //    [self setUpNavigationBarAppearance];
    // 去除 TabBar 自带的顶部阴影 iOS10 后使用
    [tabBarController hideTabBadgeBackgroundSeparator];
    
    @try {
        //        UIView *tabBadgePointView = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
        //        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView];
        //        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
        
        // 添加提示动画，引导用户点击
        [self addScaleAnimationOnView:tabBarController.viewControllers[2].cyl_tabButton.cyl_tabImageView repeatCount:10];
    } @catch (NSException *exception) {}
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

// 缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    // 需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"UserGuide"];
}

// 旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

#pragma mark - CYLTabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    
    if ([control cyl_isTabButton]) {
        // 更改红标状态
        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        } else {
            // [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
        }
        
        animationView = [control cyl_tabImageView];
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
    // 可以关闭用户提示动画
    [animationView.layer removeAnimationForKey:@"UserGuide"];
    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
        [self addScaleAnimationOnView:animationView repeatCount:1];
    } else {
        [self addRotateAnimationOnView:animationView];
    }
}



@end
