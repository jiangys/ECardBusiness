//
//  ECAddressListModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECAddressModel : NSObject
@property (nonatomic, copy) NSString *addressNo; //地址编号
@property (nonatomic, copy) NSString *address1;
@property (nonatomic, copy) NSString *address2;
@property (nonatomic, copy) NSString *fullAddress;
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, copy) NSString *cnName;
@end
