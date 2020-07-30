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
#define KNavHeight 64.0
#define kCustomNavHeight 65*kHeightFactor

#define APP_Frame_WithoutNavTabBar ([[UIScreen mainScreen] applicationFrame].size.height-49-44)

// base on iPhone5
#define kHeightFactor (APP_Frame_Height/568.0)
#define kWidthFactor (APP_Frame_Width/320.0)

//NSNotificationCenter
#define ObserveNotification(aname, act)\
[[NSNotificationCenter defaultCenter] addObserver:self selector:act name:aname object:nil]

#define PostNotificationWithName(name)\
[[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]

#define PostNotificationWithUserInfo(name,info)\
[[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info]

//颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kAppColorBackground [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define kAppColorLineBorder [UIColor colorWithRed:226/255.0 green:227/255.0 blue:228/255.0 alpha:1]
#define kAppColorLine [UIColor hexColor:0xe4e4e4]
//技师端主色以及字体辅
//绿色
#define kAppColorAuxiliaryGreen [UIColor hexColor:0x1cc6a2]
//浅绿色
#define kAppColorLightGreen [UIColor hexColor:0x93D9B7]
//辅助色（深橙色）
#define kAppColorAuxiliaryDeepOrange [UIColor hexColor:0xfa6723]
//辅助色（浅橙色）
#define kAppColorAuxiliaryLightOrange [UIColor hexColor:0xfe8a00]
//背景色（深色登录注册）：
#define kAppColorBackgroundDeep [UIColor hexColor:0xeff0f0]
//背景色（浅色)
#define kAppColorLight [UIColor hexColor:0xf5f5f5]
//分割线（浅色）
#define kAppColorDividerLight [UIColor hexColor:0xeeeeee]
//分割线（中间色)
#define kAppColorDividerMiddle [UIColor hexColor:0xe2e5e7]
//分割线（深色）
#define kAppColorDividerDeep [UIColor hexColor:0xdddddd]
//字体（黑色）
#define kAppColorTextBlack [UIColor hexColor:0x333333]
//字体（中黑色）
#define kAppColorTextMiddleBlack [UIColor hexColor:0x666666]
//字体（浅黑色）
#define kAppColorTextLightBlack [UIColor hexColor:0x999999]
//字体（浅灰色）
#define kAppColorTextLightGray [UIColor hexColor:0xcccccc]
//分割线(浅白色）
#define kAppColorLineLightWhite [UIColor hexColor:0xFFFFFF alpha:0.5]


//国际化
#define Localized(s) NSLocalizedString(s,s)

//专场动画间隔
#define kAnimationTime (0.3f)

//WeakSelf
#define WeakSelf __weak __typeof__(self) weakself = self

//UIButton
#define ButtonSelfAction(abtn, act)\
[abtn addTarget:self action:act forControlEvents:UIControlEventTouchUpInside];

//UIImage
#define PNGIMAGE(NAME) [[UIImage imageNamed:NAME] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
#define placeh_userAvatar       [UIImage imageNamed:@"sxy_detailuserhead"]
#define placeh_image            [UIImage imageNamed:@"placeh-image"]

typedef NS_ENUM(NSInteger, SYOrderStadues) {
    SYOrderStaduesAll           = 100,//全部
    SYOrderStaduesToBeConfirmed = 101,//待确认
    SYOrderStaduesForThePayment = 102,//待付款
    SYOrderStaduesForTheService = 103,//待服务
    SYOrderStaduesComplete      = 104,//已完成
};

//  call phone
#define CallWithPhoneNumber(phone) \
NSString *call = [NSString stringWithFormat:@"telprompt://%@", phone];\
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];

// 自定义 call phone
#define CallWithPhoneNumberAndPreStr(phone,preStr) \
NSString *content = [NSString stringWithFormat:@"%@:%@",preStr, phone];\
[[SYAlertViewTwo(Localized(@"提示"), content, Localized(@"取消"), Localized(@"呼叫"))\
setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {\
if (index != kAlertCancelIndex) {\
NSString *call = [NSString stringWithFormat:@"tel://%@", phone];\
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];\
}\
}] show];


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
