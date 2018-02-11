//
//  ECSettingCellDataSource.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/9.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECSettingCellDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>
/** 数据源 */
@property(nonatomic, strong) NSMutableArray *groupArray;
/** 初始化 数据源 */
+ (instancetype)itemWithGroupArray:(NSMutableArray *)groupArray;
@end
