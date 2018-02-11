
//
//  ECOpeningTimeView.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/19.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECOpeningTimeView.h"
#import "BRTextField.h"
#import "BRPickerView.h"

@interface ECOpeningTimeView()
@property (nonatomic, strong) UILabel *requiredLabel;
/** 开始星期 */
@property (nonatomic, strong) BRTextField *dayFromTextField;
/** 截止星期 */
@property (nonatomic, strong) BRTextField *dayToTextField;
@property (nonatomic, strong) BRTextField *amTextField;
@property (nonatomic, strong) BRTextField *pmTextField;
@end

@implementation ECOpeningTimeView

- (instancetype)initWithFrame:(CGRect)frame {
   return [self initWithFrame:frame officeHoursModel:nil];
}

- (instancetype)initWithFrame:(CGRect)frame officeHoursModel:(ECOfficeHoursModel *)officeHoursModel {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *requiredLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.height - 20) * 0.5, 30, 20)];
        requiredLabel.font = [UIFont systemFontOfSize:14];
        requiredLabel.textColor = UIColorMain_Gray;
        requiredLabel.text = @"必填";
        [self addSubview:requiredLabel];
        self.requiredLabel = requiredLabel;
        
        CGFloat toW = 56;
        CGFloat selectedW = (SCREEN_WIDTH - 65 - 46 - 30) * 0.5;
        CGFloat selectedH = 34;
        _dayFromTextField = [self selectedTextFieldWithFrame:CGRectMake(requiredLabel.right + 15, 20, selectedW, selectedH)];
        _dayFromTextField.placeholder = @"请选择";
        _dayFromTextField.text = [self changeToTitle:officeHoursModel.dayFrom];
        @weakify(self);
        _dayFromTextField.tapAcitonBlock = ^{
            @strongify(self);
            [BRStringPickerView showStringPickerWithTitle:@"请选择星期" dataSource:@[@"星期一", @"星期二",@"星期三",@"星期四",@"星期五", @"星期六",@"星期天"] defaultSelValue:self.dayFromTextField.text isAutoSelect:YES resultBlock:^(id selectValue , NSUInteger index) {
                @strongify(self);
                self.dayFromTextField.text = selectValue;
            }];
        };
        [self addSubview:_dayFromTextField];
        
        UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayFromTextField.right, _dayFromTextField.top, toW, selectedH)];
        toLabel.font = [UIFont systemFontOfSize:14];
        toLabel.textColor = UIColorMain_Gray;
        toLabel.text = @"到";
        toLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:toLabel];
        
        _dayToTextField = [self selectedTextFieldWithFrame:CGRectMake(toLabel.right, _dayFromTextField.top, selectedW, selectedH)];
        _dayToTextField.placeholder = @"请选择";
        _dayToTextField.text = [self changeToTitle:officeHoursModel.dayTo];
        _dayToTextField.tapAcitonBlock = ^{
            @strongify(self);
            [BRStringPickerView showStringPickerWithTitle:@"请选择星期" dataSource:@[@"星期一", @"星期二",@"星期三",@"星期四",@"星期五", @"星期六",@"星期天"] defaultSelValue:self.dayToTextField.text isAutoSelect:YES resultBlock:^(id selectValue, NSUInteger index) {
                @strongify(self);
                self.dayToTextField.text = selectValue;
            }];
        };
        [self addSubview:_dayToTextField];
        
        _amTextField = [self selectedTextFieldWithFrame:CGRectMake(requiredLabel.right + 15, _dayFromTextField.bottom + 16, selectedW, selectedH)];
        _amTextField.placeholder = @"请选择";
        _amTextField.text = officeHoursModel.am;
        _amTextField.tapAcitonBlock = ^{
            @strongify(self);
            [BRDatePickerView showDatePickerWithTitle:@"开始营业时间" dateType:UIDatePickerModeTime defaultSelValue:self.amTextField.text minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                self.amTextField.text = selectValue;
            }];
        };
        [self addSubview:_amTextField];
        
        UILabel *to2Label = [[UILabel alloc] initWithFrame:CGRectMake(_amTextField.right, _amTextField.top, toW, selectedH)];
        to2Label.font = [UIFont systemFontOfSize:14];
        to2Label.textColor = UIColorMain_Gray;
        to2Label.text = @"到";
        to2Label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:to2Label];
        
        _pmTextField = [self selectedTextFieldWithFrame:CGRectMake(to2Label.right, _amTextField.top, selectedW, selectedH)];
        _pmTextField.placeholder = @"请选择";
        _pmTextField.text = officeHoursModel.pm;
        _pmTextField.tapAcitonBlock = ^{
            @strongify(self);
            [BRDatePickerView showDatePickerWithTitle:@"结束营业时间" dateType:UIDatePickerModeTime defaultSelValue:self.pmTextField.text minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                self.pmTextField.text = selectValue;
            }];
        };
        [self addSubview:_pmTextField];
    }
    return self;
}

- (BRTextField *)selectedTextFieldWithFrame:(CGRect)frame {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:frame];
    textField.height = 34;
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = UIColorMain_Gray;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 3;
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textField.width)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 19)];
    rightImageView.image = [UIImage imageNamed:@"common_drop"];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    textField.rightView = rightImageView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (void)setSelectedType:(openingTimeType)strType {
    if (strType == openingTimeTypeOption) {
        self.requiredLabel.text = @"选填";
    } else {
        self.requiredLabel.text = @"必填";
    }
}

- (ECOfficeHoursModel *)getOpeningTime:(openingTimeType)openingTimeType {
    if (openingTimeType == openingTimeTypeRequired) {
        if (_dayFromTextField.text.length == 0 ) {
            [MBProgressHUD showToast:@"请选择星期"];
            return nil;
        }
        
        if (_dayToTextField.text.length == 0 ) {
            [MBProgressHUD showToast:@"请选择星期"];
            return nil;;
        }
        
        if (_amTextField.text.length == 0 ) {
            [MBProgressHUD showToast:@"请选择开始营业时间"];
            return nil;;
        }
        
        if (_pmTextField.text.length == 0 ) {
            [MBProgressHUD showToast:@"请选择结束营业时间"];
            return nil;;
        }
    }
    
    ECOfficeHoursModel *officeHours = [[ECOfficeHoursModel alloc] init];
    officeHours.dayFrom = [self changeDay:_dayFromTextField.text];
    officeHours.dayTo = [self changeDay:_dayToTextField.text];
    officeHours.am = _amTextField.text;
    officeHours.pm = _pmTextField.text;
    return officeHours;
}

- (NSString *)changeDay:(NSString *)day {
    NSString *dayId = @"1";
    if ([day isEqualToString:@"星期一"]) {
        dayId = @"1";
    } else if ([day isEqualToString:@"星期二"]) {
        dayId = @"2";
    } else if ([day isEqualToString:@"星期三"]) {
        dayId = @"3";
    } else if ([day isEqualToString:@"星期四"]) {
        dayId = @"4";
    } else if ([day isEqualToString:@"星期五"]) {
        dayId = @"5";
    } else if ([day isEqualToString:@"星期六"]) {
        dayId = @"6";
    } else {
        dayId = @"7";
    }
    return dayId;
}

- (NSString *)changeToTitle:(NSString *)dayId {
    NSString *dayTitle = @"";
    if ([dayId isEqualToString:@"1"]) {
        dayTitle = @"星期一";
    } else if ([dayId isEqualToString:@"2"]) {
        dayTitle = @"星期二";
    } else if ([dayId isEqualToString:@"3"]) {
        dayTitle = @"星期三";
    } else if ([dayId isEqualToString:@"4"]) {
        dayTitle = @"星期四";
    } else if ([dayId isEqualToString:@"5"]) {
        dayTitle = @"星期五";
    } else if ([dayId isEqualToString:@"6"]) {
        dayTitle = @"星期六";
    } else if ([dayId isEqualToString:@"7"]) {
        dayTitle = @"星期日";
    }
    return dayTitle;
}

@end
