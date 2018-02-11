//
//  ECConfigModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECUserInfoModel.h"

@interface ECConfigModel : NSObject

@property (nonatomic, strong) ECUserInfoModel *userModel;

+ (instancetype)defaultModel;

@end
