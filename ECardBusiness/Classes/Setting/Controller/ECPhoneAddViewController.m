//
//  ECPhoneAddViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/7.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECPhoneAddViewController.h"
#import "YSTextField.h"
#import "BRStringPickerView.h"
#import "ECAddressReqModel.h"
#import "ECSettingService.h"
#import "ECLoginService.h"

@interface ECPhoneAddViewController ()
/** 电话号码 */
@property (nonatomic, strong) YSTextField *contactTextField;
@end

@implementation ECPhoneAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加电话号码";
    self.view.backgroundColor = UIColorMain_Bg;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil hightlightedImage:nil title:@"保存" titleColor:UIColorMain_Gray target:self selector:@selector(saveClick)];
    
    _contactTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, 74, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_contactTextField setPlaceholder:@"公司联系电话" floatingTitle:@"公司联系电话"];
    [self.view addSubview:_contactTextField];
}

#pragma mark - 私有方法

- (void)saveClick {
    if (_contactTextField.text.length == 0 ) {
        [_contactTextField setErrorShow:YES errorTitle:@"公司联系电话"];
        [MBProgressHUD showToast:@"公司联系电话"];
        return;
    }
    
    [MBProgressHUD showMessage:@"loading"];
    [ECSettingService addressPhoneUpdateWithStoreId:self.storeId contact:_contactTextField.text success:^(ECAddressModel *model) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

@end
