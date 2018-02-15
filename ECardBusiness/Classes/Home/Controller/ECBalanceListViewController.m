//
//  ECBalanceListViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalanceListViewController.h"
#import "ECBalanceDetailViewController.h"
#import "ECLoginViewController.h"
#import "LSPPageView.h"

@implementation ECBalanceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户明细";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_date_select" hightlightedImage:@"home_date_select" target:self selector:@selector(conditionClick)];

    ECBalanceDetailViewController *customerVC = [[ECBalanceDetailViewController alloc] init];
    customerVC.transactionType = @"1";
    
    ECBalanceDetailViewController *myVC = [[ECBalanceDetailViewController alloc] init];
    customerVC.transactionType = @"2";
    
    NSArray *testArray = @[@"顾客", @"我的"];
    NSArray *childVcArray = @[customerVC, myVC];
    
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.isTitleViewScrollEnable = YES;
    style.isContentViewScrollEnable = YES;
    style.normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    style.selectedColor = UIColorFromHex(0x35519f);
    style.font = [UIFont systemFontOfSize:14.0];
    style.titleMargin = 0.0;
    style.isShowBottomLine = YES;
    style.bottomLineColor = UIColorFromHex(0x35519f);
    style.bottomLineH = 2.0;
    style.isNeedScale = YES;
    style.scaleRange = 1.2;
    style.isShowCover = YES;
    style.coverBgColor = [UIColor whiteColor];
    style.coverMargin = 0.0;
    style.coverH = 25.0;
    style.coverRadius = 5;
    style.titleWidth = 120;
    style.isShowSplitLine = NO;

    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:testArray.mutableCopy style:style childVcs:childVcArray.mutableCopy parentVc:self];
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 44, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorMain_line;
    [self.view addSubview:lineView];
    
    UIButton *sendBillButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBillButton.frame = CGRectMake(SCREEN_WIDTH - 165, 64 + 10, 150, 24);
    [sendBillButton setTitle:@"发送账目明细到我的账户" forState:UIControlStateNormal];
    [sendBillButton setTitleColor:UIColorMain_Highlighted forState:UIControlStateNormal];
    [sendBillButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    sendBillButton.backgroundColor = UIColorFromHex(0xd0e8ff);
    sendBillButton.layer.masksToBounds = YES;
    sendBillButton.layer.cornerRadius = 5;
    [self.view addSubview:sendBillButton];
    //@weakify(self);
    [sendBillButton bk_addEventHandler:^(id sender) {
        //@strongify(self);
        [MBProgressHUD showToast:@"对不起，暂不支持该功能"];
    } forControlEvents:UIControlEventTouchUpInside];

}

- (void)conditionClick {
    [MBProgressHUD showToast:@"对不起，暂不支持该功能"];
}

@end
