//
//  Attachment.m
//  SBBS-OS-X-Client
//
//  Created by Huang Feiqiao on 13-1-24.
//  Copyright (c) 2013年 Huang Feiqiao. All rights reserved.
//

#import "Attachment.h"

@implementation Attachment
@synthesize attId;
@synthesize attFileName;
@synthesize attPos;
@synthesize attSize;
@synthesize attUrl;


- (void) setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.attId = [value intValue];
        
    }else if([key isEqualToString:@"filename"]){
        self.attFileName = value;
        
    }else if([key isEqualToString:@"pos"]){
        self.attPos = [value intValue];
        
    }else if([key isEqualToString:@"size"]){
        self.attSize = [value intValue];
        
    }else if([key isEqualToString:@"url"]){
        self.attUrl = value;
        
    }else{
        [super setValue:value forKey:key];
    }

}

@end
