//
//  ECBalanceViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/31.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalanceViewController.h"
#import "UINavigationBar+Transparent.h"
#import "ECFooterButtonView.h"

@interface ECBalanceViewController ()

@end

@implementation ECBalanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar ys_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar ys_reset];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x577CE1);
    self.title = @"余额管理";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"common_back_white" hightlightedImage:@"common_back_white" target:self selector:@selector(backClick)];
    
    [self setupUI];
    [self setupFooterView];
}

- (void)setupUI {
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 48, 30)];
    logoImgView.image = [UIImage imageNamed:@"home_golden_card"];
    logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    logoImgView.centerX = self.view.centerX;
    [self.view addSubview:logoImgView];
    
    NSString *amount = [NSString stringWithFormat:@"$ %.2f",100.00];
    UILabel *AmountLabel = [UILabel initWithFrame:CGRectMake(0, logoImgView.bottom + 20, SCREEN_WIDTH - 60, 75) text:amount font:[UIFont boldSystemFontOfSize:48] color:UIColorFromHex(0xffffff)];
    [AmountLabel setFont:[UIFont systemFontOfSize:34] fromIndex:0 toIndex:1];
    AmountLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:AmountLabel];
    
    CGSize amountSize = [amount sizeMakeWithFont:[UIFont boldSystemFontOfSize:48]];
    CGFloat left = (SCREEN_WIDTH - 60 + amountSize.width) * 0.5;
    UILabel *AmountTypeLabel = [UILabel initWithFrame:CGRectMake(left, logoImgView.bottom + 30, 40, 20) text:@"USD" font:[UIFont systemFontOfSize:15] color:UIColorFromHex(0xffffff)];
    [self.view addSubview:AmountTypeLabel];
}

- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"提现"];
    [self.view addSubview:footerButtonView];
    //@weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        //@strongify(self);
        [MBProgressHUD showToast:@"暂不支持该功能"];
    }];
}

#pragma mark - 私有方法
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
