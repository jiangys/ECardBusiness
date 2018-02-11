//
//  ECOpeningTimeItemModel.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECOpeningTimeItemModel : NSObject
@property (nonatomic, copy) NSString *week;
/** 开始营业时间    string    如 09:30 */
@property (nonatomic, copy) NSString *am;
// 结束营业截止时间    string    如 17:45
@property (nonatomic, copy) NSString *pm;
@end
