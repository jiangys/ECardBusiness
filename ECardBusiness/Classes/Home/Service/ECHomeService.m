//
//  ECHomeService.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECHomeService.h"

@implementation ECHomeService

+ (void)homeQueryJournalListWithType:(NSString *)transactionTypeList
                         orderStatus:(NSString *)status
                               maxId:(NSString *)maxId
                           beginDate:(NSString *)beginDate
                             endDate:(NSString *)endDate
                             success:(void (^)(ECBalancePageModel *balancePageModel))success
                             failure:(void (^)(NSString *errorMsg))failure {
    //    accountTypeList    账户类型过滤 null表示不做过滤    array<number>    0-所有 1-balance 2-cashback 返现
    //    beginDate    开始日期 包含当天    string    格式为如 2018-02-01
    //    endDate    结束日期 包含当天    string    格式为如 2018-02-10
    //    maxId    查询的最大itemId    number
    //    pageIndex    从0开始的页码    number    必须参数
    //    pageSize    页大小    number    必须参数
    //    statusList    交易状态过滤 null表示不做过滤    array<number>    0-所有 1-正在处理 2-已完成
    //    transactionTypeList    交易类型过滤 null表示不做过滤    array<number>    0-所有 1-顾客 2-我的
    NSDictionary *param = @{
                            @"accountTypeList":@[@"0"],
                            @"count":@"10",
                            @"maxId":maxId?:@"",
                            @"beginDate":beginDate?:@"",
                            @"endDate":endDate?:@"",
                            @"statusList":@[status?:@"0"],
                            @"transactionTypeList":@[transactionTypeList?:@"0"]
                            };
    [ECHttpRequest postWithURLString:api_home_queryJournalList param:param resultClass:nil isContentTypeJson:YES success:^(id responseObj) {
        success(responseObj?[ECBalancePageModel mj_objectWithKeyValues:responseObj]:nil);
    } failure:failure];
}

@end
