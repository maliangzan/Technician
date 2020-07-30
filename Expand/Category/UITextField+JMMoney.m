//
//  UITextField+JMMoney.m
//  JMCategory
//
//  Created by xserver on 15/12/3.
//  Copyright © 2015年 pitaya. All rights reserved.
//

#import "UITextField+JMMoney.h"

@implementation UITextField (JMMoney)

- (BOOL)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxNumber:(CGFloat)number {
    
    //  小数点
    if ([string isEqualToString:@"."]) {
        //  第一个是小数点
        if (range.location == 0) {
            return NO;
        }
        //  两个小数点
        if ([self.text rangeOfString:@"."].location != NSNotFound) {
            return NO;
        }
    }
    
    //  第一个是0 第二个数只能是点
    if ([self.text isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
        return NO;
    }

    //  大于 max
    if ([[self.text stringByAppendingString:string] doubleValue] > number) {
        return NO;
    }
    
    //  小数点后只能有两位
    NSInteger flag = 0;
    const NSInteger limited = 2;
    NSString *result = [self.text stringByAppendingString:string];
    
    for (NSInteger i = result.length - 1; i >= 0; i--) {
        
        if ([result characterAtIndex:i] == '.') {
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}

@end
