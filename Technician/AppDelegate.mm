//
//  AppDelegate.m
//  Technician
//
//  Created by 马良赞 on 16/12/21.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "SYAppConfig.h"
#import "HomeViewController.h"
#import "OrdersViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic) BOOL isLaunchedByNotification;//是否通过点击通知消息进入本应用

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:1.5]; //闪屏时间太短 -----  增加时间的
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isOnTheLoginViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //开始定位
    [[SYAppConfig shared] startLocation];
    
    //JPush
    [self configAPNsService];
    [self configJPushServiceWithOptions:launchOptions];
    
    [self setupKeyboardManager];
    
    [[SYAppConfig shared] setup];
    
    [self initRegisterNotification:application];
    [AMapServices sharedServices].apiKey = gaoDekey;
    [self configCustomWindow];
    
    [self.window makeKeyAndVisible];
    // 将下面C函数的函数地址当做参数，将系统提供的获取崩溃信息函数写在这个方法中，以保证在程序开始运行就具有获取崩溃信息的功能
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    //如果remoteNotification不为空，则说明用户通过推送消息进入
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.isLaunchedByNotification= isNullDictionary(remoteNotification);

    return YES;
}

//添加初始化APNs代码
- (void)configAPNsService{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

//添加初始化JPush代码
- (void)configJPushServiceWithOptions:(NSDictionary *)launchOptions{
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
}


#pragma mark JPUSHRegisterDelegate
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support 点击推送消息进入
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
    //点击推送消息，进入消息界面
    [[SYAppConfig shared] gotoMessageViewControllerWithUserInfo:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)configCustomWindow{
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.navigationController.navigationBarHidden = YES;
    
    OrdersViewController *ordersVC = [[OrdersViewController alloc]init];
    UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:ordersVC];
    ordersVC.navigationController.navigationBarHidden = YES;
    
    FindViewController *findVC = [[FindViewController alloc]init];
    UINavigationController *findNav = [[UINavigationController alloc] initWithRootViewController:findVC];
    findVC.navigationController.navigationBarHidden = YES;
    
    MeViewController *meVC = [[MeViewController alloc]init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    meVC.navigationController.navigationBarHidden = YES;
    
    UITabBarItem *homeItem = [[UITabBarItem alloc]initWithTitle:@"工作室" image:PNGIMAGE(@"Home_tab_Item_default") selectedImage:PNGIMAGE(@"Home_tab_Item_select")];
    UITabBarItem *ordersItem = [[UITabBarItem alloc]initWithTitle:@"接单" image:PNGIMAGE(@"Orders_tab_Item_default") selectedImage:PNGIMAGE(@"Orders_tab_Item_select")];
    UITabBarItem *findItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:PNGIMAGE(@"Find_tab_Item_default") selectedImage:PNGIMAGE(@"Find_tab_Item_select")];
    UITabBarItem *meItem = [[UITabBarItem alloc]initWithTitle:@"我" image:PNGIMAGE(@"Me_tab_Item_default") selectedImage:PNGIMAGE(@"Me_tab_Item_select")];
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    NSLog(@"tabBar = %@",tabBar);
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hexColor:0x1cc6a2],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [ordersItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hexColor:0x1cc6a2],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [findItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hexColor:0x1cc6a2],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [meItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hexColor:0x1cc6a2],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [homeVC setTabBarItem:homeItem];
    [ordersVC setTabBarItem:ordersItem];
    [findVC setTabBarItem:findItem];
    [meVC setTabBarItem:meItem];
    
    [tabBar setViewControllers:[NSArray arrayWithObjects:homeNav,orderNav,findNav,meNav, nil]];
    
    self.window.rootViewController = tabBar;
    
//    //启动页
    // 执行动画
//    [UIView animateWithDuration:3 animations:^{
//        // 两秒内图片变大为原来的1.3倍
//        imageView.transform = CGAffineTransformMakeScale(1.3,1.3);
//    } completion:^(BOOL finished) {
//        // 动画结束，移除imageView，呈现主界面
//        [imageView removeFromSuperview];
//        self.window.rootViewController = tabBar;
//    }];
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 60)];
//    backView.backgroundColor = kAppColorBackground;
//    backView.alpha = 1.0;
//    [tabBar.tabBar insertSubview:backView atIndex:0];
//    tabBar.tabBar.opaque = YES;
    //隐藏导航栏
    //    tabBar.fd_prefersNavigationBarHidden = true;
    //禁止滑动返回
    //    tabBar.fd_interactivePopDisabled = true;
}

// 设置一个C函数，用来接收崩溃信息
void UncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    Log(@"****************** symbols ******************\n%@,\n****************** reason ******************\n%@,\n****************** name ******************\n%@",symbols,reason,name);
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
- (void)initRegisterNotification:(UIApplication *)application
{
    //推送的形式：标记，声音，提示
//    if(IOS8){
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }else{
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//    }
    application.applicationIconBadgeNumber = 0;
    
}

- (void)setupKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    //点击屏幕隐藏键盘
    manager.shouldResignOnTouchOutside = YES;
    //
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //为键盘添加工具栏
    manager.enableAutoToolbar = NO;
    //键盘覆盖输入框时候页面自动上移
    manager.keyboardDistanceFromTextField = 100;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    PostNotificationWithName(kNotificationApplicationDidBecomeActive);
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //登录控制
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *account = [df objectForKey:accountKey];
    NSString *password = [df objectForKey:passwordKey];
    BOOL isRememberThePassword = [[NSUserDefaults standardUserDefaults] boolForKey:rememberThePasswordKey];
    BOOL isOnTheLoginViewContrl = [[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController];
    BOOL canLogin = account.length > 0;// && password.length > 0;
    
    if (isOnTheLoginViewContrl) {
        if (isRememberThePassword && canLogin) {
            [[SYAppConfig shared] loginWithAccount:account password:password];
        }
    } else {
        if (isRememberThePassword && canLogin) {
             [[SYAppConfig shared] loginWithAccount:account password:password];
        }
    }
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController]) {
//        //验证密码是否在其它客户端修改
//        if (account.length > 0 && password.length > 0) {
//
//        }
//    }
//    else{
//        [[SYAppConfig shared] gotoLoginViewController];
//    }
//
    //记住密码，自动登录
//    if (isRememberThePassword) {
//        [self loginWithAccount:account password:password];
//        //版本检测更新
//        [self checkAppUpdate];
//        //        if (account.length > 0 && password.length > 0) {
//        //            [self loginWithAccount:account password:password];
//        //            //版本检测更新
//        //            [self checkAppUpdate];
//        //        } else {
//        //            [self checkAppUpdate];
//        //            self.me = nil;
//        //        }
//    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
