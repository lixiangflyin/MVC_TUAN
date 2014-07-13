//
//  TopTenCell.m
//  SBBS_xiang
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TopTenCell.h"

@implementation TopTenCell

- (void)updateView:(Topic *)topic
{
    self.titleLabel.text = topic.title;
    self.sectionLabel.text = topic.board;
}

@end
