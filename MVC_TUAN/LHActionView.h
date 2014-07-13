//
//  LHActionView.h
//  TongTongTuan
//
//  Created by 李红 on 13-9-2.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LHActionViewBlock)(NSInteger rowIndex);

@interface LHActionView : UIView

+ (LHActionView *)showInView:(UIView *)superView
                  dataSource:(NSArray *)dataSource
               callbackBlock:(LHActionViewBlock)block;

@end
