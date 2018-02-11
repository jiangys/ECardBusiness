//
//  ECBalanceCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/11.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECBalanceCell : UITableViewCell
@property(nonatomic, strong) ECAddressModel *addressModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
