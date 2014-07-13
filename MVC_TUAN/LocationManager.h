//
//  LocationManager.h
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-7-23.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
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
