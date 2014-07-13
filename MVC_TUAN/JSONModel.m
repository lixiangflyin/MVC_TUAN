//
//  ViewController.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "JSONModel.h"
#import "const.h"

@implementation JSONModel

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject
{
    if((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;
}

#pragma mark - Key Value Coding

- (id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"%@：获取值出错，未定义的键：%@", NSStringFromClass([self class]), key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@：设置值出错，未定义的键：%@: %@", NSStringFromClass([self class]), key, value);
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    @try {
        [super setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        LHException(exception);
    }
}

#pragma mark - NSCoding

-(BOOL) allowsKeyedCoding
{
	return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [super init];
}

#pragma mark - NSCopying, NSMutableCopying

- (id)copyWithZone:(NSZone *)zone
{
    return  [[JSONModel allocWithZone:zone] init];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return  [[JSONModel allocWithZone:zone] init];
}

@end
