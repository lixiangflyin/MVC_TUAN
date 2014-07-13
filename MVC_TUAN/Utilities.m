//
//  Utilities.m
//  TongTongTuan
//
//  Created by 李红 on 13-8-14.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "Utilities.h"

#define UD [NSUserDefaults standardUserDefaults]

static NSString *kLat  = @"CurrentCoordinateLatitude",
                *kLon  = @"kCurrentCoordinateLongitude",
                *kCC   = @"CurrentCity",
                *kLC   = @"LocationCity",
                *kIF   = @"IsFirstLancuhApp",
                *kUI   = @"UserInfo";

@implementation Utilities

+ (void) saveUserCoordinate:(CLLocationCoordinate2D)coordinate
{
    [UD setFloat:coordinate.latitude forKey:kLat];
    [UD setFloat:coordinate.longitude forKey:kLon];
}

+ (CLLocationCoordinate2D)getUserCoordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [UD floatForKey:kLat];
    coordinate.longitude = [UD floatForKey:kLon];
    return coordinate;
}

//-------------------------------------------------------------------------------------
+ (void)saveCurrentShowCity:(NSDictionary *)dic
{
    [UD setObject:dic forKey:kCC];
}

+ (NSDictionary *)getCurrentShowCity
{
    return [UD objectForKey:kCC];
}

//-------------------------------------------------------------------------------------
+ (void)saveLocationCity:(NSDictionary *)dic
{
    [UD setObject:dic forKey:kLC];
}

+ (NSDictionary *)getLocationCity
{
   return  [UD objectForKey:kLC];
}

//-------------------------------------------------------------------------------------
+ (BOOL)isFirstLuanchApp
{
    return [UD boolForKey:kIF];
}

+ (void)setFirstLanuchApp
{
    [UD setBool:YES forKey:kIF];
}


@end
