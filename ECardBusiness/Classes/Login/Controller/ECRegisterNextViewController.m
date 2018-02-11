//
//  ECRegisterNextViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/18.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECRegisterNextViewController.h"
#import "YSTextField.h"
#import "BRTextField.h"
#import "BRPickerView.h"
#import "ECOpeningTimeView.h"
#import "ECFooterButtonView.h"
#import "ECBindCardViewController.h"
#import "ECWebViewController.h"
#import "ECLoginService.h"
#import "ECRegisterTool.h"

@interface ECRegisterNextViewController ()
/** 用户填写的注册信息 */
@property (nonatomic, strong) ECRegisterModel *registerWriteModel;
@property (nonatomic, strong) UIScrollView *scrollView;
/** 现金返还百分比 */
@property (nonatomic, strong) YSTextField *extraRateTextField;
/** 支付密码  */
@property (nonatomic, strong) YSTextField *paySecretTextField;
/** 我希望收到Email提醒 */
@property (nonatomic, strong) UIButton *emailRemindButton;
/** 条款和协议 */
@property (nonatomic, strong) UIButton *protocalButton;
@property (nonatomic, strong) ECOpeningTimeView *openingTimeView;
@property (nonatomic, strong) ECOpeningTimeView *openingTimeOptionalView;
/** 必填营业时间 */
@property (nonatomic, strong) ECOfficeHoursModel *officeHoursModel;
@property (nonatomic, strong) UIImageView *goldenImageView;
@property (nonatomic, strong) UIImageView *roseGoldImageView;
///** 选填营业时间（内容参考officeHours这个对象,嘿嘿） */
//@property (nonatomic, copy) NSString *optionalOfficeHours1;
///** 选填营业时间 */
//@property (nonatomic, copy) NSString *optionalOfficeHours2;
///** 该用户在dwolla上的对应账户 */
//@property (nonatomic, copy) NSString *dowllaCustomerId;
///** 邀请码 */
//@property (nonatomic, copy) NSString *invitationCode;
///** 营业执照图片链接 */
//@property (nonatomic, copy) NSString *licenceUrl;
///** 用户类型（1:客户 2:商家） */
//@property (nonatomic, copy) NSString *type;
@end

@implementation ECRegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(242,246,250);
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _registerWriteModel = [ECRegisterTool getRegisterModel];
    
    [self setupUI];
    [self setupFooterView];
}

- (void)setupUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    [self.view addSubview:_scrollView];
    
    _extraRateTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, 20, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_extraRateTextField setPlaceholder:@"现金返还百分比（需大于或等于10%）" floatingTitle:@"现金返还百分比（需大于或等于10%）"];
    [_extraRateTextField setShowText:_registerWriteModel.extraRate];
    [_scrollView addSubview:_extraRateTextField];
    
    _paySecretTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _extraRateTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_paySecretTextField setPlaceholder:@"输入6位数字密码，提现、充值时使用" floatingTitle:@"输入6位数字密码，提现、充值时使用"];
    [_paySecretTextField.textField setSecureTextEntry:YES];
    [_paySecretTextField setShowText:_registerWriteModel.paySecret];
    [_scrollView addSubview:_paySecretTextField];
    
    UILabel *openingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _paySecretTextField.bottom + 15, SCREEN_WIDTH, 34)];
    openingLabel.backgroundColor = [UIColor whiteColor];
    openingLabel.font = [UIFont boldSystemFontOfSize:14];
    openingLabel.textColor = UIColorMain_Gray;
    openingLabel.text = @"    营业时间";
    [_scrollView addSubview:openingLabel];
    
    _openingTimeView = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, openingLabel.bottom, SCREEN_WIDTH, 130) officeHoursModel:_registerWriteModel.officeHours];
    [_openingTimeOptionalView setSelectedType:openingTimeTypeRequired];
    [_scrollView addSubview:_openingTimeView];
    
    _openingTimeOptionalView = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, _openingTimeView.bottom, SCREEN_WIDTH, 130)];
    [_openingTimeOptionalView setSelectedType:openingTimeTypeOption];
    [_scrollView addSubview:_openingTimeOptionalView];
    
    UILabel *selectCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _openingTimeOptionalView.bottom + 15, SCREEN_WIDTH, 34)];
    selectCardLabel.backgroundColor = [UIColor whiteColor];
    selectCardLabel.font = [UIFont boldSystemFontOfSize:14];
    selectCardLabel.textColor = UIColorMain_Gray;
    selectCardLabel.text = @"    选择虚拟卡";
    [_scrollView addSubview:selectCardLabel];
    
    CGFloat cardW = (SCREEN_WIDTH - 135) * 0.5;
    _goldenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, selectCardLabel.bottom + 30, cardW, cardW * 0.633)];
    _goldenImageView.image = [UIImage imageNamed:@"register_card_golden"];
    [_scrollView addSubview:_goldenImageView];
    _goldenImageView.userInteractionEnabled = YES;
    @weakify(self);
    [_goldenImageView bk_whenTapped:^{
        @strongify(self);
        self.goldenImageView.highlighted = YES;
        self.goldenImageView.layer.borderColor = UIColorMain_Highlighted.CGColor;
        self.goldenImageView.layer.borderWidth = 2;
        self.roseGoldImageView.highlighted = NO;
        self.roseGoldImageView.layer.borderColor = [UIColor clearColor].CGColor;
        self.roseGoldImageView.layer.borderWidth = 0;
    }];
    
    _roseGoldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_goldenImageView.right + 45, selectCardLabel.bottom + 30, _goldenImageView.width, _goldenImageView.height)];
    _roseGoldImageView.image = [UIImage imageNamed:@"register_card_rosegold"];
    [_scrollView addSubview:_roseGoldImageView];
    _roseGoldImageView.userInteractionEnabled = YES;
    [_roseGoldImageView bk_whenTapped:^{
        @strongify(self);
        self.roseGoldImageView.highlighted = YES;
        self.roseGoldImageView.layer.borderColor = UIColorMain_Highlighted.CGColor;
        self.roseGoldImageView.layer.borderWidth = 2;
        self.goldenImageView.highlighted = NO;
        self.goldenImageView.layer.borderColor = [UIColor clearColor].CGColor;
        self.goldenImageView.layer.borderWidth = 0;
    }];
    
    UIView *emailRemindView = [self selectedProtocalWithFrame:CGRectMake(0, _goldenImageView.bottom + 30, SCREEN_WIDTH, 45) buttonType:@"email" title:@"我希望收到Email提醒" titleProtocal:nil desc:@"提现、收款时收到提醒" titleProtocalHandler:nil];
    [_scrollView addSubview:emailRemindView];
    
    UIView *selectedProtocalView = [self selectedProtocalWithFrame:CGRectMake(0, emailRemindView.bottom + 25, SCREEN_WIDTH, 45) buttonType:@"protocal" title:@"我同意" titleProtocal:@"条款和协议" desc:@"点击此框后，我同意ECARD的条款和协议" titleProtocalHandler:^{
        @strongify(self);
        ECWebViewController *webVC = [[ECWebViewController alloc] init];
        webVC.title = @"条款和协议";
        webVC.url = @"http://viva.vip.com/act/m/identity_secret_20160707?wapid=vivac_356";
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    [_scrollView addSubview:selectedProtocalView];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, selectedProtocalView.bottom + 35);
}

- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"下一步"];
    [self.view addSubview:footerButtonView];
    @weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        @strongify(self);
        [self registerSubmit];
    }];
}

- (UIView *)selectedProtocalWithFrame:(CGRect)frame buttonType:(NSString *)buttonType title:(NSString *)title titleProtocal:(NSString *)titleProtocal desc:(NSString *)desc titleProtocalHandler:(void (^)(void))titleProtocalHandler{
    // 协议内容view
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.backgroundColor = [UIColor clearColor];
    [checkButton setImage:[UIImage imageNamed:@"common_select_grey"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"common_select_blue"] forState:UIControlStateSelected];
    [checkButton bk_addEventHandler:^(id sender) {
        ((UIButton*)sender).selected = !((UIButton*)sender).selected;
    } forControlEvents:UIControlEventTouchUpInside];
    checkButton.frame = CGRectMake(45, 0, 14, 14);
    [contentView addSubview:checkButton];
    if ([buttonType isEqualToString:@"email"]) {
        _emailRemindButton = checkButton;
    } else if ([buttonType isEqualToString:@"protocal"]) {
        _protocalButton = checkButton;
    }
    
    NSString *text = title;
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    UILabel *protocalTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(checkButton.right + 10, checkButton.top, size.width, size.height)];
    protocalTipsLabel.font = font;
    protocalTipsLabel.textColor = UIColorMain_Gray;
    protocalTipsLabel.text = text;
    [contentView addSubview:protocalTipsLabel];
    
    if (titleProtocal.length > 0) {
        CGSize protocalButtonSize = [titleProtocal sizeMakeWithFont:font];
        UIButton *protocalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        protocalButton.frame = CGRectMake(protocalTipsLabel.right, protocalTipsLabel.top, protocalButtonSize.width, protocalButtonSize.height);
        [protocalButton setTitle:titleProtocal forState:UIControlStateNormal];
        [protocalButton setTitleColor:UIColorMain_Highlighted forState:UIControlStateNormal];
        [protocalButton.titleLabel setFont:font];
        [contentView addSubview:protocalButton];
        [protocalButton bk_addEventHandler:^(id sender) {
            if (titleProtocalHandler) {
                titleProtocalHandler();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(protocalTipsLabel.left, protocalTipsLabel.bottom + 10, SCREEN_WIDTH, 12)];
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textColor = UIColorFromHex(0x999999);
    descLabel.text = desc;
    [contentView addSubview:descLabel];
    
    return contentView;
}

- (void)registerSubmit {
    if (_extraRateTextField.text.length == 0 ) {
        [_extraRateTextField setErrorShow:YES errorTitle:@"请输入现金返还百分比"];
        [MBProgressHUD showToast:@"请输入现金返还百分比"];
        return;
    }
    
    if (_paySecretTextField.text.length == 0 ) {
        [_paySecretTextField setErrorShow:YES errorTitle:@"请输入6位数字密码"];
        [MBProgressHUD showToast:@"请输入6位数字密码"];
        return;
    }
    
    // 卡片类型1:金卡 2:银卡
    if (self.goldenImageView.highlighted || self.roseGoldImageView.highlighted) {
        self.registerModel.cardType = (self.goldenImageView.highlighted ? @"1":@"2");
    } else {
        [MBProgressHUD showToast:@"请选择虚拟卡"];
        return;
    }
    
    // 条款和协议
    if (!_protocalButton.selected) {
        [MBProgressHUD showToast:@"请选择勾选条款和协议"];
        return;
    }
    
    // 营业信息
    ECOfficeHoursModel *officeHoursModel = [_openingTimeView getOpeningTime:openingTimeTypeRequired];
    if (!officeHoursModel) {
        return;
    }
    
    self.registerModel.extraRate = _extraRateTextField.text;
    self.registerModel.paySecret = _paySecretTextField.text;
    // needEmailRemind 是否需要邮件提醒交易  0:否 1:是
    self.registerModel.needEmailRemind = _emailRemindButton.selected ? @"1" : @"0";
    self.registerModel.officeHours = officeHoursModel;
    self.registerModel.type = @"2"; //用户类型
    self.registerModel.licenceUrl = @"https://avarta.s3.us-west-2.amazonaws.com/22459100-c206-41c7-ac0f-980d2892afe2";
    self.registerModel.lat = @"34.0806687";
    self.registerModel.lng = @"-118.0778257";
    
    [ECRegisterTool saveRegisterModel:self.registerModel];
    [MBProgressHUD showMessage:@"注册中，请稍后"];
    [ECLoginService registerWithRegisterModel:self.registerModel success:^(ECAccountModel *responseObj) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"注册成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

@end
