//
//  CalloutMapAnnotation.h
//  radio986
//
//  Created by michael_yao on 13-7-15.
//  Copyright (c) 2013年 xunao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface CalloutMapAnnotation : NSObject<BMKAnnotation>

@property (nonatomic)CLLocationDegrees latitude;
@property(nonatomic) CLLocationDegrees longitude;
@property (nonatomic, strong)NSDictionary *locationInfo;
-(id)initWithLatitude:(CLLocationDegrees )latitude andLongitude:(CLLocationDegrees)longitude;

@end
