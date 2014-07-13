//
//  RecommendController.h
//  MVC_TUAN
//
//  Created by apple on 14-7-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface RecommendController : UIViewController<MJRefreshBaseViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;


@end
