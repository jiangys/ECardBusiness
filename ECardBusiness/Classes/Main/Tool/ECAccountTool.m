//
//  ECAccountTool.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECAccountTool.h"

// 账号的存储路径
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation ECAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ECAccountModel *)account {
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}


/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ECAccountModel *)getAccount {
    // 加载模型
    ECAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    
    return account;
}

/**
 *  判断用户是否登录 ,返回true为已登录
 */
+ (BOOL)isLogin {
    ECAccountModel *account = [self getAccount];
    if (account && account.userId && account.session) {
        return YES;
    }
    return NO;
}

/**
 *  退出登录
 */
+ (void)signOut {
    // 清空用户信息
    [self saveAccount:[ECAccountModel new]];
}

@end
