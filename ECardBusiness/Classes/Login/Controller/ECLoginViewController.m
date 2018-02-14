//
//  ECLoginViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/17.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECLoginViewController.h"
#import "YSTextField.h"
#import "ECFooterButtonView.h"
#import "ECRegisterViewController.h"
#import "ECLoginService.h"
#import "ECForgetPwdViewController.h"

#import "JVFloatLabeledTextField.h"

@interface ECLoginViewController ()
/** email */
@property (nonatomic, strong) YSTextField *emailTextField;
/** psw */
@property (nonatomic, strong) YSTextField *passwordTextField;
@end

@implementation ECLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setupFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setupUI {
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 44) * 0.5, 52, 44, 44)];
    iconImageView.image = [UIImage imageNamed:@"common_logo"];
    [self.view addSubview:iconImageView];
    
    _emailTextField = [[YSTextField alloc] initWithFrame:CGRectMake(30, iconImageView.bottom + 120, SCREEN_WIDTH - 60, 65)];
    [_emailTextField setPlaceholder:@"Email" floatingTitle:@"Email"];
    [self.view addSubview:_emailTextField];
    
    _passwordTextField = [[YSTextField alloc] initWithFrame:CGRectMake(_emailTextField.left, _emailTextField.bottom, _emailTextField.width, 65)];
    [_passwordTextField setPlaceholder:@"密码" floatingTitle:@"密码"];
    [_passwordTextField.textField setSecureTextEntry:YES];
    [self.view addSubview:_passwordTextField];
    @weakify(self);
    [_passwordTextField setRightButtonWithTitle:@"忘记密码？" block:^{
        @strongify(self);
        ECForgetPwdViewController *forgetPwdVC = [[ECForgetPwdViewController alloc] init];
        [self.navigationController pushViewController:forgetPwdVC animated:YES];
    }];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 117 - 20, SCREEN_WIDTH, 20)];
    [registerButton setTitle:@"新用户？立即注册" forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [registerButton setTitleColor:UIColorMain_Highlighted forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"登录"];
    [self.view addSubview:footerButtonView];
    @weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        @strongify(self);
        if (self.emailTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入Email"];
            return;
        }
        if (self.passwordTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入密码"];
            return;
        }
        
        [MBProgressHUD showMessage:@"loading"];
        [ECLoginService loginWithEmail:self.emailTextField.text pwd:self.passwordTextField.text success:^(ECAccountModel *responseObj) {
            @strongify(self);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:errorMsg];
        }];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)registerButtonClick {
    ECRegisterViewController *registerVC = [[ECRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
