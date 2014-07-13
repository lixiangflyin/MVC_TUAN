//
//  UIScrollView+ContentSize.m
//  TongTongTuan
//
//  Created by 李红 on 13-9-4.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "UIScrollView+ContentSize.h"

@implementation UIScrollView (ContentSize)

+ (void)setScrollViewContentSize:(UIScrollView *)scrollView
{
    CGRect contentSize = CGRectZero;
    for (UIView *subview in scrollView.subviews) {
        contentSize = CGRectUnion(contentSize, subview.frame);
    }
    scrollView.contentSize = contentSize.size;
}
@end
