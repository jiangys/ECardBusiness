//
//  NSString+ECUtil.h
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ECUtil)

#pragma mark - 计算文本所占的宽高

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  计算文字的宽高
 *  使用方法 [strText sizeMakeWithFont:[UIFont systemFontOfSize:12]];
 *
 *  @param font 字体大小
 *
 *  @return 返回字体所在的范围宽度下的高度。即知道宽，计算高
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *  @param height 约束高度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width constrainedToHeight:(CGFloat)height;

@end
