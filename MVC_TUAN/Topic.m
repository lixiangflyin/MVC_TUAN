//
//  Topic.m
//  虎踞龙盘BBS
//
//  Created by 张晓波 on 4/27/12.
//  Copyright (c) 2012 Ethan. All rights reserved.
//

#import "Topic.h"
#import "Attachment.h"

@implementation Topic
@synthesize ID;//帖子ID
@synthesize gID; //帖子所在主题的主ID
@synthesize board; //帖子所在版面
@synthesize size; //帖子大小
@synthesize read; //文章阅读数
@synthesize replies; //文章回复数
@synthesize reid; //回复帖子的id
@synthesize unread; //是否未读
@synthesize top; //是否置顶
@synthesize mark; //是否标记过
@synthesize norep; //文章设有’不可RE’标记
@synthesize author; //发贴人
@synthesize time; //发贴时间戳
@synthesize title; //标题
@synthesize content; //内容
@synthesize quote; //帖子引用的内容
@synthesize quoter; //引用内容的作者
@synthesize last_author; //最后回复用户
@synthesize last_time; //最后恢复时间
@synthesize attachments;//附件

- (void) setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.ID = [value integerValue];
        
    }else if([key isEqualToString:@"gid"]){
        self.gID = [value integerValue];
        
    }else if([key isEqualToString:@"reid"]){
        self.reid = [value integerValue];
        
    }else if([key isEqualToString:@"title"]){
        self.title = value;
        
    }else if([key isEqualToString:@"content"]){
        self.content = value;
        
    }else if([key isEqualToString:@"author"]){
        self.author = value;
        
    }else if([key isEqualToString:@"board"]){
        self.board = value;
        
    }else if([key isEqualToString:@"time"]){
        NSTimeInterval interval = [value doubleValue];
        NSDate *t = [NSDate dateWithTimeIntervalSince1970:interval];
        self.time = t;
        
    }else if([key isEqualToString:@"read"]){
        self.read = [value integerValue];
        
    }else if([key isEqualToString:@"quote"]){
        self.quote = value;
        
    }else if([key isEqualToString:@"quoter"]){
        self.quoter = value;
        
    }else if([key isEqualToString:@"attachments"]){
        //附件
        self.attachments = [NSMutableArray array];
        NSArray *array = (NSArray *)value;
        for(NSMutableDictionary *dic in array){
            [self.attachments addObject:[[Attachment alloc] initWithDictionary:dic]];
        }
        
    }else{
        [super setValue:value forKey:key];
    }

}




@end
