//
//  ECOpeningTimeList.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECOpeningTimeItemModel.h"

@interface ECOpeningTimeList : NSObject
@property (nonatomic, strong) ECOpeningTimeItemModel *mon;
@property (nonatomic, strong) ECOpeningTimeItemModel *tue;
@property (nonatomic, strong) ECOpeningTimeItemModel *wen;
@property (nonatomic, strong) ECOpeningTimeItemModel *thu;
@property (nonatomic, strong) ECOpeningTimeItemModel *fri;
@property (nonatomic, strong) ECOpeningTimeItemModel *sat;
@property (nonatomic, strong) ECOpeningTimeItemModel *sun;
@end
