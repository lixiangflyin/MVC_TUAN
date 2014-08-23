//
//  Comment.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

//- (void)updateUI:(Comment *)comment
//{
//    self.nicknameLabel.text = comment.username;
//    self.publishDateLabel.text = comment.createdatestr;
//    self.commentContentLabel.text = comment.comment;
//    
//    [self.scoreStarImageView drawStarWithScore:comment.score_service];
//}

//完全为了静态测试
-(void)updateUI
{
    self.nicknameLabel.text = @"lixiangflyin";
    self.publishDateLabel.text = @"2014-4-21";
    self.commentContentLabel.text = @"这个餐馆不错，得常来！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！";
    
    [self.scoreStarImageView drawStarWithScore:4.5];
}
@end
