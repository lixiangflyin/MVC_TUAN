//
//  LocationManager.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate;

@interface LocationManager : NSObject

@property (nonatomic, weak) id<LocationManagerDelegate> delegate;

- (void)startLocation;
- (void)stopLocation;

@end

@protocol LocationManagerDelegate <NSObject>

@required
- (void)locationManagerSuccess:(CLLocationCoordinate2D)coordinate cityDictionary:(NSDictionary *)cityDic name:(NSString *)name;
- (void)locationManagerFial;

@end
