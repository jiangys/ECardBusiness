//
//  ECRegisterTool.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/22.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECRegisterTool.h"

#define RegisterPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"register.archive"]

@implementation ECRegisterTool


+ (void)saveRegisterModel:(ECRegisterModel *)registerModel
{
    [NSKeyedArchiver archiveRootObject:registerModel toFile:RegisterPath];
}


+ (ECRegisterModel *)getRegisterModel
{
    ECRegisterModel *registerModel = [NSKeyedUnarchiver unarchiveObjectWithFile:RegisterPath];
    
    return registerModel;
}
@end
