//
//  LocationManager.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LocationManager.h"
#import "SIAlertView.h"
#import "JsonParseEngine.h"
#import "CityListController.h"
#import "LHTabBarController.h"
#import "AppDelegate.h"
#import "Utilities.h"

@interface LocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) BOOL isCompletedLocaation;

@end

@implementation LocationManager

- (id)init
{
    if(self = [super init])
    {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    
    return self;
}

- (void)startLocation
{
    self.isCompletedLocaation = NO;
    [self.manager startUpdatingLocation];
}


- (void)stopLocation
{
    [self.manager stopUpdatingLocation];
}

//回调
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval interval = [[newLocation timestamp] timeIntervalSinceNow];
    if(interval >= -30 && interval < 0)
    {
        [self stopLocation];
        if(self.isCompletedLocaation)
        {
            return;
        }
        self.isCompletedLocaation = YES;
        [Utilities saveUserCoordinate:newLocation.coordinate];
#warning 把查找城市名称的部分独立出来
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if(error || placemarks.count == 0)
            {
                [SIAlertView showWithMessage:@"获取城市信息失败，请手动选择城市。" text1:@"关闭" okBlock:^{
                    if(self.delegate)
                    {
                        [self.delegate locationManagerFial];
                    }
                }];
            }else
            {
                CLPlacemark *placemark = placemarks[0];
                NSString *cityName = placemark.locality;
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF==%@", cityName];
                
                [JsonParseEngine getCityListOnSuccess:^(NSMutableDictionary *dictionary) {
                    //获取城市名称的集合
                    NSArray *keys = [dictionary allKeys];
                    NSMutableArray *citys = [NSMutableArray new];
                    for(NSString *key in keys)
                    {
                        NSArray *cityItems = dictionary[key];
                        for(NSDictionary *dic in cityItems)
                        {
                            [citys addObject:dic[@"areaname"]];
                        }
                    }
                    
                    //用获得的城市名称去查找城市对象(包括城市名称和城市代码)
                    NSArray *result = [citys filteredArrayUsingPredicate:predicate];
                    if(result.count > 0){
                        NSString *currentCityName = result[0];
                        NSDictionary *cityObj = nil;

                        BOOL found = NO;
                        for(NSString *key in keys){
                            if(found){
                                break;
                            }
                            
                            NSArray *cityItems = dictionary[key];
                            for(NSDictionary *dic in cityItems){
                                NSString *name = dic[@"areaname"];
                                if([name isEqualToString:currentCityName]){
                                    found = YES;
                                    cityObj = dic;
                                    [Utilities saveLocationCity:dic];
                                    break;
                                }
                            }
                        }
                        
                        NSString *messsage = [NSString stringWithFormat:@"GPS定位到您当前在%@，需要切换城市吗？", currentCityName];
                        [SIAlertView showWithTitle:@"提示" andMessage:messsage text1:@"不要" text2:@"切换" okBlock:^{
                            if(self.delegate){
                                [self.delegate locationManagerSuccess:newLocation.coordinate cityDictionary:cityObj name:placemark.name];
                            }
                            
                        } cancelBlock:^{
//                            CityListController *CLC = [[CityListController alloc] initWithNibName:@"CityListController" bundle:nil];
//                            AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                            CLC.delegate = appDel.tuanGouController;
//                            [appDel.tuanGouController presentModalViewController:CLC animated:YES];
                        }];
                
                    }else
                    {
                        [SIAlertView showWithMessage:@"未能找到您所在城市，请手动选择城市。" text1:@"关闭" okBlock:^{
                            if(self.delegate){
                                [self.delegate locationManagerFial];
                            }
                        }];
                    }
                    
                } onError:^(NSError *engineError) {
                    if(self.delegate){
                        [self.delegate locationManagerFial];
                    }
                }];
            }
        }];
    }
}

//回调失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSString *errorMsg = nil;
    if([error code] == kCLErrorDenied)
    {
        errorMsg = @"请在[设置->隐私->定位服务]中开启定位功能";
    }else
    {
        errorMsg = @"定位失败，请手动选择城市。";
    }
    
    [SIAlertView showWithMessage:errorMsg text1:@"关闭" okBlock:^{
        if(self.delegate)
        {
            [self.delegate locationManagerFial];
        }
    }];
}
@end
