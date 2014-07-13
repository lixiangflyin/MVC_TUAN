//
//  JsonParseEngine.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

//网络请求类

#import <Foundation/Foundation.h>
#import "Attachment.h"
#import "Topic.h"
#import "City.h"

typedef void (^VoidBlock) (void);
typedef void (^ModelBlock) (JSONModel* aModelBaseObject);
typedef void (^ArrayBlock) (NSMutableArray* listOfModelBaseObjects);
typedef void (^DictionaryBlock)(NSMutableDictionary *dictionary);
typedef void (^ErrorBlock) (NSError* engineError);

@interface JsonParseEngine : NSObject

//获取十大
+ (void *)getTopTenOnSuccess:(ArrayBlock)onSuccess
                                 onError:(ErrorBlock)onError;

//获取城市列表
+ (void *)getCityListOnSuccess:(DictionaryBlock)onSuccess
                                     onError:(ErrorBlock)onError;

// 缓存文件路径
+ (NSString *)cacheFilePath:(NSString *)fileName;


@end
