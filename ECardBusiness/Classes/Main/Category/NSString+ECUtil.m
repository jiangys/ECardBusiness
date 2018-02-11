//
//  NSString+ECUtil.m
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "NSString+ECUtil.h"

@implementation NSString (ECUtil)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return ceil([self sizeMakeWithFont:font constrainedToWidth:width constrainedToHeight:CGFLOAT_MAX].height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    return ceil([self sizeMakeWithFont:font constrainedToWidth:CGFLOAT_MAX constrainedToHeight:height].width);
}

/**
 *  计算文字的宽高
 *  使用方法 [strText sizeMakeWithFont:[UIFont systemFontOfSize:12] maxW:100];
 *
 *  @param font 字体大小
 *  @param maxW 字体所在的范围的宽度
 *
 *  @return 返回字体所在的范围宽度下的高度。即知道宽，计算高
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font
{
    return [self sizeMakeWithFont:font constrainedToWidth:MAXFLOAT];
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    return [self sizeMakeWithFont:font constrainedToWidth:CGFLOAT_MAX constrainedToHeight:height];
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *  @param height 约束高度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, height)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end
