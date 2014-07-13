//
//  CommentCell.h
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-8-16.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarView.h"
//#import "Comment.h"

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet ScoreStarView *scoreStarImageView;

//- (void)updateUI:(Comment *)comment;

-(void)updateUI;

@end
