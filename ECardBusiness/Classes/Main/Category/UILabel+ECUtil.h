//
//  UILabel+ECUtil.h
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ECUtil)
+ (UILabel * _Nonnull)initWithFont:(UIFont * _Nonnull)font
                             color:(UIColor * _Nonnull)color;

+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame
                               text:(NSString * _Nonnull)text
                               font:(UIFont * _Nonnull)font
                              color:(UIColor * _Nonnull)color;

/**
 *  Create an UILabel with the given parameters, with clearColor for the shadow
 *
 *  @param frame     Label's frame
 *  @param text      Label's text
 *  @param font      Label's font name, FontName enum is declared in UIFont+YSKit
 *  @param color     Label's text color
 *  @param alignment Label's text alignment
 *  @param lines     Label's text lines
 *
 *  @return Returns the created UILabel
 */
+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame
                               text:(NSString * _Nonnull)text
                               font:(UIFont * _Nonnull)font
                              color:(UIColor * _Nonnull)color
                          alignment:(NSTextAlignment)alignment
                              lines:(NSInteger)lines;

/**
 *  Create an UILabel with the given parameters
 *
 *  @param frame       Label's frame
 *  @param text        Label's text
 *  @param font        Label's font name, FontName enum is declared in UIFont+YSKit
 *  @param color       Label's text color
 *  @param alignment   Label's text alignment
 *  @param lines       Label's text lines
 *  @param colorShadow Label's text shadow color
 *
 *  @return Returns the created UILabel
 */
+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame
                               text:(NSString * _Nonnull)text
                               font:(UIFont * _Nonnull)font
                              color:(UIColor * _Nonnull)color
                          alignment:(NSTextAlignment)alignment
                              lines:(NSInteger)lines
                        shadowColor:(UIColor * _Nonnull)colorShadow;


/**
 *  Calculates height based on text, width and font
 *
 *  @return Returns calculated height
 */
- (CGFloat)calculatedHeight;

/**
 *  Sets a custom font from a character at an index to character at another index
 *
 *  @param font      New font to be setted
 *  @param fromIndex The start index
 *  @param toIndex   The end index
 */
- (void)setFont:(UIFont * _Nonnull)font
      fromIndex:(NSInteger)fromIndex
        toIndex:(NSInteger)toIndex;

- (void)setColor:(UIColor * _Nonnull)color
       fromIndex:(NSInteger)fromIndex
         toIndex:(NSInteger)toIndex;

/**
 *  设置文本带删除线
 *  当文本只是中文，或者只是英文+数字时，可以直接使用。
 *  当文本是中文+英文时，会有折线，介意的话，可以使用VSDeleteLineLabel
 *
 *  @param fromIndex The start index
 *  @param toIndex   The end index
 */
- (void)setDeleteLineAtFromIndex:(NSInteger)fromIndex
                         toIndex:(NSInteger)toIndex;
@end
