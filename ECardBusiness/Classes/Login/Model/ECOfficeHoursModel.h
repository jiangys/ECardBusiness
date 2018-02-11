//
//  ECOfficeHours.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/21.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECOfficeHoursModel : NSObject
/** 开始营业时间    string    如 09:30 */
@property (nonatomic, copy) NSString *am;
// 结束营业截止时间    string    如 17:45
@property (nonatomic, copy) NSString *pm;
// 开始星期,1 星期一 7星期日
@property (nonatomic, copy) NSString *dayFrom;
// 截止星期    number    1～7之间的数字
@property (nonatomic, copy) NSString *dayTo;
@end
