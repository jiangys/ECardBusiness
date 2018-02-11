//
//  ECOpeningTimeView.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/19.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECOfficeHoursModel.h"

typedef NS_ENUM(NSUInteger,openingTimeType) {
    openingTimeTypeRequired, // 必填
    openingTimeTypeOption // 选填
};

@interface ECOpeningTimeView : UIView
- (instancetype)initWithFrame:(CGRect)frame officeHoursModel:(ECOfficeHoursModel *)officeHoursModel;
- (void)setSelectedType:(openingTimeType)strType;
- (ECOfficeHoursModel *)getOpeningTime:(openingTimeType)openingTimeType;

@end
