//
//  Comment.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
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
