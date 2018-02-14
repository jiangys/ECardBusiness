//
//  ECService.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/1.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECService.h"
#import "FCUUID.h"

@implementation ECService

+ (void)uploadImage:(UIImage *)image
            success:(void (^)(NSString *imageUrl))success
            failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest postUploadWithURLString:api_uploadImage image:image resultClass:nil success:^(id responseObj) {
        success(responseObj[@"imageUrl"]);
    } failure:failure];
}

+ (void)getUserInfo:(NSString *)userId
            success:(void (^)(ECUserInfoModel *userModel))success
            failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"userId":userId
                            };
    [ECHttpRequest getWithURLString:api_user_info param:param resultClass:[ECUserInfoModel class] success:^(id responseObj) {
        success((ECUserInfoModel *)responseObj);
    } failure:failure];
}

+ (void)getAccountWithSuccess:(void (^)(ECUserAccountModel *responseObj))success
                      failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"userType":@"2"
                            };
    [ECHttpRequest getWithURLString:api_home_account param:param resultClass:[ECUserAccountModel class] success:^(id responseObj) {
        success((ECUserAccountModel *)responseObj);
    } failure:failure];
}

+ (void)submitWithdrawWithPaySecret:(NSString *)paySecret
                   foundingSourceId:(NSString *)foundingSourceId
                            success:(void (^)(id responseObj))success
                     paySecretBlock:(void (^)(void))paySecretBlock
                            failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"paySecret":paySecret.length > 0 ? paySecret:@"",
                            @"foundingSourceId" : foundingSourceId,
                            @"transactionNo":[FCUUID uuidForDevice]
                            };
    [ECHttpRequest postWithURLString:api_home_withdraw param:param isContentTypeJson:YES success:^(id responseObj) {
        if ([responseObj[@"code"] integerValue] == 200) {
            success(nil);
        } else if ([responseObj[@"code"] integerValue] == 401){
            paySecretBlock(); // 401-需要支付码或支付码错误
        } else {
            failure(responseObj[@"msg"]);
        }
    } failure:^(NSError *error) {
        failure(@"系统繁忙，请稍后再试");
    }];
}


@end
