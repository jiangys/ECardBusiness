//
//  ECHttpRequest.h
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECHttpRequest : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)getWithURLString:(NSString *)url
                   param:(id)params
             resultClass:(Class)resultClass
                 success:(void (^)(id responseObj))success
                 failure:(void (^)(NSString *error))failure;

+ (void)postWithURLString:(NSString *)url
                    param:(id)params
        isContentTypeJson:(BOOL)isContentTypeJson
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSError * error))failure;
/**
 *  发送一个POST请求
 */
+ (void)postWithURLString:(NSString *)url
                    param:(id)params
              resultClass:(Class)resultClass
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSString *error))failure;

+ (void)postWithURLString:(NSString *)url
                    param:(id)params
              resultClass:(Class)resultClass
        isContentTypeJson:(BOOL)isContentTypeJson
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSString *error))failure;

+ (void)postUploadWithURLString:(NSString *)url
                          image:(UIImage *)image
                    resultClass:(Class)resultClass
                        success:(void (^)(id responseObj))success
                        failure:(void (^)(NSString *error))failure;

@end
