//
//  ViewController.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProduceViewController.h"
#import "JsonParseEngine.h"
#import "TopTenView.h"

//测试用
#import "SearchProductController.h"
#import "RecommendController.h"
#import "ProductDetailController.h"
//#import "OrderController.h"


@interface ProduceViewController ()<ToptenViewDelegate>

@property (nonatomic, strong) TopTenView *toptenView;

@end

@implementation ProduceViewController

- (void)dealloc
{
    
}

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
    
    self.title = @"今日十大";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地图"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                 action:@selector(showProductListOnMap:)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"搜索"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(showSearchProductView:)];
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:searchButton,mapButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    //self.navigationItem.leftBarButtonItem = searchButton;
    self.toptenView = [[TopTenView alloc] initWithFrame: CGRectMake(0, 0 , self.view.frame.size.width,self.view.frame.size.height-TAB_BAR_HEIGHT)];
    self.toptenView.delegate = self;
    self.toptenView.navigationController = self.navigationController;
    [self.view addSubview:self.toptenView];
    
}

-(void) showProductListOnMap:(id) sender
{
    NSLog(@"map");
    RecommendController *searchVC = [[RecommendController alloc]initWithNibName:@"RecommendController" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void) showSearchProductView:(id) sender
{
    ProductDetailController *detailVC = [[ProductDetailController alloc]initWithNibName:@"ProductDetailController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    return;
    
//    OrderController *order = [[OrderController alloc]initWithNibName:@"OrderController" bundle:nil ProductT:1];
//    [self.navigationController pushViewController:order animated:YES];
//    return;
    
    SearchProductController *searchVC = [[SearchProductController alloc]initWithNibName:@"SearchProductController" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma -mark TopTenViewDelegate委托 下拉刷新
- (void)productListView:(TopTenView *)list refreshOnSuccess:(ArrayBlock)arrayBlock onError:(ErrorBlock)errorBlock
{
    //向服务器请求十大数据
    [JsonParseEngine getTopTenOnSuccess:^(NSMutableArray *listOfModelBaseObjects) {
        
        arrayBlock(listOfModelBaseObjects);
        
    } onError:^(NSError *engineError) {
        
        errorBlock(engineError);
    }];
}

- (void)productListView:(TopTenView *)list loadMoreOnSuccess:(ArrayBlock)arrayBlock onError:(ErrorBlock)errorBlock
{
    //未实现
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
