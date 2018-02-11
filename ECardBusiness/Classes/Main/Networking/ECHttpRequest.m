//
//  ECHttpRequest.m
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECHttpRequest.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@implementation ECHttpRequest

+ (void)getWithURLString:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    if ([ECAccountTool getAccount].session.length > 0) {
        [mgr.requestSerializer setValue:[ECAccountTool getAccount].session forHTTPHeaderField:@"s"];
    }
    [mgr.requestSerializer setValue:@"app" forHTTPHeaderField:@"p"];
    // 3.发送GET请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)url isContentTypeJson:(BOOL)isContentTypeJson params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 请求的数据格式为application/json
    if (isContentTypeJson) {
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    if ([ECAccountTool getAccount].session.length > 0) {
        [mgr.requestSerializer setValue:[ECAccountTool getAccount].session forHTTPHeaderField:@"s"];
    }
    [mgr.requestSerializer setValue:@"app" forHTTPHeaderField:@"p"];
    
    // 加上这行代码，https ssl 验证。
    //    if(openHttpsSSL)
    //    {
    //        [mgr setSecurityPolicy:[self customSecurityPolicy]];
    //    }
    
    // 4.发送POST请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  返回result下data 数组模型
 */
+ (void)getWithURLString:(NSString *)url
                   param:(id)params
             resultClass:(Class)resultClass
                 success:(void (^)(id responseObj))success
                 failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *dictParams = [self requestParams:params];
    NSString *handleUrl = [NSString stringWithFormat:@"%@%@",ECMacro_Api,url];
    ECLog(@"\n请求链接地址---> %@",handleUrl);
    ECLog(@"\n请求Session---> %@",[ECAccountTool getAccount].session);
    [self getWithURLString:handleUrl params:dictParams success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil];;
        ECLog(@"请求成功，返回数据 : %@",dict);
        if ([dict[@"code"] integerValue] == 200) {
            if (!resultClass) {
                success(dict[@"data"]);
            } else {
                success([resultClass mj_objectWithKeyValues:dict[@"data"]]);
            }
        } else {
            failure(dict[@"msg"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(@"系统繁忙，请稍后再试");
        }
    }];
}

+ (void)postWithURLString:(NSString *)url
                    param:(id)params
              resultClass:(Class)resultClass
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSString *error))failure {
    [self postWithURLString:url param:params resultClass:resultClass isContentTypeJson:NO success:success failure:failure];
}

+ (void)postWithURLString:(NSString *)url
                    param:(id)params
              resultClass:(Class)resultClass
        isContentTypeJson:(BOOL)isContentTypeJson
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *dictParams = [self requestParams:params];
    NSString *handleUrl = [NSString stringWithFormat:@"%@%@",ECMacro_Api,url];
    ECLog(@"\n请求链接地址---> %@",handleUrl);
    ECLog(@"\n请求Session---> %@",[ECAccountTool getAccount].session);
    [self postWithURLString:handleUrl isContentTypeJson:isContentTypeJson params:dictParams success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil];
        ECLog(@"请求成功，返回数据 : %@",dict);
        if ([dict[@"code"] integerValue] == 200) {
            if (!resultClass) {
                success(dict[@"data"]);
            } else {
                success([resultClass mj_objectWithKeyValues:dict[@"data"]]);
            }
        } else {
            failure(dict[@"msg"]);
        }
    } failure:^(NSError *error) {
        ECLog(@"请求失败 : %@",error);
        if (failure) {
            failure(@"系统繁忙，请稍后再试");
        }
    }];
}

/**
 *  AFN 3.0 上传
 *      有两种方式
 *          upLoad1 和 upLoad2
 */
+ (void)postUploadWithURLString:(NSString *)url
                          image:(UIImage *)image
                    resultClass:(Class)resultClass
                        success:(void (^)(id responseObj))success
                        failure:(void (^)(NSString *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    NSString *handleUrl = [NSString stringWithFormat:@"%@%@",ECMacro_Api,url]; // @"http://api.ecard/file/avatar/upload";
    [manager POST:handleUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imageName = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
        
        //图片二进制文件
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        ECLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
        
        //这个就是参数
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        //WKNSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        ECLog(@"图片 请求成功：%@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];;
        if ([dict[@"code"] integerValue] == 200) {
            if (!resultClass || !dict[@"data"]) {
                success(dict[@"data"]);
            } else {
                success([resultClass mj_objectWithKeyValues:dict[@"data"]]);
            }
        } else {
            failure(dict[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ECLog(@"请求失败：%@",error);
        if (failure) {
            failure(@"系统繁忙，请稍后再试");
        }
    }];
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        //WKNSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        //WKNSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        //WKNSLog(@"请求失败：%@",error);
    }];
}


+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

+ (NSMutableDictionary *)requestParams:(id)params {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmm"];
    
    //    NSString *temptime = [dateFormat stringFromDate:[NSDate date]];
    //    NSString *apiKey = @"app.api";
    //    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
    if ([params isKindOfClass:[NSDictionary class]]) {
        dictParams = [((NSMutableDictionary *)params) mutableCopy];
    } else {
        NSDictionary *dict = [params class].mj_keyValues;
        dictParams = (NSMutableDictionary *)dict;
    }
    
    //    [dictParams setObject:apiKey forKey:@"api_key"];
    //    [dictParams setObject:temptime forKey:@"temptime"];
    //    [dictParams setObject:version forKey:@"version"];
    
    ECLog(@"网络请求参数--->\n %@",dictParams);
    return dictParams;
}

@end
