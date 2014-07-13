//
//  LHActionView.m
//  TongTongTuan
//
//  Created by 李红 on 13-9-2.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "LHActionView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat animationTime = 0.3;
static const CGFloat tableViewHeight = 170.0;

@interface LHActionView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) LHActionViewBlock blcok;
@end

@implementation LHActionView


- (id)initWithFrame:(CGRect)frame andDataSource:(NSArray *)dataSource callbackBlock:(LHActionViewBlock)block
{
    CGRect f = frame;
    f.size.height = 5200;
    self = [super initWithFrame:f];
    if (self) {
        //回调的block
        self.blcok = block;
        self.dataSource = dataSource;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        
        CGRect rect = CGRectMake(0, -tableViewHeight, self.bounds.size.width, tableViewHeight);
        self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        
        [UIView animateWithDuration:animationTime animations:^{
            CGRect f = self.tableView.frame;
#pragma -mark
            //这里边要分ios6和ios7
            f.origin.y = 64;
            self.tableView.frame = f;
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:animationTime animations:^{
        CGRect f = self.frame;
        f.origin.y = -tableViewHeight;
        self.frame = f;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    } completion:^(BOOL finished) {
        self.blcok(indexPath.row);
        self.tableView = nil;
        self.blcok = nil;
        self.dataSource = nil;
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:animationTime animations:^{
        CGRect f = self.frame;
        f.origin.y = -tableViewHeight;
        self.frame = f;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    } completion:^(BOOL finished) {
        self.tableView = nil;
        self.blcok = nil;
        self.dataSource = nil;
        [self removeFromSuperview];
    }];
}

+ (LHActionView *)showInView:(UIView *)superView
                  dataSource:(NSArray *)dataSource
               callbackBlock:(LHActionViewBlock)block
{
    LHActionView *v = [[LHActionView alloc] initWithFrame:superView.bounds
                                            andDataSource:dataSource
                                            callbackBlock:block];
    [superView addSubview:v];
    return v;
}

@end
