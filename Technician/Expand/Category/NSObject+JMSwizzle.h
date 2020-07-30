//
//  NSObject+JMSwizzle.h
//  Printer
//
//  Created by xserver on 15/10/9.
//  Copyright (c) 2015年 Pitaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JMSwizzle)

/**
 *
 *  @param originalSelector 想要替换的方法
 *  @param swizzledSelector 实际替换为的方法
 *  @param error            替换过程中出现的错误，如果没有错误为nil
 *
 *  @return 是否成功
 */
+ (BOOL)jm_SwizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

@end
