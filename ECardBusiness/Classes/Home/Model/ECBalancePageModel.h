//
//  ECBalancePageModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBalanceBillModel.h"

@interface ECBalancePageModel : NSObject

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *pageIndex;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *totalCount;

@end
