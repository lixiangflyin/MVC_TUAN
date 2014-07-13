//
//  SortProduceView.m
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SortProductView.h"
#import "const.h"
#import "MenuCell.h"

@implementation SortProductView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        //隐藏按钮
        UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, 320, self.frame.size.height - 270)];
        [cover setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        
        [self showTables];
    }
    return self;
}

//隐藏按钮
-(IBAction)coverClick:(id)sender
{
    [self removeFromSuperview];
}

-(void)showTables
{
    self.sortCommandArr = @[@"默认排序", @"价格最高", @"价格最低", @"人气最高", @"离我最近", @"最新发布"];
    
    _sortProduceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 265)];
    _sortProduceTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _sortProduceTableView.delegate =self;
    _sortProduceTableView.dataSource = self;
    
    [_sortProduceTableView reloadData];
    
    
}

#pragma mark - 数据源协议
#pragma mark tableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortCommandArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identi = @"MenuCell";
    //第一次需要分配内存
    MenuCell * cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:identi];
    if (cell == nil) {
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        [cell setBackgroundColor:UIColorFromRGB(0xF1F1F1)];
    }
    
    cell.nameLabel.text = _sortCommandArr[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

#pragma -mark tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"god");
    
}

@end
