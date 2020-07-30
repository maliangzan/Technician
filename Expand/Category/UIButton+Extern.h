//
//  UIButton+Extern.h
//  smanos
//
//  Created by sven on 3/2/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extern)
+ (UIButton *)buttonWithImage:(NSString *)image
               highlightImage:(NSString *)highlightImage
                          tag:(NSInteger)tag;

+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title;
@end
