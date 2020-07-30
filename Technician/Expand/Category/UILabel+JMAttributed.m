//
//  UILabel+JMAttributed.m
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UILabel+JMAttributed.h"

@implementation UILabel (JMAttributed)

- (void)setSubstringColor:(UIColor *)color range:(NSRange)range {
    if (self.text.length < range.length) {
        return;
    }
    NSDictionary *dic = @{NSForegroundColorAttributeName: color};
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.text];
    [att addAttributes:dic range:range];
    [self setAttributedText:att];
}

//- (void)setAllSubstring:(NSString *)sub color:(UIColor *)color {
//    
//    NSArray *ranges = [self.text findAllSubstringRange:sub];
//    if (ranges == nil) {
//        return;
//    }
//    
//    NSDictionary *dic = @{NSForegroundColorAttributeName: color};
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.text];
//    
//    for (NSValue *value in ranges) {
//        [att addAttributes:dic range:[value rangeValue]];
//    }
//    
//    [self setAttributedText:att];
//}

//- (NSArray *)findAllSubstringRange:(NSString *)sub {
//    
//    if (sub.length == 0 || self.length == 0 || sub.length > self.length) {
//        return nil;
//    }
//    
//    NSUInteger loc = 0;
//    NSInteger len = self.length;
//    NSMutableArray *ay = [NSMutableArray arrayWithCapacity:5];
//    
//    do {
//        NSRange range = [self rangeOfString:sub options:0 range:NSMakeRange(loc, len)];
//        if (range.length == 0) {
//            break;
//        }else {
//            [ay addObject:[NSValue valueWithRange:range]];
//            loc = range.length + range.location - 1;    //  NSMaxRange
//            len = len - loc;
//            
//            if (len <= 0) {
//                break;
//            }
//        }
//    } while (YES);
//    
//    return ay;
//}
@end
