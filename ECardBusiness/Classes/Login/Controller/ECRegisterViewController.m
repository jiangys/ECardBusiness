//
//  ECRegisterViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/17.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECRegisterViewController.h"
#import "YSTextField.h"
#import "ECFooterButtonView.h"
#import "ECRegisterModel.h"
#import "ECRegisterNextViewController.h"
#import "ECLoginService.h"
#import "ECRegisterTool.h"
#import "BRPickerView.h"
#import <AVFoundation/AVFoundation.h>
#import "ECUploadTool.h"

#define registerViewTextFieldW (SCREEN_WIDTH - 30)

@interface ECRegisterViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
/** 用户填写的注册信息 */
@property (nonatomic, strong) ECRegisterModel *registerModel;
/** 头像地址 */
@property (nonatomic, copy) NSString *avatarUrl;
/** 邮箱 */
@property (nonatomic, strong) YSTextField *emailTextField;
/** 邮箱验证码 */
@property (nonatomic, strong) YSTextField *mailCodeTextField;
/** 公司中文名  */
@property (nonatomic, strong) YSTextField *companyCNNameTextField;
/** 公司英文名 */
@property (nonatomic, strong) YSTextField *companyENNameTextField;
/** 公司类型 */
@property (nonatomic, strong) YSTextField *companyType;
/** 姓 */
@property (nonatomic, strong) YSTextField *lastNameTextField;
/** 名 */
@property (nonatomic, strong) YSTextField *firstNameTextField;
/** 中间名 */
@property (nonatomic, strong) YSTextField *middleNameTextField;
/** 电话 */
@property (nonatomic, strong) YSTextField *phoneTextField;
/** 密码 */
@property (nonatomic, strong) YSTextField *passwordTextField;
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
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, copy)  NSArray *stateArray;        //
@property (nonatomic, copy)  NSArray *companyArray;
@property (nonatomic) NSUInteger selectedCompanyTypeIndex;
@property (nonatomic) NSUInteger selectedStateIndex;
@property (nonatomic, copy)  NSString *imageUrl;
@end

@implementation ECRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(242,246,250);
    self.title = @"注册";
    _registerModel = [ECRegisterTool getRegisterModel];
    
    [self setupCommon];
    [self setupFooterView];
    
    [self getStateData];
    [self getCompanyData];
}

- (void)setupCommon {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    [self.view addSubview:_scrollView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) * 0.5, 15, 60, 60)];
    _iconImageView.image = [UIImage imageNamed:@"login_default_header_icon"];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = _iconImageView.size.width * 0.5;
    [_scrollView addSubview:_iconImageView];
    
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + 10, SCREEN_WIDTH, 16)];
    [headerButton setTitle:@"点击上传图片" forState:UIControlStateNormal];
    [headerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [headerButton setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
    [headerButton addTarget:self action:@selector(headerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:headerButton];
    
    // 邮箱
    _emailTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, headerButton.bottom + 30, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_emailTextField setPlaceholder:@"电子邮件" floatingTitle:@"电子邮件"];
    [_emailTextField setShowText: _registerModel.email];
    [_scrollView addSubview:_emailTextField];
    @weakify(self);
    [_emailTextField setRightButtonWithTitle:@"获取验证码" block:^{
        @strongify(self);
        if (self.emailTextField.text.length == 0) {
            [MBProgressHUD showToast:@"请输入验证码"];
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
    
    // 验证码
    _mailCodeTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _emailTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_mailCodeTextField setPlaceholder:@"输入验证码" floatingTitle:@"输入验证码"];
    [_mailCodeTextField setShowText:_registerModel.mailCode];
    [_scrollView addSubview:_mailCodeTextField];
    
    // 公司类型
    _companyType = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _mailCodeTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_companyType setPlaceholder:@"公司类型" floatingTitle:@"公司类型"];
    [_companyType.textField setEnabled:NO];
    [_scrollView addSubview:_companyType];
    [_companyType bk_whenTapped:^{
        [self.view endEditing:YES];
        [BRStringPickerView showStringPickerWithTitle:@"请选择公司类型" dataSource:[self getCompanyTypeArray] defaultSelValue:self.companyType.textField.text isAutoSelect:YES resultBlock:^(id selectValue, NSUInteger index) {
            @strongify(self);
            self.companyType.textField.text = selectValue;
            self.selectedCompanyTypeIndex = index;
        }];
    }];
    
    // 公司英文名
    _companyENNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _companyType.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_companyENNameTextField setPlaceholder:@"公司英文名" floatingTitle:@"公司英文名"];
    [_companyENNameTextField setShowText:_registerModel.companyENName];
    [_scrollView addSubview:_companyENNameTextField];
    
    // 公司中文名
    _companyCNNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _companyENNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_companyCNNameTextField setPlaceholder:@"公司中文名（选填）" floatingTitle:@"公司中文名（选填）"];
    [_companyCNNameTextField setShowText:_registerModel.companyCNName];
    [_scrollView addSubview:_companyCNNameTextField];
    
    // 姓（公司法人的姓）
    _lastNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _companyCNNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_lastNameTextField setPlaceholder:@"姓（公司法人的姓）" floatingTitle:@"姓（公司法人的姓）"];
    [_lastNameTextField setShowText:_registerModel.lastName];
    [_scrollView addSubview:_lastNameTextField];
    
    // 名（公司法人的名）
    _firstNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _lastNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_firstNameTextField setPlaceholder:@"名（公司法人的名）" floatingTitle:@"名（公司法人的名）"];
    [_firstNameTextField setShowText:_registerModel.firstName];
    [_scrollView addSubview:_firstNameTextField];
    
    // 中间名（公司法人的中间名）选填
    _middleNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _firstNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_middleNameTextField setPlaceholder:@"中间名（公司法人的中间名）选填" floatingTitle:@"中间名（公司法人的中间名）选填"];
    [_middleNameTextField setShowText:_registerModel.middleName];
    [_scrollView addSubview:_middleNameTextField];
    
    // 公司联系电话
    _phoneTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _middleNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_phoneTextField setPlaceholder:@"公司联系电话" floatingTitle:@"公司联系电话"];
    [_phoneTextField setShowText:_registerModel.phone];
    [_scrollView addSubview:_phoneTextField];
    
    // 密码
    _passwordTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _phoneTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_passwordTextField setPlaceholder:@"密码" floatingTitle:@"密码"];
    [_passwordTextField.textField setSecureTextEntry:YES];
    [_passwordTextField setShowText:_registerModel.password];
    [_scrollView addSubview:_passwordTextField];
    
    // 地址栏1（公司地址）
    _address1TextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _passwordTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_address1TextField setPlaceholder:@"地址栏1（公司地址）" floatingTitle:@"地址栏1（公司地址）"];
    [_address1TextField setShowText:_registerModel.address1];
    [_scrollView addSubview:_address1TextField];
    
    // 地址栏2（选填）
    _address2TextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _address1TextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_address2TextField setPlaceholder:@"地址栏2（选填）" floatingTitle:@"地址栏2（选填）"];
    [_address2TextField setShowText:_registerModel.address2];
    [_scrollView addSubview:_address2TextField];
    
    // 市
    _cityTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _address2TextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_cityTextField setPlaceholder:@"市" floatingTitle:@"市"];
    [_cityTextField setShowText:_registerModel.city];
    [_scrollView addSubview:_cityTextField];
    
    // 州/省
    _provinceTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _cityTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_provinceTextField setPlaceholder:@"州/省" floatingTitle:@"州/省"];
    [_provinceTextField setShowText:_registerModel.province];
    [_scrollView addSubview:_provinceTextField];
    [_provinceTextField.textField setEnabled:NO];
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
    [_zipCodeTextField setShowText:_registerModel.zipCode];
    [_scrollView addSubview:_zipCodeTextField];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _zipCodeTextField.bottom);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"下一步"];
    [self.view addSubview:footerButtonView];
    @weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        @strongify(self);
        [self nextButton];
    }];
}

#pragma mark -  私有方法
- (void)getmailCodeButtonClick {
    ECLog(@"获取验证码");
}

- (void)getStateData {
    [ECLoginService loginStateTypeWithSuccess:^(NSMutableArray *stateArray) {
        self.stateArray = stateArray;
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD  showToast:@"请求State数据失败"];
    }];
}

- (void)getCompanyData {
    [ECLoginService loginCompanyTypeWithSuccess:^(NSMutableArray *companyTypeArray) {
        self.companyArray = companyTypeArray;
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD  showToast:@"请求companyType数据失败"];
    }];
}

- (NSArray *)getCompanyTypeArray {
    NSMutableArray *companyTypeArray = [NSMutableArray array];
    for (ECCompanyModel *model in self.companyArray) {
        [companyTypeArray addObject:model.cateName];
    }
    return companyTypeArray;
}

- (NSArray *)getStateArray {
    NSMutableArray *stateArray = [NSMutableArray array];
    for (ECStateModel *model in self.stateArray) {
        [stateArray addObject:model.name];
    }
    return stateArray;
}

#pragma mark - 上传头像
- (void)headerButtonClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf localPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相机
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])//相机
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        NSLog(@"模拟器情况下无法打开");
    }
}

//打开相册
- (void)localPhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//相册
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }
    }
    else{
        NSLog(@"相册打不开应该是出问题了");
    }
}

// 检查相机是否可用
- (BOOL)checkCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        //相机不可用
        return NO;
    }
    //相机可用
    return YES;
}

//当选择一张图片后进入到这个协议方法里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.iconImageView.image = image;
        
        // 头像的话，需要压缩照片，就设置为200*200，有需要可以自己改
        CGSize imageSize = image.size;
        imageSize.width = 200;
        imageSize.height = (image.size.height/image.size.width) * 200;
        //压缩图片尺寸
        image = [ECUploadTool imageWithImageSimple:image scaledToSize:imageSize];
        
        //上传到服务器
        [MBProgressHUD showMessage:@"正在上传头像中"];
        @weakify(self);
        [ECService uploadImage:image success:^(NSString *imageUrl) {
            [MBProgressHUD hideHUD];
            @strongify(self);
            self.imageUrl = imageUrl;
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD hideHUD];
        }];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"关闭相册界面");
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 点击下一步
- (void)nextButton {
    if (_emailTextField.text.length == 0 ) {
        [_emailTextField setErrorShow:YES errorTitle:@"请输入您的邮箱"];
        [MBProgressHUD showToast:@"请输入您的邮箱"];
        return;
    }
    
    if (_mailCodeTextField.text.length == 0 ) {
        [_mailCodeTextField setErrorShow:YES errorTitle:@"请输入验证码"];
        [MBProgressHUD showToast:@"请输入验证码"];
        return;
    }
    
    if (_companyENNameTextField.text.length == 0 ) {
        [_companyENNameTextField setErrorShow:YES errorTitle:@"请输入您的公司名称（英文）"];
        [MBProgressHUD showToast:@"请输入您的公司名称（英文）"];
        return;
    }
    
    if (_lastNameTextField.text.length == 0 ) {
        [_lastNameTextField setErrorShow:YES errorTitle:@"请输入您的姓"];
        [MBProgressHUD showToast:@"请输入您的姓"];
        return;
    }
    
    if (_firstNameTextField.text.length == 0 ) {
        [_firstNameTextField setErrorShow:YES errorTitle:@"请输入您的名"];
        [MBProgressHUD showToast:@"请输入您的名"];
        return;
    }
    
    if (_phoneTextField.text.length == 0 ) {
        [_phoneTextField setErrorShow:YES errorTitle:@"请输入公司联系电话"];
        [MBProgressHUD showToast:@"请输入公司联系电话"];
        return;
    }
    
    if (_passwordTextField.text.length == 0 ) {
        [_passwordTextField setErrorShow:YES errorTitle:@"请输入密码"];
        [MBProgressHUD showToast:@"请输入密码"];
        return;
    }
    
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
    
    ECRegisterModel *registerModel = [[ECRegisterModel alloc] init];
    registerModel.email = _emailTextField.text;
    registerModel.mailCode = _mailCodeTextField.text;
    registerModel.companyType = ((ECCompanyModel *)self.companyArray[self.selectedCompanyTypeIndex]).id; // 公司类型
    registerModel.companyENName = _companyENNameTextField.text;
    // 公司名称（中文）选填
    registerModel.companyCNName = _companyCNNameTextField.text;
    registerModel.lastName = _lastNameTextField.text;
    registerModel.firstName = _firstNameTextField.text;
    // 中间名（公司法人的中间名）选填
    registerModel.middleName = _middleNameTextField.text;
    registerModel.phone = _phoneTextField.text;
    registerModel.password = _passwordTextField.text;
    registerModel.address1 = _address1TextField.text;
    registerModel.address2 = _address2TextField.text;    // 地址栏2（选填）
    registerModel.city = _cityTextField.text;
    registerModel.province = _provinceTextField.text;
    registerModel.provinceId = ((ECStateModel *)self.stateArray[self.selectedStateIndex]).id;
    registerModel.zipCode = _zipCodeTextField.text;
    registerModel.avatarUrl = self.imageUrl;
    
    ECRegisterNextViewController *registerVC = [[ECRegisterNextViewController alloc] init];
    registerVC.registerModel = registerModel;
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
