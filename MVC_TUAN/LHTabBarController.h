//
//  LHTabBarController.h
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-7-16.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTabBarController : UIViewController

@property (nonatomic, readonly) NSArray        *controllers;


- (LHTabBarController *)initWithViewControllers:(NSArray *)controllers
                          tabBarNormalItemIcons:(NSArray *)normalItemIcons
                       tabBarHighlightItemIcons:(NSArray *)highlightItemIcons
                selectedItemBackgroundImageName:(NSString *)itemBackground
                      tabBarBackgroundImageName:(NSString *)tabBarBackgroundName;
@end
