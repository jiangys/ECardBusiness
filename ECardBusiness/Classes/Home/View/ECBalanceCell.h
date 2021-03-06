//
//  ECBalanceCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/11.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECBalanceBillModel.h"

@interface ECBalanceCell : UITableViewCell
@property(nonatomic, strong) ECBalanceBillModel *balanceModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
