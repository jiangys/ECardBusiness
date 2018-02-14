//
//  ECBalanceFinishViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/11.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalanceFinishViewController.h"
#import "ECBalanceCell.h"
#import "ECSettingService.h"

@interface ECBalanceFinishViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *balanceArray;
@end

@implementation ECBalanceFinishViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMain_Bg;
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = UIColorMain_Bg;
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
    //    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        @weakify(self);
    //        [ECSettingService addressListWithSuccess:^(NSMutableArray *addressArray) {
    //            @strongify(self);
    //            self.addressArray = addressArray;
    //            [self.tableView reloadData];
    //            [self.tableView.mj_header endRefreshing];
    //        } failure:^(NSString *errorMsg) {
    //            [MBProgressHUD showToast:errorMsg];
    //            [self.tableView.mj_header endRefreshing];
    //        }];
    //    }];
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//self.addressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECBalanceCell *cell = [ECBalanceCell cellWithTableView:tableView];
    cell.balanceModel = nil;
    //    if (self.addressArray.count > indexPath.section) {
    //        ECBalanceModel *balanceModel = self.addressArray[section];
    //        cell.balanceModel = balanceModel;
    //    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
