//
//  ECOpeningTimeModel.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECOpeningModel.h"
#import "ECOpeningTimeList.h"

@implementation ECOpeningModel

- (BOOL)hasOpenTime {
    if (self.openDayList.mon || self.openDayList.tue || self.openDayList.wen
        || self.openDayList.thu
        || self.openDayList.fri
        || self.openDayList.sat
        || self.openDayList.sun ) {
        return YES;
    }
    return NO;
}
@end
