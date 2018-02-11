//
//  YSTextField.h
//  UtilsTest
//
//  Created by yongsheng.jiang on 2018/1/9.
//  Copyright © 2018年 vipshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
@class YSTextField;

@protocol YSTextFieldDelegate <NSObject>

@optional
- (void)textFieldDidEndEditing:(YSTextField *)textField;
- (BOOL)textFieldShouldBeginEditing:(YSTextField *)textField;
@end

@interface YSTextField : UIView
@property (nonatomic, strong) JVFloatLabeledTextField *textField;
@property(nonatomic, copy)  NSString *text;                 // default is nil
@property (nonatomic, weak) id<YSTextFieldDelegate> delegate;

- (void)setRightButtonWithTitle:(NSString *)title block:(void (^)(void))block;
- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle;
- (void)setErrorShow:(BOOL)isShow errorTitle:(NSString *)errorTitle;
- (void)setShowText:(NSString *)showText;

@end
