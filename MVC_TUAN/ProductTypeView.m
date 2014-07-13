//
//  ProduceTypeView.m
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProductTypeView.h"
#import "ProductTypeCell.h"
#import "ProductSubTypeCell.h"

#define CELL_HEIGHHT 35

@interface ProductTypeView()
{
    NSMutableArray *fatherIndustry;
    NSMutableArray *childIndustry;
    UITableView *childTable;
    int selectFather, selectChild;
}
@end

@implementation ProductTypeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        //隐藏按钮
        UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, 320, self.frame.size.height - 270)];
        [cover setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        
    }
    return self;
}

//VC中从服务器抓取的数据放在view上 VC中设置的一个函数
-(void)setIndustryData:(NSArray *)data
{
    //所有职位信息赋给IndustryData
    _typeData = data;
    [self showTables];
}

-(void)showTables
{
    UITableView *fatherTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, 265)];
    [fatherTable setBackgroundColor:[UIColor colorWithWhite:244.0/255 alpha:1]];
    fatherTable.delegate = self;
    fatherTable.dataSource = self;
    [fatherTable setTag:1];
    fatherTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:fatherTable];
    
    fatherIndustry = [[NSMutableArray alloc] init];
    NSDictionary *all = [[NSDictionary alloc] initWithObjectsAndKeys:@"全部行业",@"name", @"0", @"id", nil];
    [fatherIndustry addObject:all];
    
    for (int i=0; i<_typeData.count; i++) {
        NSString *thisID = [NSString stringWithFormat:@"%@", [[_typeData objectAtIndex:i] objectForKey:@"id"]];
        NSString *thisName = [[_typeData objectAtIndex:i] objectForKey:@"name"];
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:thisID, @"id", thisName, @"name", nil];
        [fatherIndustry addObject:temp];
        if (self.selectType > 0) {
            NSArray *tempChild = [[NSArray alloc] initWithArray:[[_typeData objectAtIndex:i] objectForKey:@"child"]];
            for (int j=0; j<tempChild.count; j++) {
                int thisChildID = [[[tempChild objectAtIndex:j] objectForKey:@"id"] intValue];
                if (thisChildID == self.selectType) {
                    selectFather = i+1;
                    selectChild = j;
                }
            }
        }
    }
    childIndustry = [[NSMutableArray alloc] initWithArray:[[_typeData objectAtIndex:0] objectForKey:@"child"]];
    
    childTable = [[UITableView alloc] initWithFrame:CGRectMake(160, 0, 160, 265)];
    [childTable setBackgroundColor:[UIColor whiteColor]];
    childTable.delegate = self;
    childTable.dataSource = self;
    [childTable setTag:2];
    childTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:childTable];
    
    //设置选择触发情况
    if (self.selectType > 0 ) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectFather inSection:0];
        [fatherTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:selectChild inSection:0];
        [childTable selectRowAtIndexPath:indexPath2 animated:NO scrollPosition:UITableViewScrollPositionTop];
    }else{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [fatherTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        [childTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 5);
    CGContextAddLineToPoint(context, 160, 5);
    CGContextAddLineToPoint(context, 164, 0);
    CGContextAddLineToPoint(context, 168, 5);
    CGContextAddLineToPoint(context, 320, 5);
    CGContextAddLineToPoint(context, 320, 270);
    CGContextAddLineToPoint(context, 0, 270);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFill);
}

//隐藏按钮
-(IBAction)coverClick:(id)sender
{
    [self removeFromSuperview];
}


#pragma -mark 数据源委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return [fatherIndustry count];
    }else{
        return [childIndustry count];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        static NSString *CellIdentifier = @"ProductTypeCell";
        ProductTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ProductTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.nameLabel setText:[[fatherIndustry objectAtIndex:indexPath.row] objectForKey:@"name"]];
        return cell;
    }else{
        static NSString *CellIdentifier1 = @"ProductSubTypeCell";
        ProductSubTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[ProductSubTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        [cell.nameLabel setText:[[childIndustry objectAtIndex:indexPath.row] objectForKey:@"name"]];
        return cell;
    }
    
}

/*cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //自定义高度
    return CELL_HEIGHHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //父表视图
    if (tableView.tag == 1) {
        if (indexPath.row > 0) {
            
            //大于0展开子表视图的cell
            [childIndustry removeAllObjects];
            [childIndustry addObjectsFromArray:[[_typeData objectAtIndex:(indexPath.row - 1)] objectForKey:@"child"]];
            [childTable reloadData];
        }else{
            
            //委托设计
            [self.delegate setCategory:0 withName:@"全部"];
            [self removeFromSuperview];
        }
        
    }else{
        
        int category = [[[childIndustry objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
        NSString *categoryName = [[childIndustry objectAtIndex:indexPath.row] objectForKey:@"name"];
        //委托设计
        [self.delegate setCategory:category withName:categoryName];
        [self removeFromSuperview];
    }
    
}

@end
