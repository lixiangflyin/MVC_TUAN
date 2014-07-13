//
//  TopTenView.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonParseEngine.h"  //这里用到的是block定义
#import "MJRefresh.h"
#import "ProgressHUD.h"
#import "TopTenCell.h"
#import "const.h"

//协议
@protocol ToptenViewDelegate;

@interface TopTenView : UIView<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, retain) UITableView *tentopicTableView;
@property (nonatomic, strong) MJRefreshHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *tentopicsArr;
@property (nonatomic, strong) NSArray *pictureArr;      //这里存储图片的数组

@property (nonatomic, weak) id<ToptenViewDelegate> delegate;
@property (nonatomic, weak) UINavigationController *navigationController;

//这句貌似没有用途
- (void)refreshListhWithDataSource:(NSArray *)modelObjectArray;

@end

@protocol ToptenViewDelegate <NSObject>

@required
- (void)productListView:(TopTenView *)list refreshOnSuccess:(ArrayBlock)arrayBlock onError:(ErrorBlock)errorBlock;
- (void)productListView:(TopTenView *)list loadMoreOnSuccess:(ArrayBlock)arrayBlock onError:(ErrorBlock)errorBlock;

@end


