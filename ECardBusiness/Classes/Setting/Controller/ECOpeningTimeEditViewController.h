//
//  ECOpeningTimeEditViewController.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECOpeningOptionModel.h"

@interface ECOpeningTimeEditViewController : UIViewController
@property (nonatomic) BOOL isEdit;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, strong) ECOpeningOptionModel *optional1;
@property (nonatomic, strong) ECOpeningOptionModel *optional2;
@property (nonatomic, strong) ECOpeningOptionModel *optional3;
@end
