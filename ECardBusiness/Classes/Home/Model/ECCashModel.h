//
//  ECCashModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECCashModel : NSObject
/** 可用余额    number */
@property (nonatomic, copy) NSString *balanceAvailable;
/** 充值中的金额（不属于balance；用于判断账户金额上限） */
@property (nonatomic, copy) NSString *balanceInCharge;
/**  支付中（待商家确认）的冻结金额 */
@property (nonatomic, copy) NSString *balanceInPay;
/** 由于发起了提现而冻结的金额 */
@property (nonatomic, copy) NSString *balanceInWithdraw;
@end
