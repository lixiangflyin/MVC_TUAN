//
//  ProductSpecificationCell.m
//  TongTongTuan
//
//  Created by 李红 on 13-8-29.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "ProductSpecificationCell.h"

@implementation ProductSpecificationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)add:(UIButton *)sender
{
    if(self.addBlock){
        self.addBlock(self);
    }
}

- (IBAction)sub:(UIButton *)sender
{
    if(self.subBlock){
        self.subBlock(self);
    }
}

@end
