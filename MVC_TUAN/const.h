//
//  const.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#ifndef MVCdemo_const_h
#define MVCdemo_const_h

#define NAVIGATION_BAR_HEIGHT        44.0
#define TAB_BAR_HEIGHT               49.0
#define STATUS_BAR_HEIGHT            20.0
#define SCREEN_WIDTH                 320.0
//屏幕高度ios6 ios7
#define SCREEN_HEIGHT ([[UIApplication sharedApplication] isStatusBarHidden] ? ([[UIScreen mainScreen] bounds].size.height) : ([[UIScreen mainScreen] bounds].size.height))

//颜色设置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LHError(error) if (error) { \
NSLog(@"在文件:%@(%d行)发生错误: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, [error localizedDescription]); \
}

#define LHException(ex) if (ex) { \
NSLog(@"在文件:%@(%d行)产生异常: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, [ex reason]); \
}

#define FLOAT_TO_STRING(f) [NSString stringWithFormat:@"%.2f",f]


#endif
