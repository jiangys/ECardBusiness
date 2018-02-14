//
//  ECBalanceDetailViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalanceDetailViewController.h"
#import "ECBalanceCell.h"
#import "ECSettingService.h"

@interface ECBalanceDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *balanceArray;
@property (nonatomic, strong) UIButton *dealButton;
@property (nonatomic, strong) UIButton *finishButton;
@end

@implementation ECBalanceDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户明细";
    self.view.backgroundColor = UIColorMain_Bg;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_date_select" hightlightedImage:@"home_date_select" target:self selector:@selector(conditionClick)];
    
    [self setupTopView];
    [self setupTableView];
    
    self.dealButton.selected = YES;
    self.dealButton.backgroundColor = [UIColor whiteColor];
}

- (void)setupTopView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, bgView.height)];
    customerLabel.textColor = UIColorMain_Highlighted;
    customerLabel.font = [UIFont systemFontOfSize:13];
    customerLabel.text = @"昨日顾客总数：500";
    [bgView addSubview:customerLabel];
    
    NSString *strAmount = [NSString stringWithFormat:@"消费总额：$%.2f",5000.0];
    CGSize amountSize = [strAmount sizeMakeWithFont:[UIFont systemFontOfSize:13]];
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - amountSize.width - 15, 0, amountSize.width, bgView.height)];
    amountLabel.textColor = UIColorMain_Highlighted;
    amountLabel.font = [UIFont systemFontOfSize:13];
    amountLabel.text = strAmount;
    [bgView addSubview:amountLabel];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [self setupHeaderView];
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                 [self.tableView.mj_header endRefreshing];
            });
//            [ECSettingService addressListWithSuccess:^(NSMutableArray *addressArray) {
//                @strongify(self);
//                self.addressArray = addressArray;
//                [self.tableView reloadData];
//                [self.tableView.mj_header endRefreshing];
//            } failure:^(NSString *errorMsg) {
//                [MBProgressHUD showToast:errorMsg];
//                [self.tableView.mj_header endRefreshing];
//            }];
        }];
}

- (UIView *)setupHeaderView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    bgView.backgroundColor = UIColorMain_Bg;
    [self.view addSubview:bgView];
    
    UIView *statusGgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    statusGgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:statusGgView];
    
    _dealButton = [self statusButtonWithFrame:CGRectMake(15, 10, 80, 28) title:@"正在处理"];
    [statusGgView addSubview:_dealButton];
    @weakify(self);
    [_dealButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.dealButton.selected = YES;
        self.dealButton.backgroundColor = [UIColor whiteColor];
        
        self.finishButton.selected = NO;
        self.finishButton.backgroundColor = UIColorMain_Bg;
    } forControlEvents:UIControlEventTouchUpInside];
    
    _finishButton = [self statusButtonWithFrame:CGRectMake(_dealButton.right + 15, 10, 80, 28) title:@"已完成"];
    [statusGgView addSubview:_finishButton];
    [_finishButton  bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.dealButton.selected = NO;
        self.dealButton.backgroundColor = UIColorMain_Bg;
        
        self.finishButton.selected = YES;
        self.finishButton.backgroundColor = [UIColor whiteColor];
    } forControlEvents:UIControlEventTouchUpInside];
    
    return bgView;
}

- (UIButton *)statusButtonWithFrame:(CGRect)frame title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = UIColorMain_Bg;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.layer.borderColor = UIColorMain_Highlighted.CGColor;
    button.layer.borderWidth = 1.0;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorMain_Normal forState:UIControlStateNormal];
    [button setTitleColor:UIColorMain_Highlighted forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"home_current_select"] forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    return button;
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


- (void)conditionClick {
    [MBProgressHUD showToast:@"对不起，暂不支持该功能"];
}

@end
