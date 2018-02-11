//
//  ECPhoneEditViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/7.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECPhoneViewController.h"
#import "ECAddressPhoneCell.h"
#import "ECFooterButtonView.h"
#import "ECAddressEditViewController.h"
#import "ECSettingService.h"
#import "ECPhoneAddViewController.h"

@interface ECPhoneViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *addressArray;

@end

@implementation ECPhoneViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加电话号码";
    self.view.backgroundColor = UIColorMain_Bg;
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
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
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @weakify(self);
        [ECSettingService addressListWithSuccess:^(NSMutableArray *addressArray) {
            @strongify(self);
            self.addressArray = addressArray;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD showToast:errorMsg];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
}

#pragma mark - 编辑


#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECAddressPhoneCell *cell = [ECAddressPhoneCell cellWithTableView:tableView];
    NSInteger section = indexPath.section;
    if (self.addressArray.count > indexPath.section) {
        ECAddressModel *addressModel = self.addressArray[section];
        addressModel.addressNo = [NSString stringWithFormat:@"%ld",section + 1];
        cell.addressModel = addressModel;
        [cell addEventTouchUpInsideHandler:^{
            ECPhoneAddViewController *phoneAddVC = [[ECPhoneAddViewController alloc] init];
            phoneAddVC.storeId = addressModel.storeId;
            [self.navigationController pushViewController:phoneAddVC animated:YES];
        }];
    }
    return cell;
}

@end
