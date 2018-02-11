//
//  ECBandCardViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBankCardViewController.h"
#import "ECSettingService.h"
#import "ECBankCardAddViewController.h"
#import "ECBankCardModel.h"

@interface ECBankCardViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *bankCardArray;
@end

@implementation ECBankCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理银行账号";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"setting_add" hightlightedImage:@"setting_add" target:self selector:@selector(addBandCardClick)];

    [self setupTableView];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate=self;
    _tableView.tableHeaderView = [self tableHeaderView];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
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
}

- (UIView *)tableHeaderView {
    UIImageView *bgImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
    bgImageView.image = [UIImage imageNamed:@"setting_band_card_bg"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, SCREEN_WIDTH, 25)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"管理银行账号";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:titleLabel];
    
    NSString *desc = @"您将会进入自己的银行进行账户验证，我们会保证您的银行账号信息安全";
    CGSize descSize = [desc sizeMakeWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:250];
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250) * 0.5, titleLabel.bottom + 20, descSize.width, descSize.height)];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.text = desc;
    descLabel.textColor = [UIColor whiteColor];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    [bgImageView addSubview:descLabel];
    
    return bgImageView;
}

#pragma mark - 私有方法
- (void)addBandCardClick {
    [MBProgressHUD showMessage:@"加载中"];
    [ECSettingService getTotenWithSuccess:^(NSString *token) {
        [MBProgressHUD hideHUD];
        ECBankCardAddViewController *addBankCard = [[ECBankCardAddViewController alloc] init];
        addBankCard.token = token;
        [self.navigationController pushViewController:addBankCard animated:YES];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)getBankCardArray {
    [MBProgressHUD showMessage:@"加载中"];
    @weakify(self);
    [ECSettingService bankCardListWithSuccess:^(NSArray *bankCardArray) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        self.bankCardArray = (NSMutableArray *)bankCardArray;
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankCardArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"bankCardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.bankCardArray.count > indexPath.row) {
        ECBankCardModel *bankCardModel = self.bankCardArray[indexPath.row];
        cell.textLabel.text = bankCardModel.bankName;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  当tableView进入编辑状态的时候会调用,询问每一行进行怎样的操作(添加\删除)
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 1.只要实现这个方法,就会拥有左滑删除功能 2.点击"左滑出现的按钮"会调用这个方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ECBankCardModel *bankCardModel = self.bankCardArray[indexPath.row];
    [MBProgressHUD showMessage:@"删除银行中，请稍等"];
    [ECSettingService bankCardDeleteWithFsId:bankCardModel.fsId fsType:bankCardModel.fsType success:^(NSString *token) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"删除成功"];
        [self.bankCardArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}



@end
