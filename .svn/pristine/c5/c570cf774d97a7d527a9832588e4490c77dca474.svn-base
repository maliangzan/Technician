//
//  UIWebView+JMJavaScript.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIWebView+JMJavaScript.h"

@implementation UIWebView (JMJavaScript)
- (NSString *)jsHTML {
    NSString *js = @"document.documentElement.innerHTML";
    return [self stringByEvaluatingJavaScriptFromString:js];
}

//  document.body.innerText  纯文字
- (NSString *)jsBody {
    NSString *js = @"document.body.innerHTML";
    return [self stringByEvaluatingJavaScriptFromString:js];
}

- (NSString *)jsHTMLTitle {
    NSString *js = @"document.title";
    return [self stringByEvaluatingJavaScriptFromString:js];
}
@end
