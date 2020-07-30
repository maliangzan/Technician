//
//  NSString+JMC.m
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "NSString+JMC.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (JMC)

#pragma mark - MD5
- (NSString *)toMD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSURL *)toURL {
    NSString *url = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:url];
}

- (id)toJSON {
    
    if (self!= nil && self.length > 0) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        return json;
    }
    
    return nil;
}

+ (NSString *)stringWithJSON:(id)JSON {
    
    if (JSON == nil || [JSON isEqual:[NSNull null]]) {
        return @"";
    }
    if ([JSON respondsToSelector:@selector(length)] && [JSON length] < 1) {
        return @"";
    }
    if ([NSJSONSerialization isValidJSONObject:JSON] == NO) {
        return @"";
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSON options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

- (UIImage *)toCacheImage {
    return [UIImage imageNamed:self];
}

- (UIImage *)toBundleImagePNG {
    NSString *path = [[NSBundle mainBundle] pathForResource:self ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark - Unicode to UTF8
- (NSString *)unicode2UTF8 {
    
//    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
//    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    return Localized(@"错误");

//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
//    
//    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


- (NSString *)URLEncodedString {
    NSString * url = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return url;
}

- (NSString *)xcSubstringFromMinLength:(NSUInteger)min {
    min = self.length > min ? min : self.length;
    return [self substringToIndex:min];
}

- (NSNumber *)number {
    if ([self isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[self integerValue]];
    }
    
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    }
    
    return nil;
}

+ (NSString *)int2str:(int)num {
    return [NSString stringWithFormat:@"%d", num];
}

+ (NSString *)random {
    return [NSString stringWithFormat:@"random_string_%08X_%08X", arc4random(), arc4random()];
}

+ (NSString *)timestampBy1970 {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%f", interval];
}

//- (UIImage *)nameToImage {
//    return [UIImage bundlePNG:self];
//}



- (NSArray *)findAllSubstringRange:(NSString *)sub {
    
    if (sub.length == 0 || self.length == 0 || sub.length > self.length) {
        return nil;
    }
    
    NSUInteger loc = 0;
    NSInteger len = self.length;
    NSMutableArray *ay = [NSMutableArray arrayWithCapacity:5];
    
    do {
        NSRange range = [self rangeOfString:sub options:0 range:NSMakeRange(loc, len)];
        if (range.length == 0) {
            break;
        }else {
            [ay addObject:[NSValue valueWithRange:range]];
            loc = range.length + range.location - 1;    //  NSMaxRange
            len = len - loc;
            
            if (len <= 0) {
                break;
            }
        }
    } while (YES);
    
    return ay;
}

@end
