//
//  ECTipsSettingViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/9.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECTipsSettingViewController.h"
#import "YSMine.h"
#import "ECSettingCellDataSource.h"

@interface ECTipsSettingViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ECSettingCellDataSource *cellDataSource;
@end

@implementation ECTipsSettingViewController

- (ECSettingCellDataSource *)cellDataSource
{
    if (!_cellDataSource) {
        _cellDataSource = [ECSettingCellDataSource itemWithGroupArray:[self setupGroup]];
    }
    return _cellDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提示设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGroup];
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self.cellDataSource;
    _tableView.delegate = self.cellDataSource;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellStyleValue1;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSMutableArray *)setupGroup {
    NSMutableArray *groupArray = [NSMutableArray array];
    YSMineCellGroup *group = [YSMineCellGroup group];
    [groupArray addObject:group];
    
    YSMineCellItemSwitch *collection = [YSMineCellItemSwitch itemWithTitle:@"当您收款时发送提醒"];
    YSMineCellItemSwitch *Withdraw = [YSMineCellItemSwitch itemWithTitle:@"当您提现时发送提醒"];
    
    group.items = @[collection, Withdraw];
    
    return groupArray;
}

@end
