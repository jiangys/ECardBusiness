//
//  ECFooterButtonView.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/18.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ECFooterButtonView;

@protocol ECFooterButtonViewDelegate <NSObject>

@optional
@end

@interface ECFooterButtonView : UIView

- (instancetype)initWithTop:(CGFloat)top;
/**
 *  更新按钮显示文本
 *
 *  @param title 需要显示的文本
 */
- (void)setFooterButtonTitle:(NSString *)title;

/**
 *  点击确定按钮Block
 */
- (void)addEventTouchUpInsideHandler:(void (^)(void))handler;

@end
