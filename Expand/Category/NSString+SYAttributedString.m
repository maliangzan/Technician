//
//  NSString+SYAttributedString.m
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NSString+SYAttributedString.h"

@implementation NSString (SYAttributedString)

+ (NSMutableAttributedString *)joiningTogetherSting:(NSString *)aString withAStringColor:(UIColor *)aColor andBString:(NSString *)bString   withBStringColor:(UIColor*)bColor{
    NSString *togetherSting = [NSString stringWithFormat:@"%@%@",aString,bString];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:togetherSting];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:aColor range:NSMakeRange(0, aString.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:bColor range:NSMakeRange(aString.length, bString.length)];

    return attrStr;
}

+ (NSMutableAttributedString *)insertString:(NSString *)insertString withInsertStringColor:(UIColor *)insertStringColor toString:(NSString *)toString stringColor:(UIColor *)toStringColor atIndex:(NSInteger)index{
    NSMutableAttributedString *attrInsertStr = [[NSMutableAttributedString alloc] initWithString:insertString];
    [attrInsertStr addAttribute:NSForegroundColorAttributeName value:insertStringColor range:NSMakeRange(0, insertString.length)];
    NSMutableAttributedString *toAttrString = [[NSMutableAttributedString alloc] initWithString:toString];
    [toAttrString addAttribute:NSForegroundColorAttributeName value:toStringColor range:NSMakeRange(0, toString.length)];
    [toAttrString insertAttributedString:attrInsertStr atIndex:index];
    
    return toAttrString;
}

- (NSMutableAttributedString *)gettingAttributeString{
    NSString *servieceStr = @"";
    NSString *evaluationStr = @"";
    NSString *scoreStr = @"";
    NSString *str = [NSString stringWithFormat:@""];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    textAttachment.image = PNGIMAGE(@"img_star_orange");; //设置图片
    textAttachment.bounds = CGRectMake(0, 0, 10, 10); //图片范围
    NSAttributedString *textString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:textString atIndex: 6 + servieceStr.length + evaluationStr.length + 10 * 2];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(2, servieceStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(15 + evaluationStr.length, evaluationStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(attrStr.length - 1 - scoreStr.length, scoreStr.length)];
    return attrStr;
}
@end
