//
//  ECSettingService.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECSettingService.h"
#import "ECBankCardModel.h"

@implementation ECSettingService

+ (void)getTotenWithSuccess:(void (^)(NSString *token))success
                    failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_user_iavToken param:nil resultClass:nil success:^(id responseObj) {
        success(responseObj[@"iavToken"]);
    } failure:failure];
}

+ (void)bankCardListWithSuccess:(void (^)(NSArray *bankCardArray))success
                        failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_user_bankcardList param:nil resultClass:nil success:^(id responseObj) {
        success(responseObj?[ECBankCardModel mj_objectArrayWithKeyValuesArray:responseObj]:nil);
    } failure:failure];
}

+ (void)bankCardDeleteWithFsId:(NSString *)fsId
                        fsType:(NSString *)fsType
                       success:(void (^)(NSString *token))success
                       failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"fsId":fsId,
                            @"fsType":fsType
                            };
    [ECHttpRequest postWithURLString:api_user_bankcardDelete param:param resultClass:nil success:^(id responseObj) {
        success(nil);
    } failure:failure];
}

+ (void)addressListWithSuccess:(void (^)(NSMutableArray *addressArray))success
                       failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_user_addressList param:nil resultClass:nil success:^(id responseObj) {
        success(responseObj?[ECAddressModel mj_objectArrayWithKeyValuesArray:responseObj]:nil);
    } failure:failure];
}

+ (void)addressSaveWithParam:(ECAddressReqModel *)addressModel
                     success:(void (^)(ECAddressModel *model))success
                     failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = addressModel.mj_keyValues;
    [ECHttpRequest postWithURLString:api_user_addressSave param:param resultClass:nil isContentTypeJson:YES success:^(id responseObj) {
        success(nil);
    } failure:failure];
}

//接口名称 更新地址(商铺)联系电话
+ (void)addressPhoneUpdateWithStoreId:(NSString *)storeId contact:(NSString *)contact
                              success:(void (^)(ECAddressModel *model))success
                              failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"contact":contact,
                            @"storeId":storeId
                            };
    [ECHttpRequest postWithURLString:api_user_updateContact param:param resultClass:nil success:^(id responseObj) {
        success(nil);
    } failure:failure];
}

+ (void)openTimeUpdateWithParam:(ECOpenTimeUpdateModel *)openTimeUpdateModel
                     success:(void (^)(id responseObj))success
                     failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = openTimeUpdateModel.mj_keyValues;
    [ECHttpRequest postWithURLString:api_user_updateOpenTime param:param resultClass:nil isContentTypeJson:YES success:^(id responseObj) {
        success(nil);
    } failure:failure];
}

+ (void)businessStoreListWithSuccess:(void (^)(NSMutableArray *openList))success
                             failure:(void (^)(NSString *errorMsg))failure {
    [ECHttpRequest getWithURLString:api_user_queryMerchantStore param:nil resultClass:nil success:^(NSMutableArray *openList) {
        success(openList?[ECOpeningModel mj_objectArrayWithKeyValuesArray:openList]:nil);
    } failure:failure];
}

+ (void)updateAvatarWithUrl:(NSString *)url
                    success:(void (^)(id responseObj))success
                             failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *param = @{
                            @"avatarUrl":url
                            };
    [ECHttpRequest postWithURLString:api_user_updateAvatar param:param resultClass:nil success:^(NSMutableArray *openList) {
        success(nil);
    } failure:failure];
}

@end
