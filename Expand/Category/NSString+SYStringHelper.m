//
//  NSString+SYStringHelper.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NSString+SYStringHelper.h"

@implementation NSString (SYStringHelper)

+ (CGFloat)heightForString:(NSString *)string labelWidth:(CGFloat)width fontOfSize:(NSInteger)fontSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (CGFloat)widthForString:(NSString *)string labelHeight:(CGFloat)height fontOfSize:(NSInteger)fontSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

+ (NSString *)gettingImageURLStringWithCustomURLString:(NSString *)cusURLStr{
    
    cusURLStr = [cusURLStr stringByReplacingOccurrencesOfString:@"|" withString:@""];
    cusURLStr = [NSString stringWithFormat:@"%@%@",URL_HTTP_PIC_BASE,cusURLStr];
    
    return cusURLStr;
}

- (NSString *)urlNSUTF8StringEncoding{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
