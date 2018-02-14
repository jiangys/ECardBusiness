//
//  ECUserAccountModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECCashModel.h"

@interface ECUserAccountModel : NSObject
/** 1:金卡 2:银卡 */
@property (nonatomic, copy) NSString *cardType;
/** 账户信息 */
@property (nonatomic, strong) ECCashModel *userAccount;
@end
