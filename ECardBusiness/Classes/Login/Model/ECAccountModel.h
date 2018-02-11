//
//  ECAccountModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECAccountModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *session;
@property (nonatomic, copy) NSString *email;
@end
