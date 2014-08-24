//
//  ScoreStarView.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ScoreStarView.h"

@implementation ScoreStarView

- (void)drawStarWithScore:(NSUInteger)score 
{
    if(score <= 0){
        return;
    }
    
    UIImage *starImage = [UIImage imageNamed:@"scoreStar@2x.png"];
    NSAssert(starImage, @"创建评分星星图片失败,请指定正确的文件路径");
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat margin = 4.0;
    CGSize  size = self.bounds.size;
    
    UIGraphicsBeginImageContext(size);
    {
        for(int i = 0; i < score; i++){
            [starImage drawInRect:CGRectMake(i * (starImage.size.width/2 + margin),
                                             0,
                                             starImage.size.width/2,
                                             starImage.size.height/2)];
        }
        self.image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
}

@end
