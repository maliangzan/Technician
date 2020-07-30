//
//  NSString+JMJSON.m
//  JMCategory
//
//  Created by xserver on 15/7/1.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "NSString+JMJSON.h"

@implementation NSString (JMJSON)
- (id)toJSON {
    
    if (self!= nil && self.length > 0) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        return json;
    }
    
    return nil;
}

+ (NSString *)fromJSONObject:(id)json {
    
    if (json == nil || [json isEqual:[NSNull null]]) {
        return @"";
    }
    
    if ([json respondsToSelector:@selector(length)] && [json length] < 1) {
        return @"";
    }
    
    if ([NSJSONSerialization isValidJSONObject:json] == NO) {
        return @"";
    }
    
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

@end
