//
//  ECCashDeskViewController.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/30.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^amountAction)(NSString *amount);

@interface ECCashDeskViewController : UIViewController
@property (nonatomic, copy) amountAction amountAction;
@end
