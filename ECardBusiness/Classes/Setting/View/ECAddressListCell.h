//
//  ECAddressListCell.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECAddressModel.h"

@class ECAddressListCell;

// 声明一个协议
@protocol BSAddressListCellDelegate <NSObject>
@optional
// 删除地址
- (void)addressListCellDeleteClicked:(ECAddressListCell *)addressListCell;

// 选中为默认地址
- (void)addressListCellDidSelectedClicked:(ECAddressListCell *)addressListCell;

// 编辑地址
- (void)addressListCellEditClicked:(ECAddressListCell *)addressListCell;
@end

@interface ECAddressListCell : UITableViewCell

@property (nonatomic,weak) id<BSAddressListCellDelegate> delegate;

@property(nonatomic, strong) ECAddressModel *addressModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

