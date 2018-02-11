//
//  ECHomeViewController.m
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECHome2ViewController.h"
#import "UINavigationBar+Transparent.h"

#define kHeadImageHeight 350
#define Max_OffsetY  50 // 表示滚动到Y值哪里才显示导航栏
#define NavigationBarBGColor [UIColor colorWithRed:32/255.0f green:177/255.0f blue:232/255.0f alpha:1]

@interface ECHome2ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 是否将要销毁  */
@property(nonatomic) BOOL isDisappear;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation ECHome2ViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _isDisappear = NO;
    //[self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar ys_reset];
    _isDisappear = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    [navigationBar setBarTintColor:[UIColor redColor]];
    
    [self setupTableView];
    
    //添加表头视图
    [self addTableHeadView];
    
    [self addTableHearderView];
    
    [self addTableFooterView];
    
    /* 设置导航栏上面的内容 */
    //设置导航
    [self.navigationController.navigationBar ys_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:(UIBarButtonItemStylePlain) target:self action:@selector(right)];
//    [self.navigationController.navigationBar ys_setBackgroundColor:[UIColor clearColor]];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"home_message_icon_nor" hightlightedImage:@"home_message_icon_nor" target:self selector:@selector(messageClick)];
//
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_setting_icon_nor" hightlightedImage:@"home_setting_icon_nor" target:self selector:@selector(settingClick)];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = UIColorFromHex(0xf3f4f5);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.tableFooterView = [self footerView];
    [self.view addSubview:_tableView];
}

- (void)addTableHeadView {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, -kHeadImageHeight, SCREEN_WIDTH, kHeadImageHeight);
    self.imageView.image = [UIImage imageNamed:@"home_rectangle"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.tableView addSubview:self.imageView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadImageHeight, 0, 0, 0);
    
    //[self.tableView addSubview:self.imageView];
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
//
//    UIImageView *headerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
//    headerBgView.image = [UIImage imageNamed:@"home_rectangle"];
//    [headerView addSubview:headerBgView];
//
//    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 27, 40, 54, 54)];
//    headImageView.image = [UIImage imageNamed:@"home_header_default_icon"];
//    [headerView addSubview:headImageView];
//
//    UILabel *cashbackLabel = [UILabel initWithFrame:CGRectMake(0, headImageView.bottom + 15, SCREEN_WIDTH, 15) text:@"Cashback 总额" font:[UIFont systemFontOfSize:13] color:UIColorFromHex(0xd0e8ff)];
//    cashbackLabel.textAlignment = NSTextAlignmentCenter;
//    [headerView addSubview:cashbackLabel];
//
//    UILabel *AmountLabel = [UILabel initWithFrame:CGRectMake(0, cashbackLabel.bottom, SCREEN_WIDTH, 42) text:@"$2100.00" font:[UIFont systemFontOfSize:30] color:UIColorFromHex(0xffffff)];
//    AmountLabel.textAlignment = NSTextAlignmentCenter;
//    [headerView addSubview:AmountLabel];
//
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, AmountLabel.bottom + 23, SCREEN_WIDTH - 30, 1)];
//    lineView.backgroundColor = UIColorFromHex(0xd0e8ff);
//    [headerView addSubview:lineView];
//
//    UIView *balanceView = [self setupButtonWithPoint:(CGPoint){60, lineView.bottom + 30} imageName:@"home_balance" desc:@"余额管理" block:^{
//        ECLog(@"余额管理 ");
//    }];
//    [headerView addSubview:balanceView];
//
//    UIView *balanceItemView = [self setupButtonWithPoint:(CGPoint){SCREEN_WIDTH - 60 - 70, lineView.bottom + 30} imageName:@"home_balanceItem" desc:@"账目明细" block:^{
//        ECLog(@"账目明细");
//    }];
//    [headerView addSubview:balanceItemView];
//
//    return headerView;
}

- (void)addTableHearderView {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
    headerView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = headerView;
    
//        UIImageView *headerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
//        headerBgView.image = [UIImage imageNamed:@"home_rectangle"];
//        [headerView addSubview:headerBgView];
    
//        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 27, 40, 54, 54)];
//        headImageView.image = [UIImage imageNamed:@"home_header_default_icon"];
//        [headerView addSubview:headImageView];
//
//        UILabel *cashbackLabel = [UILabel initWithFrame:CGRectMake(0, headImageView.bottom + 15, SCREEN_WIDTH, 15) text:@"Cashback 总额" font:[UIFont systemFontOfSize:13] color:UIColorFromHex(0xd0e8ff)];
//        cashbackLabel.textAlignment = NSTextAlignmentCenter;
//        [headerView addSubview:cashbackLabel];
//
//        UILabel *AmountLabel = [UILabel initWithFrame:CGRectMake(0, cashbackLabel.bottom, SCREEN_WIDTH, 42) text:@"$2100.00" font:[UIFont systemFontOfSize:30] color:UIColorFromHex(0xffffff)];
//        AmountLabel.textAlignment = NSTextAlignmentCenter;
//        [headerView addSubview:AmountLabel];
//
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, AmountLabel.bottom + 23, SCREEN_WIDTH - 30, 1)];
//        lineView.backgroundColor = UIColorFromHex(0xd0e8ff);
//        [headerView addSubview:lineView];
//
//        UIView *balanceView = [self setupButtonWithPoint:(CGPoint){60, lineView.bottom + 30} imageName:@"home_balance" desc:@"余额管理" block:^{
//            ECLog(@"余额管理 ");
//        }];
//        [headerView addSubview:balanceView];
//
//        UIView *balanceItemView = [self setupButtonWithPoint:(CGPoint){SCREEN_WIDTH - 60 - 70, lineView.bottom + 30} imageName:@"home_balanceItem" desc:@"账目明细" block:^{
//            ECLog(@"账目明细");
//        }];
//        [headerView addSubview:balanceItemView];
}

- (void)addTableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
    
    UIButton *setReceiptbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    setReceiptbutton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [setReceiptbutton setTitle:@"设置收款金额" forState:UIControlStateNormal];
    [setReceiptbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setReceiptbutton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    setReceiptbutton.backgroundColor = UIColorFromHex(0x35519f);
    [setReceiptbutton bk_addEventHandler:^(id sender) {
        ECLog(@"设置收款金额");
    } forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:setReceiptbutton];
    
    _tableView.tableFooterView = footerView;
    //return footerView;
}

//- (UIView *)setupButtonWithPoint:(CGPoint)point imageName:(NSString *)imageName desc:(NSString *)desc block:(dispatch_block_t)block{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 70, 100)];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 70, 70);
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor whiteColor];
//    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = bgView.size.width * 0.5;
//    [button bk_addEventHandler:^(id sender) {
//        if (block) {
//            block();
//        }
//    } forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:button];
//
//    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + 5, bgView.width, 20)];
//    descLabel.font = [UIFont systemFontOfSize:13];
//    descLabel.textColor = UIColorFromHex(0xD0E8FF);
//    descLabel.text = desc;
//    descLabel.textAlignment = NSTextAlignmentCenter;
//    [bgView addSubview:descLabel];
//
//    return bgView;
//}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 *  当改变了scrollView的contentOffset，都会调用该方法。由于，在跳转到另一个控制器的时候，会被触发，导致导航栏为空白。
 *  因而，加上_isDisappear判断，如果是跳转则不执行
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isDisappear) {
        return;
    }
    CGFloat offSet_Y = self.tableView.contentOffset.y;
    NSLog(@"上下偏移量 OffsetY:%f ->",offSet_Y);
    
    if (offSet_Y < -kHeadImageHeight) {
        //获取imageView的原始frame
        CGRect frame = self.imageView.frame;
        //修改y
        frame.origin.y = offSet_Y;
        //修改height
        frame.size.height = -offSet_Y;
        //重新赋值
        self.imageView.frame = frame;
    }
    
    //tableView相对于图片的偏移量
    CGFloat reoffSet = offSet_Y + kHeadImageHeight;
    NSLog(@"reoffSet:%f ->",reoffSet);
    // kHeadImageHeight-64是为了向上拉倒导航栏底部时alpha = 1
    if (reoffSet > Max_OffsetY) {
        CGFloat alpha = (reoffSet - Max_OffsetY)/(kHeadImageHeight-64 - Max_OffsetY);
        alpha = MIN(alpha, 0.99);
        self.title = alpha > 0.8 ? @"导航栏":@"";
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
    }
}


- (void)messageClick {
    
    ECLog(@" --- messageClick");
}

- (void)settingClick {
    
    ECLog(@" --- settingClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
