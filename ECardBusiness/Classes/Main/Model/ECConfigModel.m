//
//  ECConfigModel.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/6.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECConfigModel.h"

@implementation ECConfigModel

+ (instancetype)defaultModel {
    static ECConfigModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [self new];
    });
    return model;
}

@end
