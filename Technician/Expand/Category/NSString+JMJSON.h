//
//  NSString+JMJSON.h
//  JMCategory
//
//  Created by xserver on 15/7/1.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JMJSON)

- (id)toJSON;
+ (NSString *)fromJSONObject:(id)json;

@end
