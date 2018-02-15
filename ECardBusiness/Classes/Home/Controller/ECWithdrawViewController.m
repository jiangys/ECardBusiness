//
//  ECWithdrawViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/13.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECWithdrawViewController.h"
#import "ECFooterButtonView.h"
#import "ECWithdrawCardCell.h"
#import "ECBankCardModel.h"
#import "ECSettingService.h"

@interface ECWithdrawViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *bankCardArray;
@property(nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, assign) NSUInteger currentSelectedIndex;
@end

@implementation ECWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = UIColorMain_Bg;
    
    [self setupTableView];
    [self setupFooterView];
    
    self.currentSelectedIndex = 0;
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [self setupHeaderView];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = UIColorMain_Bg;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @weakify(self);
        [ECSettingService bankCardListWithSuccess:^(NSArray *bankCardArray) {
            @strongify(self);
            self.bankCardArray = (NSMutableArray *)bankCardArray;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD showToast:errorMsg];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    [_tableView.mj_header beginRefreshing];
}

- (UIView *)setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 174)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *tipsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    tipsBgView.backgroundColor = UIColorFromHex(0xfff3df);
    [headerView addSubview:tipsBgView];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 44)];
    tipsLabel.text = @"如果您需提现，则钱包里的全部余额都会进入您用于充值的银行账号。";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:12];
    tipsLabel.textColor = UIColorFromHex(0xff9f00);
    [tipsBgView addSubview:tipsLabel];
    
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(15, tipsBgView.bottom + 15, SCREEN_WIDTH - 30, 90)];
    cardView.backgroundColor = UIColorFromHex(0x577CE1);
    cardView.layer.masksToBounds = YES;
    cardView.layer.cornerRadius = 5;
    [headerView addSubview:cardView];
    
    UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 95, 60)];
    cardImageView.image = [UIImage imageNamed:@"register_card_golden"];
    cardImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:cardImageView];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(cardImageView.right + 15, 0, cardView.width - cardImageView.right - 30, cardView.height)];
    amountLabel.textColor = [UIColor whiteColor];
    amountLabel.font = [UIFont boldSystemFontOfSize:24];
    amountLabel.text = [NSString stringWithFormat:@"$%.2f", self.balance.length > 0? [self.balance floatValue] : 0.00];
    [cardView addSubview:amountLabel];
    self.amountLabel = amountLabel;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height - 10, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = UIColorMain_Bg;
    [headerView addSubview:lineView];
    
    return headerView;
}

/**
 *  初始化底部栏
 */
- (void)setupFooterView {
    ECFooterButtonView *footerView = [[ECFooterButtonView alloc] initWithTop:SCREEN_HEIGHT - 49];
    [footerView setFooterButtonTitle:[NSString stringWithFormat:@"提现$%.2f", self.balance.length > 0? [self.balance floatValue] : 0.00]];
    [self.view addSubview:footerView];
    [footerView addEventTouchUpInsideHandler:^{
        [UIAlertView bk_showAlertViewWithTitle:@"" message:@"确定要提现？" cancelButtonTitle:@"确定" otherButtonTitles:@[@"取消"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self submitWithdrawWithPaySecret:nil];
            }
        }];
    }];
}

- (void)submitWithdrawWithPaySecret:(NSString *)paySecret {
    ECBankCardModel *bankCardModel = self.bankCardArray[self.currentSelectedIndex];
    [MBProgressHUD showMessage:@"loading"];
    [ECService submitWithdrawWithPaySecret:paySecret foundingSourceId:bankCardModel.fsId success:^(id responseObj) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"提现成功"];
    } paySecretBlock:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"请输入支付密码"];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

#pragma mark - 编辑


#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.bankCardArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ECWithdrawCardCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.currentSelectedIndex) {
        [cell setCellSelected:YES];
    }
    else {
        [cell setCellSelected:NO];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECWithdrawCardCell *cell = [ECWithdrawCardCell cellWithTableView:tableView];
    if (self.bankCardArray.count > indexPath.row) {
        ECBankCardModel *bankCardModel = self.bankCardArray[indexPath.row];
        cell.bankCardModel = bankCardModel;
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ECWithdrawCardCell *oldSelectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelectedIndex inSection:0]];
    [oldSelectedCell setCellSelected:NO];
    
    ECWithdrawCardCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setCellSelected:YES];
    
    self.currentSelectedIndex = indexPath.row;
}
@end
