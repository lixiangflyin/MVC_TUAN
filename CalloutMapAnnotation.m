//
//  CalloutMapAnnotation.m
//  radio986
//
//  Created by michael_yao on 13-7-15.
//  Copyright (c) 2013年 xunao. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation
@synthesize latitude;
@synthesize longitude;
@synthesize locationInfo;

-(id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)log
{
    if(self = [super init]){
        self.latitude = lat;
        self.longitude = log;
    }
    return self;
}

-(CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;

    
}
@end
