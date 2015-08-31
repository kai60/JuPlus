//
//  JuPlusGetLocation.m
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusGetLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface JuPlusGetLocation()<CLLocationManagerDelegate>

@end

@implementation JuPlusGetLocation
DEF_SINGLETON(JuPlusGetLocation);

-(void)getLocation
{
    CLLocationManager * locManager = [[CLLocationManager alloc] init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locManager startUpdatingLocation];
    locManager.distanceFilter = 100.0f;
    self.locLong = locManager.location.coordinate.longitude?:0;
    self.locLat = locManager.location.coordinate.latitude?:0;
    
}
@end
