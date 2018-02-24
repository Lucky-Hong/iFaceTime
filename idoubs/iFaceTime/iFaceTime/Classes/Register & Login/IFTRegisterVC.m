/*
 *    |  ___  \    /  ___ \   | |\   | |   / _______|
 *    | |    \ |  | /    \ |  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |___ / /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  IFTRegisterVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/8.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTRegisterVC.h"
#import "UIViewController+BackButtonHandler.h"
#import "CustomerTextField.h"

@interface IFTRegisterVC ()

@property (nonatomic, strong) CustomerTextField *telephoneNoTF;
@property (nonatomic, strong) CustomerTextField *verificationTF;
@property (nonatomic, strong) CustomerTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;

@end

@implementation IFTRegisterVC

{
    UIView *line1;
    UIView *line2;
    UIView *line3;
    UIButton *verificationButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self setupTextField];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.telephoneNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(184);
        make.size.mas_equalTo(CGSizeMake(190, 20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [line1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.telephoneNoTF.mas_bottom).offset(8);
        make.height.equalTo(@1);
    }];
    
    [self.verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(190, 20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.verificationTF.mas_bottom).offset(8);
        make.height.equalTo(@1);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(190, 20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [line3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(8);
        make.height.equalTo(@1);
    }];
    
    [verificationButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-63);
        make.centerY.equalTo(self.verificationTF.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [self.protocolButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
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
    
    self.verificationTF = [[CustomerTextField alloc] init];
    self.verificationTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VerificationCode_Icon"]];
    self.verificationTF.leftViewMode = UITextFieldViewModeAlways;
    self.verificationTF.placeholder = @"请输入验证码";
    self.verificationTF.font = [UIFont systemFontOfSize:14];
    self.verificationTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.verificationTF];
    
    line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHex:@"#C5C5CB"];
    [self.view addSubview:line2];
    
    self.passwordTF = [[CustomerTextField alloc] init];
    self.passwordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Password_Left_Icon"]];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.placeholder = @"密码长度不少于6位";
    self.passwordTF.font = [UIFont systemFontOfSize:14];
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTF];
    
    line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithHex:@"#C5C5CB"];
    [self.view addSubview:line3];
    
    verificationButton = [[UIButton alloc] init];
    [verificationButton setTitle:@"获取" forState:UIControlStateNormal];
    verificationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [verificationButton setTitleColor:[UIColor colorWithHex:@"#FF602B"] forState:UIControlStateNormal];
    [verificationButton addTarget:self action:@selector(gitVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verificationButton];
    
}


- (IBAction)gotoRegister:(id)sender {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)gitVerificationCode {
    
}

#pragma mark - UIViewController Pop 事件拦截代理

- (BOOL)navigationShouldPopOnBackButton {
    return YES;
}



@end
