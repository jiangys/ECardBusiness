//
//  ECRegisterTool.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/22.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECRegisterModel.h"

@interface ECRegisterTool : NSObject

+ (void)saveRegisterModel:(ECRegisterModel *)registerModel;
+ (ECRegisterModel *)getRegisterModel;

@end
