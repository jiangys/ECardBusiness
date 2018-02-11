//
//  ECAddressOpeningTimeViewCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECOpeningModel.h"

@interface ECAddressOpeningTimeViewCell : UITableViewCell
@property(nonatomic, strong) ECOpeningModel *openModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  点击确定按钮Block
 */
- (void)addEventTouchUpInsideHandler:(void (^)(void))handler;
@end
