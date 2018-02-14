//
//  ECBalanceModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/11.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECBalanceBillModel : NSObject

/** 账户类型    number    1-balance 2-cashback */
@property (nonatomic, copy) NSString *accountType;
/** 金额 */
@property (nonatomic, copy) NSString *amount;
/** 返现比例    number    当accountType=2 && transactionType=201时有效 */
@property (nonatomic, copy) NSString *cashbackRate;
/** 头像url */
@property (nonatomic, copy) NSString *avatarUrl;
/** 明细id */
@property (nonatomic, copy) NSString *journlId;
/** 头像对应名称 */
@property (nonatomic, copy) NSString *name;
/** 交易状态 number    1-处理中 2-待处理 3-成功 4-失败 5-取消 6-拒绝 */
@property (nonatomic, copy) NSString *status;
/** 交易发生时间 */
@property (nonatomic, copy) NSString *submitTime;
/**  交易类型    number    101-余额充值 102-余额提现 201-支付支出 202-支付收入 301-返现兑换 */
@property (nonatomic, copy) NSString *transactionType;

@end
