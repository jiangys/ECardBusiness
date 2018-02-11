//
//  ECLoginService.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAccountModel.h"
#import "ECRegisterModel.h"

@interface ECLoginService : NSObject

// email + pwd 登录
+ (void)loginWithEmail:(NSString *)email
                   pwd:(NSString *)pwd
               success:(void (^)(ECAccountModel *responseObj))success
               failure:(void (^)(NSString *errorMsg))failure;

// email + code 登录
+ (void)loginWithEmail:(NSString *)email
                  code:(NSString *)code
               success:(void (^)(ECAccountModel *responseObj))success
               failure:(void (^)(NSString *errorMsg))failure;

+ (void)loginCodeWithEmail:(NSString *)email
                   success:(void (^)(ECAccountModel *responseObj))success
                   failure:(void (^)(NSString *errorMsg))failure;

+ (void)registerWithRegisterModel:(ECRegisterModel *)registerModel
                          success:(void (^)(ECAccountModel *responseObj))success
                          failure:(void (^)(NSString *errorMsg))failure;


+ (void)loginCompanyTypeWithSuccess:(void (^)(NSMutableArray *companyTypeArray))success
                            failure:(void (^)(NSString *errorMsg))failure;

+ (void)loginStateTypeWithSuccess:(void (^)(NSMutableArray *stateArray))success
                          failure:(void (^)(NSString *errorMsg))failure;

@end
