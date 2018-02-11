//
//  ECSafeViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/9.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECSafeViewController.h"
#import "YSMine.h"
#import "ECSettingCellDataSource.h"

@interface ECSafeViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ECSettingCellDataSource *cellDataSource;
@end

@implementation ECSafeViewController

- (ECSettingCellDataSource *)cellDataSource
{
    if (!_cellDataSource) {
        _cellDataSource = [ECSettingCellDataSource itemWithGroupArray:[self setupGroup]];
    }
    return _cellDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全与隐私";
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
    // 1.创建组
    YSMineCellGroup *group = [YSMineCellGroup group];
    [groupArray addObject:group];
    // 2.设置组的所有行数据
    YSMineCellItemSwitch *remember = [YSMineCellItemSwitch itemWithTitle:@"记住我的账号"];
    remember.subtitle = @"在登录前记住您的账号，这样对您比较方便";
    
    YSMineCellItemSwitch *shortPwd = [YSMineCellItemSwitch itemWithTitle:@"设置6位数字密码"];
    shortPwd.subtitle = @"提现超过$500前先输入数字密码，让您的资金更安全";
    
    group.items = @[remember, shortPwd];
    return groupArray;
}

@end
