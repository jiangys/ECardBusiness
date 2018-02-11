//
//  ECOpeningTimeViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECOpeningTimeViewController.h"
#import "ECAddressPhoneCell.h"
#import "ECFooterButtonView.h"
#import "ECAddressEditViewController.h"
#import "ECSettingService.h"
#import "ECPhoneAddViewController.h"
#import "ECOpeningTimeEditViewController.h"
#import "ECAddressOpeningTimeViewCell.h"

@interface ECOpeningTimeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *openArray;

@end

@implementation ECOpeningTimeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加/更改营业时间";
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
        [ECSettingService businessStoreListWithSuccess:^(NSMutableArray *openList) {
            @strongify(self);
            self.openArray = openList;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD showToast:errorMsg];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECOpeningModel *openModel = self.openArray[indexPath.section];
    if (openModel.openDayList.mon || openModel.openDayList.tue || openModel.openDayList.wen
        || openModel.openDayList.thu
        || openModel.openDayList.fri
        || openModel.openDayList.sat
        || openModel.openDayList.sun ) {
        return 460;
    }
    return 220;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.openArray.count;
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
    ECAddressOpeningTimeViewCell *cell = [ECAddressOpeningTimeViewCell cellWithTableView:tableView];
    NSInteger section = indexPath.section;
    if (self.openArray.count > indexPath.section) {
        ECOpeningModel *openModel = self.openArray[section];
        openModel.openNo = [NSString stringWithFormat:@"%ld",section + 1];
        cell.openModel = openModel;
        [cell addEventTouchUpInsideHandler:^ {
            ECOpeningTimeEditViewController *openTimeAddVC = [[ECOpeningTimeEditViewController alloc] init];
            openTimeAddVC.isEdit = openModel.hasOpenTime;
            openTimeAddVC.optional1 = openModel.optional1;
            openTimeAddVC.optional2 = openModel.optional2;
            openTimeAddVC.optional3 = openModel.optional3;
            openTimeAddVC.storeId = openModel.userStoreProfile.storeId;
            [self.navigationController pushViewController:openTimeAddVC animated:YES];
        }];
    }
    return cell;
}
@end
