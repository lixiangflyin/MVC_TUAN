//
//  LHTabBarController.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
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
