//
//  ECUserInfo.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/5.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECUserInfoModel : NSObject
@property (nonatomic, copy) NSString *briefAddress; //粗略地址
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *cardType; //卡片类型1:金卡 2:银卡
@property (nonatomic, copy) NSString *fullAddress; //完整地址
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *zipCode; //邮编
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *cnName;
@property (nonatomic, copy) NSString *enName;
@end
