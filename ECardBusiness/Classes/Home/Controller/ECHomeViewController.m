//
//  ECHome1ViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECHomeViewController.h"
#import "UINavigationBar+Transparent.h"
#import "ECMessageViewController.h"
#import "ECSettingViewController.h"
#import "LBXScanNative.h"
#import "ECCashDeskViewController.h"
#import "ECBalanceViewController.h"
#import "ECLoginViewController.h"
#import "ECNavigationController.h"
#import "ECService.h"
#import "ECConfigModel.h"
#import "ECBalanceDealViewController.h"
#import "ECBalanceDetailViewController.h"

#define kHomeHeaderViewHeight 360
@interface ECHomeViewController ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *qrImgView;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *amountDescLabel;
@end

@implementation ECHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar ys_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    if (_iconImageView && [ECConfigModel defaultModel].userModel.avatarUrl) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[ECConfigModel defaultModel].userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar ys_reset];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(![ECAccountTool isLogin]) {
        ECLoginViewController *loginVC = [[ECLoginViewController alloc] init];
        [self presentViewController:[[ECNavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
    } else {
        if (![ECConfigModel defaultModel].userModel) {
            [self getUserInfo];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"home_message_icon_nor" hightlightedImage:@"home_message_icon_nor" target:self selector:@selector(messageClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_setting_icon_nor" hightlightedImage:@"home_setting_icon_nor" target:self selector:@selector(settingClick)];
    
    [self addHeadView];
    [self addFooterView];
}

- (void)addHeadView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHomeHeaderViewHeight)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UIImageView *headerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    headerBgView.image = [UIImage imageNamed:@"home_rectangle"];
    [headerView addSubview:headerBgView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) * 0.5, 70, 60, 60)];
    iconImageView.contentMode = UIViewContentModeScaleToFill;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.layer.cornerRadius = iconImageView.width * 0.5;
    [headerView addSubview:iconImageView];
    iconImageView.image = [UIImage imageNamed:@"home_header_default_icon"];
    self.iconImageView = iconImageView;
    
    UILabel *cashbackLabel = [UILabel initWithFrame:CGRectMake(0, iconImageView.bottom + 15, SCREEN_WIDTH, 15) text:@"Cashback 总额" font:[UIFont systemFontOfSize:13] color:UIColorFromHex(0xd0e8ff)];
    cashbackLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:cashbackLabel];
    
    UILabel *AmountLabel = [UILabel initWithFrame:CGRectMake(0, cashbackLabel.bottom, SCREEN_WIDTH, 42) text:@"$2100.00" font:[UIFont systemFontOfSize:30] color:UIColorFromHex(0xffffff)];
    AmountLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:AmountLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, AmountLabel.bottom + 23, SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = UIColorFromHex(0xd0e8ff);
    [headerView addSubview:lineView];
    
    @weakify(self);
    UIView *balanceView = [self setupButtonWithPoint:(CGPoint){60, lineView.bottom + 25} imageName:@"home_balance" desc:@"余额管理" block:^{
        @strongify(self);
        ECBalanceViewController *balanceVC = [[ECBalanceViewController alloc] init];
        [self.navigationController pushViewController:balanceVC animated:YES];
    }];
    [headerView addSubview:balanceView];
    
    UIView *balanceItemView = [self setupButtonWithPoint:(CGPoint){SCREEN_WIDTH - 60 - 70, lineView.bottom + 25} imageName:@"home_balanceItem" desc:@"账目明细" block:^{
        ECLog(@"账目明细");
        @strongify(self);
        ECBalanceDetailViewController *balanceVC = [[ECBalanceDetailViewController alloc] init];
        [self.navigationController pushViewController:balanceVC animated:YES];
    }];
    [headerView addSubview:balanceItemView];
}

- (void)addFooterView {
    CGFloat footerViewH = SCREEN_HEIGHT - kHomeHeaderViewHeight;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, SCREEN_WIDTH, footerViewH)];
    [self.view addSubview:footerView];
    
    UIButton *setReceiptbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    setReceiptbutton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [setReceiptbutton setTitle:@"设置收款金额" forState:UIControlStateNormal];
    [setReceiptbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setReceiptbutton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    setReceiptbutton.backgroundColor = UIColorFromHex(0x35519f);
    @weakify(self);
    [setReceiptbutton bk_addEventHandler:^(id sender) {
        @strongify(self);
        ECCashDeskViewController *cashDeskVC = [[ECCashDeskViewController alloc] init];
        cashDeskVC.amountAction = ^(NSString *amount) {
            @strongify(self);
            self.amountLabel.hidden = NO;
            self.amountLabel.text = [NSString stringWithFormat:@"$%.2f",[amount floatValue]];
            self.qrImgView.image = [LBXScanNative createQRWithString:amount QRSize:_qrImgView.bounds.size];
            self.qrImgView.top = self.amountLabel.bottom + 8;
            self.amountDescLabel.top = self.qrImgView.bottom + 5;
        };
        [self.navigationController pushViewController:cashDeskVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    _amountLabel = [UILabel initWithFrame:CGRectMake(0, setReceiptbutton.bottom + 10, SCREEN_WIDTH, 35) text:@"$0.01" font:[UIFont boldSystemFontOfSize:24] color:UIColorMain_Gray];
    _amountLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:_amountLabel];
    _amountLabel.hidden = YES;
    
    _qrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setReceiptbutton.bottom + 30, footerViewH - _amountLabel.bottom - 50, footerViewH - _amountLabel.bottom - 50)];
    _qrImgView.centerX = CGRectGetWidth(footerView.frame)/2;
    [footerView addSubview:_qrImgView];
    _qrImgView.image = [LBXScanNative createQRWithString:@"ecard://type=pay" QRSize:_qrImgView.bounds.size];
    //_qrImgView.image = [LBXScanNative createQRWithString:[_amountLabel.text stringByReplacingOccurrencesOfString:@"$" withString:@""]  QRSize:_qrImgView.bounds.size];
    
    CGSize logoSize=CGSizeMake(40, 25);
    UIImageView *logoImgView = [[UIImageView alloc] init];
    logoImgView.image = [UIImage imageNamed:@"home_golden_card"];
    logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    logoImgView.bounds = CGRectMake(0, 0, logoSize.width, logoSize.height);
    logoImgView.center = CGPointMake(CGRectGetWidth(_qrImgView.frame)/2, CGRectGetHeight(_qrImgView.frame)/2);
    [_qrImgView addSubview:logoImgView];
    
    UILabel *amountDescLabel = [UILabel initWithFrame:CGRectMake(0, _qrImgView.bottom + 5, SCREEN_WIDTH, 16) text:@"让付款人扫此二维码向我付款" font:[UIFont systemFontOfSize:12] color:UIColorMain_Normal];
    amountDescLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:amountDescLabel];
    self.amountDescLabel = amountDescLabel;
    
    [footerView addSubview:setReceiptbutton];
}

- (UIView *)setupButtonWithPoint:(CGPoint)point imageName:(NSString *)imageName desc:(NSString *)desc block:(dispatch_block_t)block{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 70, 100)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 70, 70);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = bgView.size.width * 0.5;
    [button bk_addEventHandler:^(id sender) {
        if (block) {
            block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + 5, bgView.width, 20)];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.textColor = UIColorFromHex(0xD0E8FF);
    descLabel.text = desc;
    descLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:descLabel];
    
    return bgView;
}

- (void)getUserInfo {
    [MBProgressHUD showMessage:@"loading"];
    @weakify(self);
    [ECService getUserInfo:[ECAccountTool getAccount].userId success:^(ECUserInfoModel *userModel) {
        @strongify(self);
        [ECConfigModel defaultModel].userModel = userModel;
        [MBProgressHUD hideHUD];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[ECConfigModel defaultModel].userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

- (void)messageClick {
    ECLog(@" --- messageClick");
    ECMessageViewController *messageVC = [[ECMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)settingClick {
    ECLog(@" --- settingClick");
    ECSettingViewController *settingVC = [[ECSettingViewController alloc] init];
    //Drop3ViewController *settingVC = [[Drop3ViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

@end
