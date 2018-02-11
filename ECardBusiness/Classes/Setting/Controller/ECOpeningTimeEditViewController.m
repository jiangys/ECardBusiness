//
//  ECOpeningTimeEditViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECOpeningTimeEditViewController.h"
#import "ECOpeningTimeView.h"
#include "ECOpenTimeUpdateModel.h"
#import "ECSettingService.h"

@interface ECOpeningTimeEditViewController ()
@property (nonatomic, strong) ECOpeningTimeView *openingTimeView;
@property (nonatomic, strong) ECOpeningTimeView *openingTimeOptional2View;
@property (nonatomic, strong) ECOpeningTimeView *openingTimeOptional3View;
@end

@implementation ECOpeningTimeEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加营业时间";
    self.view.backgroundColor = UIColorMain_Bg;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil hightlightedImage:nil title:@"保存" titleColor:UIColorMain_Gray target:self selector:@selector(saveClick)];
    
    if (_isEdit) {
        _openingTimeView = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 130) officeHoursModel:[self changeModel:self.optional1]];
    } else {
        _openingTimeView = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 130)];
    }
    [_openingTimeView setSelectedType:openingTimeTypeRequired];
    [self.view addSubview:_openingTimeView];
    
    if (_isEdit) {
        _openingTimeOptional2View = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, _openingTimeView.bottom, SCREEN_WIDTH, 130) officeHoursModel:[self changeModel:self.optional2]];
    } else {
        _openingTimeOptional2View = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, _openingTimeView.bottom, SCREEN_WIDTH, 130)];
    }
    [_openingTimeOptional2View setSelectedType:openingTimeTypeOption];
    [self.view addSubview:_openingTimeOptional2View];
    
    if (_isEdit) {
        _openingTimeOptional3View = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, _openingTimeOptional2View.bottom, SCREEN_WIDTH, 130) officeHoursModel:[self changeModel:self.optional3]];
    } else {
        _openingTimeOptional3View = [[ECOpeningTimeView alloc] initWithFrame:CGRectMake(0, _openingTimeOptional2View.bottom, SCREEN_WIDTH, 130)];
    }
    [_openingTimeOptional3View setSelectedType:openingTimeTypeOption];
    [self.view addSubview:_openingTimeOptional3View];
}

- (ECOfficeHoursModel *)changeModel:(ECOpeningOptionModel *)model {
    ECOfficeHoursModel *officeModel = [[ECOfficeHoursModel alloc] init];
    officeModel.dayFrom = model.openFromDay;
    officeModel.dayTo = model.openToDay;
    officeModel.am = model.openFromTime;
    officeModel.pm = model.openToTime;
    return officeModel;
}

- (void)saveClick {
    ECOfficeHoursModel *openTime1 = [_openingTimeView getOpeningTime:openingTimeTypeRequired];
    ECOfficeHoursModel *openTime2 = [_openingTimeOptional2View getOpeningTime:openingTimeTypeOption];
    ECOfficeHoursModel *openTime3 = [_openingTimeOptional3View getOpeningTime:openingTimeTypeOption];
    
    if (!openTime1) {
        return;
    }
    
    ECOpenTimeUpdateModel *updateModel = [[ECOpenTimeUpdateModel alloc] init];
    updateModel.storeId = self.storeId;
    updateModel.open1FromDay = openTime1.dayFrom;
    updateModel.open1ToDay = openTime1.dayTo;
    updateModel.open1FromTime = openTime1.am;
    updateModel.open1ToTime = openTime1.pm;
    
    if (openTime2.dayFrom.length > 0 && openTime2.dayTo.length > 0 && openTime2.am.length > 0 && openTime2.pm.length > 0) {
        updateModel.open2FromDay = openTime2.dayFrom;
        updateModel.open2ToDay = openTime2.dayTo;
        updateModel.open2FromTime = openTime2.am;
        updateModel.open2ToTime = openTime2.pm;
    }
    
    if (openTime3.dayFrom.length > 0 && openTime3.dayTo.length > 0 && openTime3.am.length > 0 && openTime3.pm.length > 0) {
        updateModel.open3FromDay = openTime3.dayFrom;
        updateModel.open3ToDay = openTime3.dayTo;
        updateModel.open3FromTime = openTime3.am;
        updateModel.open3ToTime = openTime3.pm;
    }
    
    [MBProgressHUD showMessage:@"loading"];
    [ECSettingService openTimeUpdateWithParam:updateModel success:^(id responseObj) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:errorMsg];
    }];
}

@end
