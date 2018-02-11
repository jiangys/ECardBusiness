//
//  ECForgetPwdViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECForgetPwdViewController.h"
#import "YSTextField.h"
#import "ECFooterButtonView.h"
#import "ECRegisterViewController.h"
#import "ECLoginService.h"

@interface ECForgetPwdViewController ()
@property (nonatomic, strong) YSTextField *emailTextField;
@property (nonatomic, strong) YSTextField *mailCodeTextField;
@end

@implementation ECForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    
    [self setupUI];
    [self setupFooterView];
}

- (void)setupUI {
    _emailTextField = [[YSTextField alloc] initWithFrame:CGRectMake(30, 210, SCREEN_WIDTH - 60, 65)];
    [_emailTextField setPlaceholder:@"Email/手机号" floatingTitle:@"Email/手机号"];
    [self.view addSubview:_emailTextField];
    
    // 验证码
    _mailCodeTextField = [[YSTextField alloc] initWithFrame:CGRectMake(_emailTextField.left, _emailTextField.bottom, _emailTextField.width, 65)];
    [_mailCodeTextField setPlaceholder:@"输入验证码" floatingTitle:@"输入验证码"];
    [self.view addSubview:_mailCodeTextField];
    @weakify(self);
    [_mailCodeTextField setRightButtonWithTitle:@"发送验证码" block:^{
        @strongify(self);
        if (self.emailTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入Email或者手机号"];
            return;
        }
        [MBProgressHUD showMessage:@"正在发送中"];
        [ECLoginService loginCodeWithEmail:self.emailTextField.text success:^(ECAccountModel *responseObj) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:@"发送成功"];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:@"发送失败，请稍后再试"];
        }];
    }];
}

- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"登录"];
    [self.view addSubview:footerButtonView];
    @weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        @strongify(self);
        if (self.emailTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入Email或者手机号"];
            return;
        }
        if (self.mailCodeTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入验证码"];
            return;
        }
        
        [MBProgressHUD showMessage:@"登录中，请稍后"];
        [ECLoginService loginWithEmail:self.emailTextField.text code:self.mailCodeTextField.text success:^(ECAccountModel *responseObj) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:@"登录成功"];
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
