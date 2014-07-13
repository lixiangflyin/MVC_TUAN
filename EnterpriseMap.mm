//
//  EnterpriseMap.m
//  wtz
//
//  Created by michael on 12/9/13.
//  Copyright (c) 2013 michael. All rights reserved.
//

#import "EnterpriseMap.h"
#import "CustomPointAnnotation.h"
#import "CalloutMapAnnotation.h"


@interface EnterpriseMap ()
{
     BMKMapView* mapView;
     CalloutMapAnnotation *_calloutMapAnnotation;
}
@end

@implementation EnterpriseMap

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"企业地图";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64)];
    mapView.delegate = self;
    
    [mapView setUserTrackingMode:BMKUserTrackingModeNone];
    //如果是在当前城市，则开启当前位置定位
    [mapView setShowsUserLocation:YES];
    [mapView setZoomEnabled:YES];
    [mapView setZoomLevel:18];
    [self.view addSubview:mapView];
    [self showAnnotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
}
-(void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate = self;
}

#define kGuiYanCoordinate CLLocationCoordinate2DMake(26.62990760803223,106.7091751098633)
//显示覆盖物
-(void)showAnnotation
{
    self.latitude = 26.62990760803223;
    self.longitude = 106.7091751098633;
    
    CLLocationCoordinate2D centerPosition = (CLLocationCoordinate2D){self.latitude, self.longitude};
    [mapView setCenterCoordinate:centerPosition animated:YES];
    //[mapView setCenterCoordinate:kGuiYanCoordinate animated:YES];
    
    CustomPointAnnotation * annotation = [[CustomPointAnnotation alloc]init];
    
    CLLocationCoordinate2D coor;
    coor.latitude = self.latitude;
    coor.longitude = self.longitude;
    annotation.coordinate = coor;
    
    annotation.pointCalloutInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.enterprise, @"name", self.address, @"address", @"1", @"id",nil];
    [mapView addAnnotation:annotation];
    
    BMKCoordinateRegion region = BMKCoordinateRegionMake(centerPosition, BMKCoordinateSpanMake(0.01, 0.01));//越小地图显示越详细
    BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
    [mapView setRegion:adjustedRegion animated:YES];//执行设定显示范围
    
}


-(BMKAnnotationView *)mapView:(BMKMapView *)mView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = [UIImage imageNamed:@"pin_red"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.canShowCallout = NO;
        return newAnnotationView;
    }else if([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        //此时annotation就是我们calloutview的annotation
        CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
        
        //如果可以重用
        CallOutAnnotationView *calloutannotationview = (CallOutAnnotationView *)[mView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        
        //否则创建新的calloutView
        if (!calloutannotationview) {
            calloutannotationview = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"calloutview"];
            calloutannotationview.delegate = self;
            calloutannotationview.contentView = nil;
            
        }
        [calloutannotationview setData:ann.locationInfo];
        calloutannotationview.contentView = nil;
        
        //开始设置添加marker时的赋值
        
        return calloutannotationview;
    }
    return nil;
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mView didSelectAnnotationView:(BMKAnnotationView *)view
{
    CustomPointAnnotation *anno = (CustomPointAnnotation *)view.annotation;
    if ([view.annotation isKindOfClass:[CustomPointAnnotation class]]) {
        //如果点到了这个marker点，什么也不做
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (_calloutMapAnnotation) {
            [mView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation=nil;
            
        }
        //创建搭载自定义calloutview的annotation
        _calloutMapAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        
        //把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
        _calloutMapAnnotation.locationInfo = anno.pointCalloutInfo;
        
        [mView addAnnotation:_calloutMapAnnotation];
        
        [mView setCenterCoordinate:view.annotation.coordinate animated:YES];
    }
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    if (_calloutMapAnnotation&&![view isKindOfClass:[CallOutAnnotationView class]]) {
        
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;
        }
        
        
    }
}

-(void)callOutClickAction:(NSNumber *)tag
{
    
//    EnterpriseViewController *detail = [[EnterpriseViewController alloc] init];
//    detail.enterpriseID = [tag integerValue];
//    [self.navigationController pushViewController:detail animated:YES];
    
}


@end
