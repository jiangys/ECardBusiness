//
//  ECAccountTool.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAccountModel.h"

@interface ECAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ECAccountModel *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ECAccountModel *)getAccount;

+ (BOOL)isLogin;

/**
 *  退出登录
 */
+ (void)signOut;

@end
