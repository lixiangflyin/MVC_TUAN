//
//  LHActionView.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LHActionViewBlock)(NSInteger rowIndex);

@interface LHActionView : UIView

+ (LHActionView *)showInView:(UIView *)superView
                  dataSource:(NSArray *)dataSource
               callbackBlock:(LHActionViewBlock)block;

@end
