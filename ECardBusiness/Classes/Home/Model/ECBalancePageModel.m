//
//  ECBalancePageModel.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalancePageModel.h"

@implementation ECBalancePageModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"list"   : [ECBalanceBillModel class],
             };

}

@end
