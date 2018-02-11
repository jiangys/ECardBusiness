//
//  ECRegisterModel.h
//  Spec
//
//  Created by yongsheng.jiang on 2018/1/16.
//  Copyright © 2018年 com.jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECOfficeHoursModel.h"

@interface ECRegisterModel : NSObject
/** 完整地址1 */
@property (nonatomic, copy) NSString *address1;
/** 完整地址2 */
@property (nonatomic, copy) NSString *address2;
/** 头像地址 */
@property (nonatomic, copy) NSString *avatarUrl;
/** 卡片类型 1:金卡 2:银卡 */
@property (nonatomic, copy) NSString *cardType;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 公司中文名  */
@property (nonatomic, copy) NSString *companyCNName;
/** 公司英文名 */
@property (nonatomic, copy) NSString *companyENName;
/** 公司类型 */
@property (nonatomic, copy) NSString *companyType;
/** 该用户在dwolla上的对应账户 */
@property (nonatomic, copy) NSString *dowllaCustomerId;
/** 邮箱 */
@property (nonatomic, copy) NSString *email;
/** 现金返还百分比 */
@property (nonatomic, copy) NSString *extraRate;
/** 名 */
@property (nonatomic, copy) NSString *firstName;
/** 邀请码 */
@property (nonatomic, copy) NSString *invitationCode;
/** 姓 */
@property (nonatomic, copy) NSString *lastName;
/** 店铺地址纬度 */
@property (nonatomic, copy) NSString *lat;
/** 店铺地址精度 */
@property (nonatomic, copy) NSString *lng;
/** 营业执照图片链接 */
@property (nonatomic, copy) NSString *licenceUrl;
/** 邮箱验证码 */
@property (nonatomic, copy) NSString *mailCode;
/** middleName */
@property (nonatomic, copy) NSString *middleName;
/** 是否需要邮件提醒交易，0:否 1:是 */
@property (nonatomic, copy) NSString *needEmailRemind;
/** 必填营业时间 */
@property (nonatomic, strong) ECOfficeHoursModel *officeHours;
/** 选填营业时间（内容参考officeHours这个对象,嘿嘿） */
@property (nonatomic, copy) ECOfficeHoursModel *optionalOfficeHours1;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 支付密码  */
@property (nonatomic, copy) NSString *paySecret;
/** 电话 */
@property (nonatomic, copy) NSString *phone;
/** 省、州 */
@property (nonatomic, copy) NSString *province;
/** 省id */
@property (nonatomic, copy) NSString *provinceId;
/** 用户类型（1:客户 2:商家） */
@property (nonatomic, copy) NSString *type;
/** 邮编 */
@property (nonatomic, copy) NSString *zipCode;
@end


@interface ECCompanyModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cateName;
@end

@interface ECStateModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *zipCode;
@end



