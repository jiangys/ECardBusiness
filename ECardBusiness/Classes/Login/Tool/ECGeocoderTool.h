//
//  ECGeocoderTool.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ECGeocoderTool : NSObject

+ (void)getPlacemark:(NSString *)address block:(void (^)(CLLocationCoordinate2D coordinate))block;

@end
