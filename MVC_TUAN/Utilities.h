//
//  Utilities.h
//  TongTongTuan
//
//  Created by 李红 on 13-8-14.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "UserInfo.h"

@interface Utilities : NSObject

// 保存和获取用户定位得到得坐标信息
+ (void) saveUserCoordinate:(CLLocationCoordinate2D)coordinate;
+ (CLLocationCoordinate2D)getUserCoordinate;

// 保存和获取当前显示城市信息
+ (void)saveCurrentShowCity:(NSDictionary *)dic;
+ (NSDictionary *)getCurrentShowCity;

// 保存和获取定位得到得城市信息
+ (void)saveLocationCity:(NSDictionary *)dic;
+ (NSDictionary *)getLocationCity;

// 设置和获取是否是第一次启动App
+ (BOOL)isFirstLuanchApp;
+ (void)setFirstLanuchApp;

@end
