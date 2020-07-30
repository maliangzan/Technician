//
//  UIColor+JMHex.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIColor+JMHex.h"

@implementation UIColor (JMHex)

+ (UIColor *)getArc4randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

+ (UIColor *)hexColor:(UInt32)hex {
    return [self hexColor:hex alpha:1.0];
}

+ (UIColor *)hexColor:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0
                           green:((hex & 0x00FF00) >> 8) / 255.0
                            blue:((hex & 0xFF) >> 0) / 255.0
                           alpha:alpha];
}

+ (UIColor *)hexColorWithString:(NSString *)string {
    
    if ( ! (string.length == 6 || string.length == 8)) {
        return nil;
    }
    
    if (string.length == 8) {
        string = [string substringFromIndex:2];
    }
    
    const char *numberChar = string.UTF8String;
    UInt32 hexNumber = strtoul(numberChar, 0, 16);
    
    return [self hexColor:hexNumber alpha:1.0];
}
@end
