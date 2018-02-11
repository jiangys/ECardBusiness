//
//  ECService.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/1.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECUserInfoModel.h"

@interface ECService : NSObject

// 上传头像
+ (void)uploadImage:(UIImage *)image
            success:(void (^)(NSString *imageUrl))success
            failure:(void (^)(NSString *errorMsg))failure;

// 获取用户基本信息
+ (void)getUserInfo:(NSString *)userId
            success:(void (^)(ECUserInfoModel *userModel))success
            failure:(void (^)(NSString *errorMsg))failure;

@end
