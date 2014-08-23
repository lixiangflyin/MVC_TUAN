//
//  LHTabBarController.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LHTabBarController.h"
#import "const.h"
#import <QuartzCore/QuartzCore.h>

#define TabBarNoramlFrame CGRectMake(0, SCREEN_HEIGHT - TAB_BAR_HEIGHT, SCREEN_WIDTH, TAB_BAR_HEIGHT)
#define TabBarHideFrame CGRectMake(0, SCREEN_HEIGHT - TAB_BAR_HEIGHT + TAB_BAR_HEIGHT, SCREEN_WIDTH, TAB_BAR_HEIGHT)

@interface LHTabBarController()<UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) NSArray        *controllers;
@property (nonatomic, strong) NSArray        *normalItemIcons, *highlightItemIcons;
@property (nonatomic, strong) NSMutableArray *tabBarItems;
@property (nonatomic, strong) NSString       *selectedItemBackgroundImageName;
@property (nonatomic, strong) NSString       *tabBarBackgroundName;
@property (nonatomic, strong) UIView         *tabBar;
@property (nonatomic, strong) UIImageView    *selectedItemBackgroundView;
@property (nonatomic, assign) NSUInteger     currentSelectedIndex, lastSelectedIndex;
@end

@implementation LHTabBarController

- (LHTabBarController *)initWithViewControllers:(NSArray *)controllers
                          tabBarNormalItemIcons:(NSArray *)normalItemIcons
                       tabBarHighlightItemIcons:(NSArray *)highlightItemIcons
                selectedItemBackgroundImageName:(NSString *)itemBackground
                      tabBarBackgroundImageName:(NSString *)tabBarBackgroundName
{
    if(self = [super init])
    {
        NSAssert(controllers && controllers.count >= 1, @"需要至少传递一个控制器");
        NSAssert(normalItemIcons && normalItemIcons.count >= 1, @"需要至少传递一个正常状态的标签栏目图标");
        NSAssert(controllers.count == normalItemIcons.count, @"视图控制器数目与标签栏数目不相符!");
        if(highlightItemIcons != nil)
        {
            NSAssert(highlightItemIcons.count == normalItemIcons.count, @"标签栏目正常状态图标与高亮状态图标的数目不相等");
        }
        self.controllers = controllers;
        self.normalItemIcons = normalItemIcons;
        self.highlightItemIcons = highlightItemIcons;
        self.tabBarBackgroundName = tabBarBackgroundName;
        self.selectedItemBackgroundImageName = itemBackground;
        self.currentSelectedIndex = 0;
        self.lastSelectedIndex = 0;
        
        for(UIViewController *c in self.controllers){
            if([[c class] isSubclassOfClass:[UINavigationController class]]){
                UINavigationController *nav = (UINavigationController *)c;
                nav.delegate = self;
                nav.view.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    
    return self;
}

//重载覆盖
- (void)loadView
{
    [super loadView];
    
    // 添加标签栏视图
    self.tabBar = [[UIView alloc] initWithFrame:TabBarNoramlFrame];
    [self.view addSubview:self.tabBar];
    
    // 设置标签栏背景
    UIImage *image = [UIImage imageNamed:self.tabBarBackgroundName];
    NSAssert(image, @"加载标签栏背景图片失败");
    UIImageView *tabBarBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TAB_BAR_HEIGHT)];
    tabBarBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tabBarBackgroundView.image = image;
    tabBarBackgroundView.userInteractionEnabled = NO;
    [self.tabBar insertSubview:tabBarBackgroundView atIndex:0];

    // 设置标签栏选中项背景
    NSUInteger itemCount = self.normalItemIcons.count;
    CGFloat itemWidth = SCREEN_WIDTH / itemCount;
    if(self.selectedItemBackgroundImageName)
    {
        UIImage *image = [UIImage imageNamed:self.selectedItemBackgroundImageName];
        NSAssert(image, @"加载标签栏选中项背景图失败");
        self.selectedItemBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, TAB_BAR_HEIGHT)];
        self.selectedItemBackgroundView.userInteractionEnabled = NO;
        self.selectedItemBackgroundView.image = image;
        [self.tabBar addSubview:self.selectedItemBackgroundView];
    }
    
    // 设置标签栏项目
    self.tabBarItems = [NSMutableArray new];
    for(NSUInteger i = 0; i != itemCount; i++)
    {
        UIImage *image = [UIImage imageNamed:self.normalItemIcons[i]];
        NSAssert(image, @"加载标签栏普通状态图标失败");
        UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, TAB_BAR_HEIGHT)];
        item.userInteractionEnabled = NO;
        item.image = image;
        [self.tabBar addSubview:item];
        [self.tabBarItems addObject:item];
    }
    
    // 加第一个控制器的视图添加到标签栏控制器中
    UIViewController *controller = self.controllers[self.currentSelectedIndex];
    controller.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT);
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.tabBar];
    
    if(self.highlightItemIcons)
    {
        UIImage *highlightImage = [UIImage imageNamed:self.highlightItemIcons[self.currentSelectedIndex]];
        NSAssert(highlightImage, @"加载标签栏高亮状态图标失败");
        UIImageView *tabBarItem = self.tabBarItems[self.currentSelectedIndex];
        tabBarItem.image = highlightImage;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    if(location.y < SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) // 如果用户点击的范围不在标签栏上就不响应操作
    {
        return;
    }
    
    NSUInteger itemCount = self.normalItemIcons.count;
    CGFloat itemWidth = SCREEN_WIDTH / itemCount;
    NSUInteger index = floor(location.x / itemWidth);
    NSAssert(index < self.controllers.count, @"在标签栏中计算当前索引值发生错误");
    if(index == self.currentSelectedIndex)
    {
        return;
    }
    self.lastSelectedIndex = self.currentSelectedIndex;
    self.currentSelectedIndex = index;
    
    // 将前一个显示的视图移动到可视区外
    UIViewController *previousController = self.controllers[self.lastSelectedIndex];
    CGRect f = previousController.view.frame;
    f.origin.x = f.size.width;
    previousController.view.frame = f;
    
    BOOL viewInContainer = NO;
    UIViewController *controller = self.controllers[self.currentSelectedIndex];
    for(UIView *view in self.view.subviews)
    {
        if([view isEqual:controller.view])
        {
            viewInContainer = YES;
        }
    }
    if(viewInContainer == NO)
    {
        [controller willMoveToParentViewController:self];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
    controller.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT);
    [self.view bringSubviewToFront:controller.view];
    [self.view bringSubviewToFront:self.tabBar];
    
    if(self.highlightItemIcons)
    {
        UIImage *highlightImage = [UIImage imageNamed:self.highlightItemIcons[self.currentSelectedIndex]];
        NSAssert(highlightImage, @"加载标签栏高亮状态图标失败");
        UIImageView *selectedTabBarItem = self.tabBarItems[self.currentSelectedIndex];
        selectedTabBarItem.image = highlightImage;
    }
    UIImage *normalImage = [UIImage imageNamed:self.normalItemIcons[self.lastSelectedIndex]];
    UIImageView *lastSelectedTabBarItem = self.tabBarItems[self.lastSelectedIndex];
    lastSelectedTabBarItem.image = normalImage;
    
    if(self.selectedItemBackgroundImageName)
    {
        [UIView animateWithDuration:0.0 animations:^{
            CGRect f = self.selectedItemBackgroundView.frame;
            f.origin.x = self.currentSelectedIndex * f.size.width;
            self.selectedItemBackgroundView.frame = f;
        }];
    }
}


#pragma mark - UINavigation Conroller Delegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isEqual:navigationController.viewControllers[0]]){
        //如果导航控制器目前显示的是根控制器，那么他的边框nbound的大小与bound是相等的
        CGRect nbound = navigationController.view.bounds;
        CGRect bound = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT );
        if(CGRectEqualToRect(nbound, bound) == NO){
            CGRect f = navigationController.view.frame;
            f.size.height -= TAB_BAR_HEIGHT;
            navigationController.view.frame = f;
        }
        
        [UIView animateWithDuration:0.35 animations:^{
            self.tabBar.frame = TabBarNoramlFrame;
            //self.tabBar.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }else{
        if(viewController.hidesBottomBarWhenPushed){
            CGRect nbound = navigationController.view.bounds;
            CGRect bound = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
            if(CGRectEqualToRect(nbound, bound) == NO){
                CGRect f = navigationController.view.frame;
                f.size.height += TAB_BAR_HEIGHT;
                navigationController.view.frame = f;
            }
            
            [UIView animateWithDuration:0.35 animations:^{
                self.tabBar.frame = TabBarHideFrame;
                //self.tabBar.transform = CGAffineTransformMakeScale(0, 0);
            }];
        }
    }
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
@end
