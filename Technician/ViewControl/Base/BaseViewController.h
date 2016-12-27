//
//  BaseViewController.h
//  smanos
//
//  Created by sven on 3/16/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)buildUI;
- (void)hideNavBarBottomLine;

- (void)showWaitTips:(NSString *)tip;
- (void)disMissWaitTips;
@end
