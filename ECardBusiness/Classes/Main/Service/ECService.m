//
//  ECService.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/1.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECService.h"

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

@end
