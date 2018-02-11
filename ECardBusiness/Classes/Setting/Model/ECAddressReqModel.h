//
//  ECAddressModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECAddressReqModel : NSObject
/** 完整地址1 */
@property (nonatomic, copy) NSString *address1;
/** 完整地址2 */
@property (nonatomic, copy) NSString *address2;
@property (nonatomic, copy) NSString *cityName;
/** 省、州 */
@property (nonatomic, copy) NSString *stateName;
/** 省id */
@property (nonatomic, copy) NSString *stateId;
/** 邮编 */
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *userId;
@end
