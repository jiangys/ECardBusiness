//
//  YSTextField.m
//  UtilsTest
//
//  Created by yongsheng.jiang on 2018/1/9.
//  Copyright © 2018年 vipshop. All rights reserved.
//

#import "YSTextField.h"
#import "UIView+Utils.h"
#import "NSString+ECUtil.h"

@interface YSTextField()<UITextFieldDelegate>
/** 底部分割线 */
@property (nonatomic, strong) UIView *bottomLine;
/** 左侧小图标 */
@property (nonatomic, strong) UIImageView *leftImageView;
/** 错误提示文本 */
@property (nonatomic, strong) UILabel *errorLabel;
@end

@implementation YSTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(0, 0, self.width, 43)];
        self.textField.floatingLabelFont = [UIFont systemFontOfSize:12];
        self.textField.placeholderColor = UIColorFromHex(0x666666);
        self.textField.floatingLabelTextColor = UIColorFromHex(0x35519f);
        self.textField.floatingLabelActiveTextColor = UIColorFromHex(0x35519f);
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.delegate = self;
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = UIColorFromHex(0x333333);
        [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.textField.height, self.width, 1)];
        _bottomLine.backgroundColor = UIColorFromHex(0xcccccc);
        [self addSubview:_bottomLine];
        
        [self setupErrorTips];
    }
    return self;
}

- (void)setRightButtonWithTitle:(NSString *)title block:(void (^)(void))block {
    CGSize titleSize = [title sizeMakeWithFont:[UIFont systemFontOfSize:14]];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.width - titleSize.width, 10, titleSize.width, 25)];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton setTitleColor:UIColorMain_Highlighted forState:UIControlStateNormal];
    [rightButton bk_addEventHandler:^(id sender) {
        if (block) {
            block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    self.textField.width = self.width - titleSize.width;
}

- (void)setupErrorTips {
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_textField.left, _textField.bottom + 5, 13, 13)];
    _leftImageView.image = [UIImage imageNamed:@"register_error_icon_nor"];
    [self addSubview:_leftImageView];
    _leftImageView.hidden = YES;
    
    _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right + 5, _textField.bottom + 3, SCREEN_WIDTH, 15)];
    _errorLabel.font = [UIFont systemFontOfSize:12];
    _errorLabel.textColor = UIColorFromHex(0xD0011B);
    [self addSubview:_errorLabel];
    _errorLabel.hidden = YES;
}

#pragma mark - 私有方法

- (NSString *)text {
    return _textField.text;
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle {
    [_textField setPlaceholder:placeholder floatingTitle:floatingTitle];
}

- (void)setErrorShow:(BOOL)isShow errorTitle:(NSString *)errorTitle {
    if (isShow) {
        _leftImageView.hidden = NO;
        _errorLabel.hidden = NO;
        _errorLabel.text = errorTitle;
        self.bottomLine.backgroundColor = UIColorFromHex(0xD0011B);
    } else {
        _leftImageView.hidden = YES;
        _errorLabel.hidden = YES;
        _errorLabel.text = @"";
        self.bottomLine.backgroundColor = UIColorFromHex(0xcccccc);
    }
}

- (void)setShowText:(NSString *)showText {
    if (showText.length > 0 ) {
        _textField.text = showText;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bottomLine.backgroundColor = UIColorFromHex(0x35519f);
        } completion:nil];
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldEditingChanged:(UITextField *)sender {
    if (sender.text.length > 0) {
        if (_errorLabel.text.length > 0) {
            [self setErrorShow:NO errorTitle:nil];
        }
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bottomLine.backgroundColor = UIColorFromHex(0x35519f);
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bottomLine.backgroundColor = UIColorFromHex(0xcccccc);
        } completion:nil];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];
    }
}

@end
