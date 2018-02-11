//
//  ECSettingViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECSettingViewController.h"
#import "UINavigationBar+Transparent.h"
#import "YSMine.h"
#import "ECBankCardViewController.h"
#import "ECMyInfoViewController.h"
#import "ECSafeViewController.h"
#import "ECTipsSettingViewController.h"
#import "ECHelpViewController.h"
#import "ECProtocolViewController.h"

#define NavigationBarBGColor [UIColor colorWithRed:80/255.0f green:118/255.0f blue:214/255.0f alpha:1]
#define kSettingHeadImageHeight 200
#define Max_OffsetY  50 // 表示滚动到Y值哪里才显示导航栏

@interface ECSettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *nameLabel;
/** 是否将要销毁  */
@property(nonatomic) BOOL isDisappear;
@property(nonatomic, strong) NSMutableArray *groupArray;
@property(nonatomic, strong) YSMineCellDataSource *mineCellDataSource;
@end

@implementation ECSettingViewController

- (NSMutableArray *)groupArray {
    if (!_groupArray)
    {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _isDisappear = NO;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    if (_avatarView) {
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:[ECConfigModel defaultModel].userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _isDisappear = YES;
    [self.navigationController.navigationBar ys_reset];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"common_back_white" hightlightedImage:@"common_back_white" target:self selector:@selector(backClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"login_signout" hightlightedImage:@"login_signout" title:@"登出" titleColor:nil target:self selector:@selector(loginOutClick)];
    
    
    [self setupGroup];
    
    //添加TableView
    [self createTableView];
    
    //添加表头视图
    [self addTableHeadView];
    
    _tableView.tableFooterView = [UIView new];
}

- (void)createTableView {
    //self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)addTableHeadView {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, -kSettingHeadImageHeight, SCREEN_WIDTH, kSettingHeadImageHeight);
    self.imageView.image = [UIImage imageNamed:@"setting_header_bg"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.tableView addSubview:self.imageView];
    
    _avatarView = [UIImageView new];
    _avatarView.image = [UIImage imageNamed:@"home_header_default_icon"];
    _avatarView.contentMode = UIViewContentModeScaleToFill;
    _avatarView.size = CGSizeMake(60, 60);
    _avatarView.top = -118;
    _avatarView.centerX = SCREEN_WIDTH * 0.5;
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = _avatarView.width / 2;
    [self.tableView addSubview:_avatarView];
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[ECConfigModel defaultModel].userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _avatarView.bottom + 10, SCREEN_WIDTH, 25)];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = [ECConfigModel defaultModel].userModel.firstName;
    [self.tableView addSubview:_nameLabel];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kSettingHeadImageHeight, 0, 0, 0);
}

#pragma mark - UITableViewDelegate，UITableViewDataSource
- (void)setupGroup {
    // 1.创建组
    YSMineCellGroup *group = [YSMineCellGroup group];
    [self.groupArray addObject:group];
    
    // 2.设置组的所有行数据
    YSMineCellItemArrow *bandCard = [YSMineCellItemArrow itemWithTitle:@"管理银行账号"];
    bandCard.icon = @"setting_band_card";
    bandCard.destVcClass = [ECBankCardViewController class];
    
    YSMineCellItemArrow *myInfo = [YSMineCellItemArrow itemWithTitle:@"个人信息"];
    myInfo.icon = @"setting_my_info";
    myInfo.destVcClass = [ECMyInfoViewController class];
    
    YSMineCellItemArrow *safe = [YSMineCellItemArrow itemWithTitle:@"安全与隐私"];
    safe.icon = @"setting_safe";
    safe.destVcClass = [ECSafeViewController class];
    
    YSMineCellItemArrow *tips = [YSMineCellItemArrow itemWithTitle:@"提示设置"];
    tips.icon = @"setting_tips";
    tips.destVcClass = [ECTipsSettingViewController class];
    
    YSMineCellItemArrow *help = [YSMineCellItemArrow itemWithTitle:@"帮助"];
    help.icon = @"setting_help";
    help.destVcClass = [ECHelpViewController class];
    
    YSMineCellItemArrow *protocol = [YSMineCellItemArrow itemWithTitle:@"条款协议"];
    protocol.icon = @"setting_protocal";
    protocol.destVcClass = [ECProtocolViewController class];
    
    group.items = @[bandCard, myInfo, safe, tips, help, protocol];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YSMineCellGroup *group = self.groupArray[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSMineCell *cell = [YSMineCell cellWithTableView:tableView];
    YSMineCellGroup *group = self.groupArray[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出这行对应的item模型
    YSMineCellGroup *group = self.groupArray[indexPath.section];
    YSMineCellItem *item = group.items[indexPath.row];
    
    // 判断有无需要跳转的控制器
    if (item.destVcClass)
    {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

/**
 *  当改变了scrollView的contentOffset，都会调用该方法。由于，在跳转到另一个控制器的时候，会被触发，导致导航栏为空白。
 *  因而，加上_isDisappear判断，如果是跳转则不执行
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isDisappear) {
        return;
    }
    CGFloat offSet_Y = self.tableView.contentOffset.y;
    NSLog(@"上下偏移量 OffsetY:%f ->",offSet_Y);
    
    if (offSet_Y < -kSettingHeadImageHeight) {
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
    CGFloat reoffSet = offSet_Y + kSettingHeadImageHeight;
    NSLog(@"reoffSet:%f ->",reoffSet);
    // kHeadImageHeight-64是为了向上拉倒导航栏底部时alpha = 1
    if (reoffSet > Max_OffsetY) {
        CGFloat alpha = (reoffSet - Max_OffsetY)/(kSettingHeadImageHeight - 64 - Max_OffsetY);
        alpha = MIN(alpha, 0.99);
        self.title = alpha > 0.8 ? @"设置":@"";
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
    }
}

#pragma mark - 私有方法
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginOutClick {
    [ECAccountTool signOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
