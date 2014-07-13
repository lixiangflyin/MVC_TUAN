//
//  TopTenCell.h
//  SBBS_xiang
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"

@interface TopTenCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

//数据显示在cell
- (void)updateView:(Topic *)topic;

@end
