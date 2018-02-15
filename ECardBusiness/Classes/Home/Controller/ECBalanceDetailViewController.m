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
#import "ECHomeService.h"

@interface ECBalanceDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *balanceArray;
@property (nonatomic, strong) UIButton *dealButton;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, copy) NSString *orderStatus; //* 0-所有 1-正在处理 2-已完成 */
@end

@implementation ECBalanceDetailViewController

- (NSMutableArray *)balanceArray {
    if (!_balanceArray) {
        self.balanceArray = [NSMutableArray array];
    }
    return _balanceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户明细";
    self.view.backgroundColor = UIColorMain_Bg;
    self.orderStatus = @"1";
    
    [self setupTopView];
    [self setupTableView];
    
    self.dealButton.selected = YES;
    self.dealButton.backgroundColor = [UIColor whiteColor];
}

- (void)setupTopView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
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
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64 - 45) style:UITableViewStylePlain];
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
    @weakify(self);
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        //[self loadNewWithOrderStatus:@"0"];
        [ECHomeService homeQueryJournalListWithType:self.transactionType orderStatus:self.orderStatus maxId:@"" beginDate:@"" endDate:@"" success:^(ECBalancePageModel *balancePageModel) {
            @strongify(self);
            [self.balanceArray removeAllObjects];
            [self.balanceArray addObjectsFromArray:balancePageModel.list];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (balancePageModel.list.count < 10) { //每页10条
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer resetNoMoreData];
            }
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD showToast:errorMsg];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *maxId = ((ECBalanceBillModel *)self.balanceArray.lastObject).journlId;
        [ECHomeService homeQueryJournalListWithType:self.transactionType orderStatus:self.orderStatus maxId:maxId beginDate:@"" endDate:@"" success:^(ECBalancePageModel *balancePageModel) {
            @strongify(self);
            // 如果没有更多数据，隐藏
            [self.balanceArray addObjectsFromArray:balancePageModel.list];
            [self.tableView reloadData];
            if (balancePageModel.list.count < 10) { //每页10条
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD showToast:errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }];
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
        
        self.orderStatus = @"1";
        [self.tableView.mj_header beginRefreshing];
    } forControlEvents:UIControlEventTouchUpInside];
    
    _finishButton = [self statusButtonWithFrame:CGRectMake(_dealButton.right + 15, 10, 80, 28) title:@"已完成"];
    [statusGgView addSubview:_finishButton];
    [_finishButton  bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.dealButton.selected = NO;
        self.dealButton.backgroundColor = UIColorMain_Bg;
        
        self.finishButton.selected = YES;
        self.finishButton.backgroundColor = [UIColor whiteColor];
        
        self.orderStatus = @"2";
        [self.tableView.mj_header beginRefreshing];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.balanceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECBalanceCell *cell = [ECBalanceCell cellWithTableView:tableView];
    if (self.balanceArray.count > indexPath.row) {
        ECBalanceBillModel *balanceModel = self.balanceArray[indexPath.row];
        cell.balanceModel = balanceModel;
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
