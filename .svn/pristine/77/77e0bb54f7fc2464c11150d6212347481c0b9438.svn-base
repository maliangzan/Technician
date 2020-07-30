//
//  UIButton+Extern.m
//  smanos
//
//  Created by sven on 3/2/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import "UIButton+Extern.h"

@implementation UIButton (Extern)

+ (UIButton *)buttonWithImage:(NSString *)image
               highlightImage:(NSString *)highlightImage
                          tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    btn.tag = tag;
    return btn;
}

+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:color];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

@end
