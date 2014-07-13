//
//  ViewController.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

// 每个模型类都应该继承此类以实现将JSON数据映射为一个对象
@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

-(id) initWithDictionary:(NSMutableDictionary *) jsonObject;

@end
