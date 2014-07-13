//
//  NextViewController.m
//  MVC_TUAN
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BusinessViewController.h"
#import "const.h"
#import "JsonParseEngine.h"
#import "CityListController.h"
#import "LocationManager.h"
#import "SIAlertView.h"
#import "Utilities.h"

#define kNanJingCoordinate CLLocationCoordinate2DMake(26.62990760803223,106.7091751098633)

@interface BusinessViewController ()<CityListControllerDelegate,LocationManagerDelegate>

@property (nonatomic, strong) CityListController *cityListController;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation BusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"周边";

    _cityButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [_cityButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    //第一次默认城市  接下来从userdefault中取数据
    [_cityButton setTitle:@"南京" forState:UIControlStateNormal];
    [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:_cityButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 初始化城市列表控制器
    self.cityListController = [[CityListController alloc] initWithNibName:@"CityListController" bundle:nil];
    self.cityListController.delegate = self;

    //初始化定位管理器
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 如果之前成功的定位(获取到了城市信息)，那么就开始加载产品列表。否则开始进行定位
    // 注意:这也就是说如果用户首次定位成功后，以后用户进入程序都不会再进行自定定位，除非用户显示的进行定位操作(譬如:获取周边的商品，
    // 这时需要重新存储城市名称信息和坐标信息)
    [self.locationManager startLocation];
}

// 呈现城市列表界面
- (void)selectCity:(UIButton *)sender
{
    [self presentViewController:self.cityListController animated:YES completion:nil];
}


#pragma mark - CityListController Delegate
- (void)cityListController:(CityListController *)controller cityDicationary:(NSDictionary *)cityDicationary
{
    [Utilities saveCurrentShowCity:cityDicationary];
    [self.cityButton setTitle:cityDicationary[@"areaname"] forState:UIControlStateNormal];
    //重新更新该城市数据
    //[self refreshProductList];
}


#pragma mark - LocationManagerDelegate
- (void)locationManagerSuccess:(CLLocationCoordinate2D)coordinate cityDictionary:(NSDictionary *)cityDic name:(NSString *)name
{
    // 保存当前的定位坐标和定位到的城市信息
    [Utilities saveCurrentShowCity:cityDic];
    
    //currentCoordinate = coordinate; //向服务器请求变量
    [self.cityButton setTitle:cityDic[@"areaname"] forState:UIControlStateNormal];
    [self.cityListController setLocationCtiy:cityDic];
    //定位后会询问是否更新
    //[self refreshProductList];
}


// 如果定位失败，那么默认显示的城市名称是贵阳,商品为贵阳周边的商品
- (void)locationManagerFial
{
    NSDictionary *cityDic = @{@"areaname":@"贵阳市",@"areacode":@"520100"};
    [Utilities saveLocationCity:cityDic];
    [Utilities saveCurrentShowCity:cityDic];
    [Utilities saveUserCoordinate:kNanJingCoordinate];
    
    [self.cityButton setTitle:cityDic[@"areaname"] forState:UIControlStateNormal];
    [self.cityListController setLocationCtiy:cityDic];
    //[self refreshProductList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
