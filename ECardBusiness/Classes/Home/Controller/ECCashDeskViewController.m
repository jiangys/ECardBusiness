//
//  ECCashDeskViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/30.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECCashDeskViewController.h"
#import "ECFooterButtonView.h"

@interface ECCashDeskViewController ()
@property (nonatomic, strong) UITextField *amountTextField;
@end

@implementation ECCashDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收款";
    
    [self setupUI];
    [self setupFooterView];
}

- (void)setupUI {
    UILabel *AmountTypeLabel = [UILabel initWithFrame:CGRectMake(50, 250, 22, 50) text:@"$" font:[UIFont boldSystemFontOfSize:34] color:UIColorMain_Gray];
    [self.view addSubview:AmountTypeLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(AmountTypeLabel.right + 3, 300, SCREEN_WIDTH - 75 - 80, 1)];
    lineView.backgroundColor = UIColorFromHex(0xcccccc);
    [self.view addSubview:lineView];
    
    UITextField *amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(lineView.left + 30, 250, lineView.width - 60, 50)];
    amountTextField.font = [UIFont systemFontOfSize:44];
    amountTextField.placeholder = @"00.00";
    amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:amountTextField];
    self.amountTextField = amountTextField;
    
    UILabel *usdLabel = [UILabel initWithFrame:CGRectMake(lineView.right, 250, 35, 50) text:@"USD" font:[UIFont systemFontOfSize:15] color:UIColorMain_Gray];
    [self.view addSubview:usdLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)setupFooterView {
    ECFooterButtonView *footerButtonView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerButtonView setFooterButtonTitle:@"确认"];
    [self.view addSubview:footerButtonView];
    @weakify(self);
    [footerButtonView addEventTouchUpInsideHandler:^{
        @strongify(self);
        if (self.amountAction) {
            self.amountAction(self.amountTextField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
