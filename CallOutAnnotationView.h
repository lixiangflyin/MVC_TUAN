//
//  CallOutAnnotationView.h
//  radio986
//
//  Created by michael_yao on 13-7-15.
//  Copyright (c) 2013年 xunao. All rights reserved.
//

#import "BMKAnnotationView.h"

@protocol CallOutClick <NSObject>

-(void)callOutClickAction:(NSNumber *)tag;

@end

@interface CallOutAnnotationView : BMKAnnotationView

@property(strong, nonatomic)UIView *contentView;
@property (nonatomic, strong)id<CallOutClick> delegate;

-(void)setData:(NSDictionary *)data;

@end
