//
//  TopChooseView.m
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TopChooseView.h"

@implementation TopChooseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
        [line setBackgroundColor:[UIColor colorWithWhite:218.0/255 alpha:1]];
        [self addSubview:line];
        
        //位置按钮
        UIButton * postionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106, 40)];
        NSString *positionString = @"全城";
        [postionButton setTitle:positionString forState:UIControlStateNormal];
        [postionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
        [postionButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [postionButton setTag:1];
        [postionButton setTitleColor:[UIColor colorWithWhite:70.0/255 alpha:1] forState:UIControlStateNormal];
        [postionButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [postionButton addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:postionButton];
        
        UIView *vertical1 = [[UIView alloc] initWithFrame:CGRectMake(106, 5, 1, 30)];
        [vertical1 setBackgroundColor:[UIColor colorWithWhite:218.0/255 alpha:1]];
        [self addSubview:vertical1];
        
        //分类按钮
        UIButton * categoryButton = [[UIButton alloc] initWithFrame:CGRectMake(107, 0, 106, 40)];
        [categoryButton setTitle:@"全部" forState:UIControlStateNormal];
        [categoryButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
        [categoryButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [categoryButton setTag:2];
        [categoryButton addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        [categoryButton setTitleColor:[UIColor colorWithWhite:70.0/255 alpha:1] forState:UIControlStateNormal];
        [categoryButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [self addSubview:categoryButton];
        
        UIView *vertical2 = [[UIView alloc] initWithFrame:CGRectMake(213, 5, 1, 30)];
        [vertical2 setBackgroundColor:[UIColor colorWithWhite:218.0/255 alpha:1]];
        [self addSubview:vertical2];
        
        //排序按钮
        UIButton * orderButton = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 106, 40)];
        NSString *orderString = @"默认排序";
        [orderButton setTitle:orderString forState:UIControlStateNormal];
        [orderButton setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
        [orderButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [orderButton setTag:3];
        [orderButton addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        [orderButton setTitleColor:[UIColor colorWithWhite:70.0/255 alpha:1] forState:UIControlStateNormal];
        [orderButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [self addSubview:orderButton];
        
        //数组装载三个视图
        _topBtnArr = [[NSArray alloc] initWithObjects:postionButton, categoryButton, orderButton,nil];
    }
    return self;
}

#pragma mark-点击头部弹出浮层
-(IBAction)topClick:(UIButton *)sender
{
    
    //可以用block
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
