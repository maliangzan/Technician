//
//  NSString+SYAttributedString.h
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYAttributedString)
+ (NSMutableAttributedString *)joiningTogetherSting:(NSString *)aString withAStringColor:(UIColor *)aColor andBString:(NSString *)bString   withBStringColor:(UIColor*)bColor;
+ (NSMutableAttributedString *)insertString:(NSString *)insertString withInsertStringColor:(UIColor *)insertStringColor toString:(NSString *)toString stringColor:(UIColor *)toStringColor atIndex:(NSInteger)index;
@end
