//
//  UIBarButtonItem+Extension.h
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)imageName hightlightedImage:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector;

+ (instancetype)itemWithImage:(NSString *)imageName hightlightedImage:(NSString *)highlightedImageName title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector;
@end
