//
//  TopTenView.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TopTenView.h"
//#import "EnterpriseMap.h"
#import "MapViewController.h"

@interface UIView ()

@end

@implementation TopTenView

- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
    [self.headerView free];
    self.tentopicTableView = nil;
    self.tentopicsArr = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tentopicsArr = [NSMutableArray array];
        self.pictureArr = @[@"hot1.png",@"hot2.png",@"hot3.png",@"hot4.png",@"hot5.png",@"hot6.png",@"hot7.png",@"hot8.png",@"hot9.png",@"hot1.png",@"hot1.png",@"hot1.png"];
        
        self.tentopicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tentopicTableView.dataSource = self;  //数据源代理
        self.tentopicTableView.delegate = self;    //表视图委托
        self.tentopicTableView.separatorStyle = NO;
        [self addSubview:self.tentopicTableView];
        
        //下拉刷新
        MJRefreshHeaderView *header = [MJRefreshHeaderView header];
        header.scrollView = self.tentopicTableView;
        header.delegate = self;
        // 自动刷新
        [header beginRefreshing];
        self.headerView = header;
        
    }
    return self;
}

//刷新
- (void)refreshListhWithDataSource:(NSArray *)modelObjectArray
{
    [self.tentopicsArr removeAllObjects];
    [self.tentopicsArr addObjectsFromArray:modelObjectArray];
    [self.tentopicTableView reloadData];
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    if(self.delegate)
    {
        [self.delegate productListView:self refreshOnSuccess:^(NSMutableArray *listOfModelBaseObjects)
         {
             [self refreshListhWithDataSource:listOfModelBaseObjects];
             
             // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
             [self.headerView endRefreshing];
             
             [ProgressHUD showSuccess:@"刷新成功"];
             
         } onError:^(NSError *engineError) {
             
             [self.headerView endRefreshing];
             [ProgressHUD showError:@"网络故障"];
             
         }];
    }
    
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    //NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            //NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            //NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            //NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}


#pragma mark - 数据源协议
#pragma mark tableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tentopicsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identi = @"TopTenTableViewCell";
    //第一次需要分配内存
    TopTenCell * cell = (TopTenCell *)[tableView dequeueReusableCellWithIdentifier:identi];
    if (cell == nil) {
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"TopTenCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        [cell setBackgroundColor:UIColorFromRGB(0xF1F1F1)];
    }
    
    NSString *str = self.pictureArr[indexPath.row];
    [cell.titleImageView setImage:[UIImage imageNamed:str]];
    
    Topic * topic = [self.tentopicsArr objectAtIndex:indexPath.row];
    [cell updateView: topic];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int returnHeight;
    
    Topic * topic = [self.tentopicsArr objectAtIndex:indexPath.row];
    
    if ([topic.title isEqualToString:nil]) {
        NSLog(@"you meet a bug!");
    }
    
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CGSize size1 = [topic.title boundingRectWithSize:CGSizeMake(self.frame.size.width - 46, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    
    returnHeight = size1.height  + 35;
    
    return returnHeight;
}

#pragma -mark tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"god");
    
    MapViewController *vc = [[MapViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
