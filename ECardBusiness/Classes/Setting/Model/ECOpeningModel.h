//
//  ECOpeningModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAddressModel.h"
#import "ECOpeningOptionModel.h"
#import "ECOpeningTimeList.h"

@interface ECOpeningModel : NSObject
@property (nonatomic, copy) NSString *openNo;
@property (nonatomic, assign) BOOL hasOpenTime;
@property (nonatomic, strong) ECAddressModel *userStoreProfile;
@property (nonatomic, strong) ECOpeningTimeList *openDayList;
@property (nonatomic, strong) ECOpeningOptionModel *optional1;
@property (nonatomic, strong) ECOpeningOptionModel *optional2;
@property (nonatomic, strong) ECOpeningOptionModel *optional3;
@end
