//
//  ECHomeService.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBalancePageModel.h"

@interface ECHomeService : NSObject

/* transactionTypeList 0全部，1是顾客,2是我
 orderStatus:  1-正在处理 2-已完成
 beginDate/endDate 格式为如 2018-02-01
 */
+ (void)homeQueryJournalListWithType:(NSString *)transactionTypeList
                         orderStatus:(NSString *)status
                               maxId:(NSString *)maxId
                           beginDate:(NSString *)beginDate
                             endDate:(NSString *)endDate
                             success:(void (^)(ECBalancePageModel *balancePageModel))success
                             failure:(void (^)(NSString *errorMsg))failure;

@end
