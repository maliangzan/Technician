//
//  NSMutableArray+SYArrayHelper.m
//  Technician
//
//  Created by TianQian on 2017/6/16.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NSMutableArray+SYArrayHelper.h"

@implementation NSMutableArray (SYArrayHelper)

- (NSString *)arrayToJson
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
