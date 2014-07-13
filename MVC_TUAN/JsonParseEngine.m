//
//  JsonParseEngine.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "JsonParseEngine.h"
#import "AFNetworking.h"

//网络请求类

//获取十大
#define api_bbs_topTen                     @"http://bbs.seu.edu.cn/api/hot/topten.json"

@implementation JsonParseEngine

+ (void *)getTopTenOnSuccess:(ArrayBlock)onSuccess
                     onError:(ErrorBlock)onError
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:api_bbs_topTen parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = responseObject;
        
        BOOL success = [[dic objectForKey:@"success"] boolValue];
        if (success)
        {
            NSArray * objects = [dic objectForKey:@"topics"];
            
            NSMutableArray *modelArray = [NSMutableArray new];
            for(NSMutableDictionary *dict in objects)
            {
                [modelArray addObject:[[Topic alloc] initWithDictionary:dict]];
            }
            
            onSuccess(modelArray);
            
        }else
        {
            NSLog(@"错误！");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error!");
        onError(error);
        
    }];
    
    return 0;
}

//获取城市列表 本地测试
+ (void *)getCityListOnSuccess:(DictionaryBlock)onSuccess
                       onError:(ErrorBlock)onError
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_data" ofType:@"plist"];
    NSMutableDictionary *cityListDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if(cityListDictionary.count)
        onSuccess(cityListDictionary);
    else
        onError(nil);
    
    return 0;
    
}


// 缓存文件路径
+ (NSString *)cacheFilePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *CacheDirectory = paths[0];
    return  [CacheDirectory stringByAppendingPathComponent:fileName];
}


// 缓存是否过期
+ (BOOL)isCacheStale:(NSString *)fileName
{
    NSString *archivePath = [JsonParseEngine cacheFilePath:fileName];
    NSTimeInterval stalenessLevel = [[[[NSFileManager defaultManager] attributesOfItemAtPath:archivePath error:nil]
                                      fileModificationDate] timeIntervalSinceNow];
    return abs(stalenessLevel) > 259200; // 4天为过期时间
}


@end
