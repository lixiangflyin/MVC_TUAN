//
//  CommentListView.m
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-8-16.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "CommentListView.h"
#import "CommentCell.h"

@interface CommentListView()<UITableViewDataSource>
@end

@implementation CommentListView

#pragma mark - Initialize
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style]){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
}

- (void)setCommentListArray:(NSArray *)commentListArray
{
    //数据传到此，然后刷新tableview
    _commentListArray = commentListArray;
    [self reloadData];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentListArray.count ? self.commentListArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [self dequeueReusableCellWithIdentifier:@"CommentCell"];
    
//    Comment *comment = nil;
//    if(self.commentListArray.count){
//        comment = self.commentListArray[indexPath.row];
//    }else{
//        comment = [[Comment alloc] init];
//        comment.comment = @"亲，暂时还木有收到评论耶😭...";
//    }
    //[cell updateUI:comment];
    
    [cell updateUI];
    
    return cell;
}

@end
