//
//  SortProduceView.h
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortProductView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *sortProduceTableView;

@property (nonatomic, strong) NSArray *sortCommandArr;

@end
