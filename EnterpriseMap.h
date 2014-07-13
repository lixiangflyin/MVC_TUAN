//
//  EnterpriseMap.h
//  wtz
//
//  Created by michael on 12/9/13.
//  Copyright (c) 2013 michael. All rights reserved.
//

#import "BaseController.h"
#import "BMapKit.h"
#import "CallOutAnnotationView.h"

@interface EnterpriseMap : BaseController<BMKMapViewDelegate, CallOutClick>

@property(nonatomic, weak)NSString *address;
@property(nonatomic, weak)NSString *enterprise;
@property float latitude;
@property float longitude;

@end
