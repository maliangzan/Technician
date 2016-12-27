//
//  HYMacros.h
//  Technician
//
//  Created by 马良赞 on 16/12/21.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#ifndef HYMacros_h
#define HYMacros_h

//App Frame
#define Application_Frame [[UIScreen mainScreen] applicationFrame]

//App Frame Height&Width
#define APP_Frame_Height ([[UIScreen mainScreen] applicationFrame].size.height)
#define APP_Frame_Width  ([[UIScreen mainScreen] applicationFrame].size.width)

#define KscreenWidth [UIScreen mainScreen].bounds.size.width
#define KscreenHeight [UIScreen mainScreen].bounds.size.height

#define APP_Frame_WithoutNavTabBar ([[UIScreen mainScreen] applicationFrame].size.height-49-44)

// base on iPhone5
#define kHeightFactor (APP_Frame_Height/568.0)
#define kWidthFactor (APP_Frame_Width/320.0)

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//国际化
#define Localized(s) NSLocalizedString(s,s)

//专场动画间隔
#define kAnimationTime (0.3f)

#define PNGIMAGE(NAME) [[UIImage imageNamed:NAME] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define iPhone4 (480)

//ios系统版本
#define IOS6 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 6.0)
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)

//不显示mqtt log
#define MQTT_DISABLE_LOGGING

//不显示get log
#define SVHTTPREQUEST_DISABLE_LOGGING

#endif /* HYMacros_h */
