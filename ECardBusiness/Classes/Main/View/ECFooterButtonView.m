//
//  ECFooterButtonView.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/18.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECFooterButtonView.h"

@interface ECFooterButtonView()
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, copy) void(^eventTouchUpInsideHandler)(void);
@end

@implementation ECFooterButtonView

// 高度为49
- (instancetype)initWithTop:(CGFloat)top {
    self = [super initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 49)];
    if (self) {
        [self createButtonView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createButtonView];
    }
    return self;
}

- (void)createButtonView {
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.nextButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.nextButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.nextButton setTintColor:[UIColor whiteColor]];
    [self.nextButton setTitleColor:UIColorFromHex(0xbfbfbf) forState:UIControlStateDisabled];
    [self.nextButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
    [self.nextButton setTitleColor:UIColorFromHex(0xffcae8) forState:UIControlStateHighlighted];
    [_nextButton setBackgroundColor:UIColorFromHex(0x35519F)];
//    UIImage *normalImage = _ResizeImage([UIImage imageNamed:@"vp_btn_violet_normal"]);
//    [self.nextButton setBackgroundImage:normalImage forState:UIControlStateNormal];
//    UIImage *disableImage = _ResizeImage([UIImage imageNamed:@"vp_btn_violet_disable"]);
//    [self.nextButton setBackgroundImage:disableImage forState:UIControlStateDisabled];
//    UIImage *hightedImage = _ResizeImage([UIImage imageNamed:@"vp_btn_violet_pressed"]);
//    [self.nextButton setBackgroundImage:hightedImage forState:UIControlStateHighlighted];
//    self.nextButton.enabled = NO;
    [self addSubview:self.nextButton];
    @weakify(self)
    [self.nextButton bk_addEventHandler:^(id sender) {
        @strongify(self)
        if (self.eventTouchUpInsideHandler) {
            self.eventTouchUpInsideHandler();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)addEventTouchUpInsideHandler:(void (^)(void))handler {
    self.eventTouchUpInsideHandler = handler;
}

- (void)setFooterButtonTitle:(NSString *)title {
    [self.nextButton setTitle:title forState:UIControlStateNormal];
}

@end
