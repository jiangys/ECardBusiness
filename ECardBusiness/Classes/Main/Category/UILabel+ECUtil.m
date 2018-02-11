
//
//  UILabel+ECUtil.m
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "UILabel+ECUtil.h"
#import "NSString+ECUtil.h"

@implementation UILabel (ECUtil)

+ (UILabel * _Nonnull)initWithFont:(UIFont *)font color:(UIColor * _Nonnull)color {
    return [UILabel initWithFrame:CGRectZero text:@"" font:font color:color alignment:NSTextAlignmentLeft lines:0 shadowColor:[UIColor clearColor]];
}

+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame text:(NSString * _Nonnull)text font:(UIFont *)font color:(UIColor * _Nonnull)color {
    return [UILabel initWithFrame:frame text:text font:font color:color alignment:NSTextAlignmentLeft lines:0 shadowColor:[UIColor clearColor]];
}

+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame text:(NSString * _Nonnull)text font:(UIFont *)font color:(UIColor * _Nonnull)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines {
    return [UILabel initWithFrame:frame text:text font:font color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor]];
}

+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame text:(NSString * _Nonnull)text font:(UIFont *)font color:(UIColor * _Nonnull)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor * _Nonnull)colorShadow {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = lines;
    label.textAlignment = alignment;
    label.textColor = color;
    label.shadowColor = colorShadow;
    
    return label;
}

- (CGFloat)calculatedHeight {
    return [self.text heightWithFont:self.font constrainedToWidth:self.frame.size.width];
}

- (void)setFont:(UIFont * _Nonnull)font fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    [self setAttributedText:attributedString];
}

- (void)setColor:(UIColor * _Nonnull)color fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    [self setAttributedText:attributedString];
}

- (void)setDeleteLineAtFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(fromIndex, toIndex)];
    [self setAttributedText:attributedString];
}

@end
