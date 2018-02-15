//
//  ECHelpViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/9.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECHelpViewController.h"
#import "YSTextField.h"

@interface ECHelpViewController ()
/** 姓 */
@property (nonatomic, strong) YSTextField *firstNameTextField;
/** 名 */
@property (nonatomic, strong) YSTextField *lastNameTextField;
/** 标题 */
@property (nonatomic, strong) YSTextField *titleTextField;
/** 内容 */
@property (nonatomic, strong) YSTextField *contentTextField;
@end

@implementation ECHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助";
    self.view.backgroundColor = UIColorMain_Bg;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil hightlightedImage:nil title:@"保存" titleColor:UIColorMain_Gray target:self selector:@selector(saveClick)];
    
    // 姓（公司法人的姓）
    _lastNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, 74, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_lastNameTextField setPlaceholder:@"姓" floatingTitle:@"姓"];
    [self.view addSubview:_lastNameTextField];
    
    // 名（公司法人的名）
    _firstNameTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _lastNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_firstNameTextField setPlaceholder:@"名" floatingTitle:@"名"];
    [self.view addSubview:_firstNameTextField];
    
    _titleTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _firstNameTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_titleTextField setPlaceholder:@"标题" floatingTitle:@"标题"];
    [self.view addSubview:_titleTextField];
    
    _contentTextField = [[YSTextField alloc] initWithFrame:CGRectMake(RLMargin, _titleTextField.bottom, SCREEN_WIDTH - 2 * RLMargin, 65)];
    [_contentTextField setPlaceholder:@"内容" floatingTitle:@"内容"];
    [self.view addSubview:_contentTextField];
}

#pragma mark - 私有方法

- (void)saveClick {
    [MBProgressHUD showToast:@"建设中"];
}


@end
