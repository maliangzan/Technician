//
//  UIWebView+JMJavaScript.h
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JMJavaScript)

- (NSString *)jsHTML;
- (NSString *)jsBody;
- (NSString *)jsHTMLTitle;
@end
