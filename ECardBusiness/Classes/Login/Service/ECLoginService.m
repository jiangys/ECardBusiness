//
//  ECLoginService.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECLoginService.h"
#import "ECAccountTool.h"

@implementation ECLoginService

+ (void)loginWithEmail:(NSString *)email
                   pwd:(NSString *)pwd
               success:(void (^)(ECAccountModel *responseObj))success
               failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"email":email,
                            @"password":[YSCryptor MD5:pwd]
                            };
    
    [ECHttpRequest postWithURLString:api_login param:param resultClass:[ECAccountModel class] success:^(id responseObj) {
        ECAccountModel *loginModel = (ECAccountModel *)responseObj;
        loginModel.email = email;
        [ECAccountTool saveAccount:loginModel];
        if (success) {
            success(loginModel);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginWithEmail:(NSString *)email
                  code:(NSString *)code
               success:(void (^)(ECAccountModel *responseObj))success
               failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"email":email,
                            @"code":code
                            };
    
    [ECHttpRequest postWithURLString:api_login_Code param:param resultClass:[ECAccountModel class] success:^(id responseObj) {
        ECAccountModel *loginModel = (ECAccountModel *)responseObj;
        loginModel.email = email;
        [ECAccountTool saveAccount:loginModel];
        if (success) {
            success(loginModel);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginCodeWithEmail:(NSString *)email
                   success:(void (^)(ECAccountModel *responseObj))success
                   failure:(void (^)(NSString *errorMsg))failure {
    
    NSDictionary *param = @{
                            @"email":email
                            };
    [ECHttpRequest getWithURLString:api_login_send_emilCode param:param resultClass:nil success:^(id responseObj) {
        if (success) {
            success(nil);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)registerWithRegisterModel:(ECRegisterModel *)registerModel
                          success:(void (^)(ECAccountModel *responseObj))success
                          failure:(void (^)(NSString *errorMsg))failure {
    registerModel.password = [YSCryptor MD5:registerModel.password];
    NSDictionary *param = registerModel.mj_keyValues;
    
    [ECHttpRequest postWithURLString:api_login_register param:param resultClass:[ECAccountModel class] isContentTypeJson:YES success:^(id responseObj) {
        ECAccountModel *loginModel = (ECAccountModel *)responseObj;
        loginModel.email = registerModel.email;
        [ECAccountTool saveAccount:loginModel];
        
        if (success) {
            success(nil);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)uploadLicence:(UIImage *)image success:(void (^)(ECAccountModel *responseObj))success
              failure:(void (^)(NSString *errorMsg))failure{
    [ECHttpRequest postUploadWithURLString:@"" image:nil resultClass:nil success:^(id responseObj) {
        if (success) {
            success(nil);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginCompanyTypeWithSuccess:(void (^)(NSMutableArray *companyTypeArray))success
                            failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_login_companyType param:nil resultClass:nil success:^(id responseObj) {
        if (success) {
            success(responseObj?[ECCompanyModel mj_objectArrayWithKeyValuesArray:responseObj]:nil);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginStateTypeWithSuccess:(void (^)(NSMutableArray *stateArray))success
                          failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_login_state param:nil resultClass:nil success:^(id responseObj) {
        if (success) {
            success(responseObj?[ECStateModel mj_objectArrayWithKeyValuesArray:responseObj]:nil);
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
