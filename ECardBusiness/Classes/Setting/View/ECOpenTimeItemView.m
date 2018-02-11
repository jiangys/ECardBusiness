//
//  ECOpenTimeItemView.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECOpenTimeItemView.h"

@interface ECOpenTimeItemView()
@property(nonatomic, strong) UILabel *monLabel;
@property(nonatomic, strong) UILabel *tueLabel;
@property(nonatomic, strong) UILabel *wenLabel;
@property(nonatomic, strong) UILabel *thuLabel;
@property(nonatomic, strong) UILabel *friLabel;
@property(nonatomic, strong) UILabel *satLabel;
@property(nonatomic, strong) UILabel *sunLabel;
@end

@implementation ECOpenTimeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self openTimeItemWithTop:0 itemTitle:@"星期一" itemNO:1]];
        [self addSubview:[self openTimeItemWithTop:35 itemTitle:@"星期二" itemNO:2]];
        [self addSubview:[self openTimeItemWithTop:35 * 2 itemTitle:@"星期三" itemNO:3]];
        [self addSubview:[self openTimeItemWithTop:35 * 3 itemTitle:@"星期四" itemNO:4]];
        [self addSubview:[self openTimeItemWithTop:35 * 4 itemTitle:@"星期五" itemNO:5]];
        [self addSubview:[self openTimeItemWithTop:35 * 5 itemTitle:@"星期六" itemNO:6]];
        [self addSubview:[self openTimeItemWithTop:35 * 6 itemTitle:@"星期日" itemNO:7]];
    }
    return self;
}

- (void)setOpenDayList:(ECOpeningTimeList *)openDayList {
    if (openDayList.mon) {
        _monLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.mon.am?:@"", openDayList.mon.pm?:@""];
    }
    
    if (openDayList.tue) {
        _tueLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.tue.am?:@"", openDayList.tue.pm?:@""];
    }
    
    if (openDayList.wen) {
        _wenLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.wen.am?:@"", openDayList.wen.pm?:@""];
    }
    
    if (openDayList.thu) {
        _thuLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.thu.am?:@"", openDayList.thu.pm?:@""];
    }
    
    if (openDayList.fri) {
        _friLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.fri.am?:@"", openDayList.fri.pm?:@""];
    }
    
    if (openDayList.sat) {
        _satLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.sat.am?:@"", openDayList.sat.pm?:@""];
    }
    
    if (openDayList.sun) {
        _sunLabel.text = [NSString stringWithFormat:@"%@am - %@pm",openDayList.sun.am?:@"", openDayList.sun.pm?:@""];
    }
}

- (UIView *)openTimeItemWithTop:(CGFloat)top itemTitle:(NSString *)itemTitle itemNO:(NSUInteger)itemNo {
    UIView *itemBgView = [[UIView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 35)];
    UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, itemBgView.width, itemBgView.height)];
    itemTitleLabel.textColor = UIColorMain_Gray;
    itemTitleLabel.font = [UIFont systemFontOfSize:15];
    itemTitleLabel.textAlignment = NSTextAlignmentLeft;
    itemTitleLabel.text = itemTitle;
    [itemBgView  addSubview:itemTitleLabel];
    
    UILabel *itemContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, itemBgView.width - 48, itemBgView.height)];
    itemContentLabel.textColor = UIColorMain_Gray;
    itemContentLabel.font = [UIFont systemFontOfSize:13];
    itemContentLabel.textAlignment = NSTextAlignmentRight;
    //itemContentLabel.text = [NSString stringWithFormat:@"%@am - %@pm",@"1", @"23"];
    [itemBgView  addSubview:itemContentLabel];
    switch (itemNo) {
        case 1:
            _monLabel = itemContentLabel;
            break;
        case 2:
            _tueLabel = itemContentLabel;
            break;
        case 3:
            _wenLabel = itemContentLabel;
            break;
        case 4:
            _thuLabel = itemContentLabel;
            break;
        case 5:
            _friLabel = itemContentLabel;
            break;
        case 6:
            _satLabel = itemContentLabel;
            break;
        case 7:
            _sunLabel = itemContentLabel;
            break;
        default:
            break;
    }
    
    return itemBgView;
}

@end
