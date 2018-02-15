//
//  ECGeocoderTool.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/14.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECGeocoderTool.h"

@implementation ECGeocoderTool

+ (void)getPlacemark:(NSString *)address block:(void (^)(CLLocationCoordinate2D coordinate))block {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            block(CLLocationCoordinate2DMake(0, 0));
        } else {
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            block(firstPlacemark.location.coordinate);
        }
    }];
}

@end
