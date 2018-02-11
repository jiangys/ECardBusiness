//
//  UIBarButtonItem+Extension.m
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)imageName hightlightedImage:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector {
    return [self itemWithImage:imageName hightlightedImage:highlightedImageName title:nil titleColor:nil target:target selector:selector];
}

+ (instancetype)itemWithImage:(NSString *)imageName hightlightedImage:(NSString *)highlightedImageName title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector {
    UIBarButtonItem *item = [[self alloc] init];
    
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    // 一定要设置frame，才能显示
    //[button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, image.size.height)];
    if (title.length > 0) {
        CGSize titleSize = [title sizeMakeWithFont:[UIFont systemFontOfSize:16]];
         button.frame = CGRectMake(0, 0, 32 + titleSize.width, 32);
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setImageEdgeInsets: UIEdgeInsetsMake(0, 0, 0, 10)];
        
        if (titleColor) {
            [button setTitleColor:titleColor forState:UIControlStateNormal];
        }
    } else {
         button.frame = CGRectMake(0, 0, 32, 32);
    }
    
    // 设置事件
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    item.customView = button;
    return item;
}

@end
