//
//  ECWithdrawCardCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/13.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECBankCardModel.h"

@interface ECWithdrawCardCell : UITableViewCell
@property (nonatomic, strong) ECBankCardModel *bankCardModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellSelected:(BOOL)selected;
@end
