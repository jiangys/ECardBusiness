//
//  ECAddressEditViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECAddressEditViewController.h"
#import "YSTextField.h"
#import "BRStringPickerView.h"
#import "ECAddressReqModel.h"
#import "ECSettingService.h"
#import "ECLoginService.h"

@interface ECAddressEditViewController ()
/** 城市 */
@property (nonatomic, strong) YSTextField *cityTextField;
/** 省、州 */
@property (nonatomic, strong) YSTextField *provinceTextField;
/** 省id */
@property (nonatomic, strong) YSTextField *provinceId;
/** 完整地址1 */
@property (nonatomic, strong) YSTextField *address1TextField;
/** 完整地址2 */
@property (nonatomic, strong) YSTextField *address2TextField;
/** 邮编 */
@property (nonatomic, strong) YSTextField *zipCodeTextField;

@property (nonatomic, copy)  NSArray *stateArray;        //
@property (nonatomic) NSUInteger selectedStateIndex;
@end

@implementation ECAddressEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加地址";
    self.view.backgroundColor = UIColorMain_Bg;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil hightlightedImage:nil title:@"保存" titleColor:UIColorMain_Gray target:self selector:@selector(saveClick)];
    
    [self getStateData];
    
    // 地址栏1（公司地址）
    _address1TextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, 74, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_address1TextField setPlaceholder:@"地址栏1（公司地址）" floatingTitle:@"地址栏1（公司地址）"];
    [self.view addSubview:_address1TextField];
    
    // 地址栏2（选填）
    _address2TextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _address1TextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_address2TextField setPlaceholder:@"地址栏2（选填）" floatingTitle:@"地址栏2（选填）"];
    [self.view addSubview:_address2TextField];
    
    // 市
    _cityTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _address2TextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_cityTextField setPlaceholder:@"市" floatingTitle:@"市"];
    [self.view addSubview:_cityTextField];
    
    // 州/省
    _provinceTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _cityTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_provinceTextField setPlaceholder:@"州/省" floatingTitle:@"州/省"];
    [self.view addSubview:_provinceTextField];
    [_provinceTextField.textField setEnabled:NO];
    @weakify(self);
    [_provinceTextField bk_whenTapped:^{
        [self.view endEditing:YES];
        [BRStringPickerView showStringPickerWithTitle:@"请选择州/省" dataSource:[self getStateArray] defaultSelValue:self.provinceTextField.textField.text isAutoSelect:YES resultBlock:^(id selectValue, NSUInteger index) {
            @strongify(self);
            self.provinceTextField.textField.text = selectValue;
            self.selectedStateIndex = index;
        }];
    }];
    
    // 邮政编码
    _zipCodeTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _provinceTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_zipCodeTextField setPlaceholder:@"邮政编码" floatingTitle:@"邮政编码"];
    [self.view addSubview:_zipCodeTextField];
}

#pragma mark - 私有方法

- (void)saveClick {
    if (_address1TextField.text.length == 0 ) {
        [_address1TextField setErrorShow:YES errorTitle:@"请输入公司地址"];
        [MBProgressHUD showToast:@"请输入公司地址"];
        return;
    }
    
    if (_cityTextField.text.length == 0 ) {
        [_cityTextField setErrorShow:YES errorTitle:@"请输入城市"];
        [MBProgressHUD showToast:@"请输入城市"];
        return;
    }
    
    if (_provinceTextField.text.length == 0 ) {
        [_provinceTextField setErrorShow:YES errorTitle:@"请选择州/省"];
        [MBProgressHUD showToast:@"请选择州/省"];
        return;
    }
    
    if (_zipCodeTextField.text.length == 0 ) {
        [_zipCodeTextField setErrorShow:YES errorTitle:@"请输入邮政编码"];
        [MBProgressHUD showToast:@"请输入邮政编码"];
        return;
    }
    
    ECAddressReqModel *addressModel = [[ECAddressReqModel alloc] init];
    addressModel.address1 = _address1TextField.text;
    addressModel.address2 = _address2TextField.text;
    addressModel.stateId = @(self.selectedStateIndex).stringValue;
    addressModel.stateName = _provinceTextField.text;
    addressModel.zipCode = _zipCodeTextField.text;
    addressModel.lat = @"34.0806687";
    addressModel.lng = @"-118.0778257";
    addressModel.cityName = _cityTextField.text;
    
    [MBProgressHUD showMessage:@"loading"];
    [ECSettingService addressSaveWithParam:addressModel success:^(ECAddressModel *model) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMsg) {
         [MBProgressHUD hideHUD];
    }];
}

- (void)getStateData {
    [ECLoginService loginStateTypeWithSuccess:^(NSMutableArray *stateArray) {
        self.stateArray = stateArray;
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD  showToast:@"请求State数据失败"];
    }];
}

- (NSArray *)getStateArray {
    NSMutableArray *stateArray = [NSMutableArray array];
    for (ECStateModel *model in self.stateArray) {
        [stateArray addObject:model.name];
    }
    return stateArray;
}

@end
