//
//  ECSettingService.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAddressModel.h"
#import "ECAddressReqModel.h"
#import "ECOpenTimeUpdateModel.h"
#import "ECOpeningModel.h"

@interface ECSettingService : NSObject

// 获取用户token ，用于请求H5
+ (void)getTotenWithSuccess:(void (^)(NSString *token))success
                    failure:(void (^)(NSString *errorMsg))failure;

// 银行卡列表
+ (void)bankCardListWithSuccess:(void (^)(NSArray *bankCardArray))success
                        failure:(void (^)(NSString *errorMsg))failure;

// 删除银行卡
+ (void)bankCardDeleteWithFsId:(NSString *)fsId
                        fsType:(NSString *)fsType
                       success:(void (^)(NSString *token))success
                       failure:(void (^)(NSString *errorMsg))failure;

+ (void)addressListWithSuccess:(void (^)(NSMutableArray *addressArray))success
                       failure:(void (^)(NSString *errorMsg))failure;

+ (void)addressSaveWithParam:(ECAddressReqModel *)addressModel
                     success:(void (^)(ECAddressModel *model))success
                     failure:(void (^)(NSString *errorMsg))failure;

// 接口名称 更新地址(商铺)联系电话
+ (void)addressPhoneUpdateWithStoreId:(NSString *)storeId contact:(NSString *)contact
                              success:(void (^)(ECAddressModel *model))success
                              failure:(void (^)(NSString *errorMsg))failure;

// 更新地址(商铺)营业时间
+ (void)openTimeUpdateWithParam:(ECOpenTimeUpdateModel *)openTimeUpdateModel
                        success:(void (^)(id responseObj))success
                        failure:(void (^)(NSString *errorMsg))failure;

// 获取商家商铺列表
+ (void)businessStoreListWithSuccess:(void (^)(NSMutableArray *openList))success
                             failure:(void (^)(NSString *errorMsg))failure;

// 更新头像
+ (void)updateAvatarWithUrl:(NSString *)url
                    success:(void (^)(id responseObj))success
                    failure:(void (^)(NSString *errorMsg))failure;

@end
