//
//  ECBalanceDetailViewController.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECBalanceDetailViewController : UIViewController
/** transactionTypeList 0所有，1顾客，2我的 */
@property (nonatomic, copy) NSString *transactionType;
@end
