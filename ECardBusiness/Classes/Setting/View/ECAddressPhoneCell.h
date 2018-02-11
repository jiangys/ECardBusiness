//
//  ECAddressPhoneCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/7.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECAddressModel.h"

@interface ECAddressPhoneCell : UITableViewCell
@property(nonatomic, strong) ECAddressModel *addressModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  点击确定按钮Block
 */
- (void)addEventTouchUpInsideHandler:(void (^)(void))handler;
@end
