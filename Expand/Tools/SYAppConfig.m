//
//  SYAppConfig.m
//  PartsMall
//
//  Created by Jim on 16/9/12.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import "SYAppConfig.h"
#import "JYUserMode.h"
#import "JYRequestHelper.h"
#import "LoginViewController.h"
#import "JYLoginApi.h"
#import "SYUserLogoutApi.h"
#import <YTKNetworkConfig.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SYOrderMode.h"
#import "SYStartServiceApi.h"
#import "ServiceTimeViewController.h"
#import "SYUnionStateApi.h"
#import "NewsViewController.h"
//#import <YTKBaseRequest.h>

#define DEFAULT_LATITUDE 0.000000
#define DEFAULT_LONGITUDE 0.000000

@implementation SYAppConfig
+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)setup {
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = URL_HTTP_Base;
    
    [self getUserTempUid];
    //开始定位
    if ([self isOpenLocationService]) {
        [self startLocation];
    }
    
    // 读取沙盒的账号 密码  并自动登录
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *account = [df objectForKey:accountKey];
    NSString *password = [df objectForKey:passwordKey];
    self.me.loginName = account;
    self.me.password = password;
    
//    BOOL isRememberThePassword = [[NSUserDefaults standardUserDefaults] boolForKey:rememberThePasswordKey];
//    //记住密码，自动登录
//    if (isRememberThePassword) {
//        [self loginWithAccount:account password:password];
//        //版本检测更新
//        [self checkAppUpdate];
////        if (account.length > 0 && password.length > 0) {
////            [self loginWithAccount:account password:password];
////            //版本检测更新
////            [self checkAppUpdate];
////        } else {
////            [self checkAppUpdate];
////            self.me = nil;
////        }
//    }
    
    
}

- (void)checkAppUpdate {
//    [self.updateDaemon pullUpdateInfo];
}

- (void)setupForDatabase {
    
}

/**登录*/
- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController]) {
        [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"登录中")];
    } else {
        BOOL isRemenberPassWord = [[NSUserDefaults standardUserDefaults] boolForKey:rememberThePasswordKey];
        if (isRemenberPassWord) {
            [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"自动登录中")];
        } else {
            [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"重新登录中")];

        }
    }
    
    WeakSelf;
    [[[JYLoginApi alloc] initWithAccount:account password:password]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
             [df setObject:account forKey:accountKey];
             [df setObject:password forKey:passwordKey];
             [df synchronize];
             JYUserMode *user = [JYUserMode fromJSONDictionary:request.responseObject[@"data"]];
             user.hasLogin = YES;
             //为了订单有数据，改ID，正式删除这行******************************
//             user.userID = @(3);
             if (weakself.me) {
                 user.currentLocation = weakself.me.currentLocation;
                 user.locationAddress = weakself.me.locationAddress;
             }else{
                 user.currentLocation = [[CLLocation alloc] initWithLatitude:DEFAULT_LATITUDE longitude:DEFAULT_LONGITUDE];
                 user.locationAddress = Localized(@"定位中...");
             }
             
             weakself.me = user;
             
             [JPUSHService setTags:nil aliasInbackground:weakself.me.loginName];
             [[JYRequestHelper shared] setupWithUser:weakself.me];
             [weakself loginSuccessWithUser:weakself.me]; 
             [weakself dissMissLoginControllerAndBackToHome];
             PostNotificationWithName(kNotificationLoginSuccess);
         }
//         else if ([request isCommonErrorAndHandle]) {
//             [weakself gotoLoginViewController];
//             weakself.me = nil;
//             return ;
//         }
         
         else {
             if ([[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController]) {
                  [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
             } else {
                 [[SYAlertView(Localized(@"提示"), Localized(@"密码已修改，请重新登录！"),Localized( @"确定")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
                     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:passwordKey];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     [weakself gotoLoginViewController];
                     weakself.me = nil;
                 }] show];
             }
         }
     } failure:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"登录失败，连接不到服务器")];
         [weakself gotoLoginViewController];
         weakself.me = nil;
     }];
}

- (void)loginSuccessWithUser:(JYUserMode *)user {
    //记录账户密码
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:user.loginName forKey:accountKey];
    [df setObject:user.password forKey:passwordKey];
    [df synchronize];
    
    [[SYAppConfig shared] requestUserInfo];
    [self setupForLogin];
    PostNotificationWithName(kNotificationHomeViewControllerLoadData);
}

- (void)dissMissLoginControllerAndBackToHome{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isOnTheLoginViewController];
    [self.loginVC.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupForLogin {
    [[SYAppConfig shared] setupForRequestErrorHandle];
}

- (void)logout {
    
    /**退出登录Tina*/
    WeakSelf;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:passwordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"")];
    [[[SYUserLogoutApi alloc] init] startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        if ([request isSuccess]) {
            [weakself stopLocation];
            weakself.me.hasLogin = NO;
            weakself.me = nil;
            [[JYRequestHelper shared] logout];
            [weakself gotoLoginViewController];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"loginStatu"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:rememberThePasswordKey];

            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else{
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"退出失败")];
            weakself.me = nil;
            [weakself gotoLoginViewController];
        }
        
    } failure:^(YTKBaseRequest *request) {
        weakself.me = nil;
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"退出失败，连接不到服务器！")];
        [weakself gotoLoginViewController];
    }];

}

- (void)gotoLoginViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UITabBarController *rootCtrl = (UITabBarController *)app.window.rootViewController;
    
    [rootCtrl setSelectedIndex:0];
    UINavigationController *selectedNav = (UINavigationController *)[rootCtrl selectedViewController];
    [selectedNav popToRootViewControllerAnimated:YES];
    
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
    self.loginVC.navigationController.navigationBarHidden = YES;
    [selectedNav presentViewController:loginNav animated:NO completion:nil];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isOnTheLoginViewController];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)gotoMessageViewControllerWithUserInfo:(NSDictionary *)userInfo{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UITabBarController *rootCtrl = (UITabBarController *)app.window.rootViewController;
    
    [rootCtrl setSelectedIndex:0];
    UINavigationController *selectedNav = (UINavigationController *)[rootCtrl selectedViewController];
    [selectedNav popToRootViewControllerAnimated:YES];
    
    NewsViewController *newsVC = [[NewsViewController alloc] initWithUserInfo:userInfo isNoticeMessage:YES];
    newsVC.hidesBottomBarWhenPushed = YES;
    
    [selectedNav pushViewController:newsVC animated:YES];
}

- (void)gotoHomeViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *rootCtrl = (UITabBarController *)app.window.rootViewController;
    rootCtrl.tabBar.hidden = NO;
    [rootCtrl setSelectedIndex:0];
}

//服务计时开始
- (void)startServiceTimeWithOrder:(SYNearbyOrderMode *)nearbyMode withSuperViewController:(UIViewController *)superVC{
    SYOrderMode *order = [SYOrderMode fromJSONDictionary:nearbyMode.order];
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/setBeginTime?id=%@&tid=%@",
                        URL_HTTP_Base_Get,
                        order.orderID,//oid
                        [SYAppConfig shared].me.userID
                        ];
    
    __weak __typeof__(superVC) weakself = superVC;
    [superVC.view showHUDWithMessage:Localized(@"")];
    SYStartServiceApi *api = [[SYStartServiceApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [superVC.view hideHUD];
        [weakself.view hideHUD];
        NSInteger successStart = [request.responseObject[@"code"] integerValue];
        if (successStart == 0) {
            [weakself.view showHUDForSuccess:Localized(@"已开始！")];
            ServiceTimeViewController *serviceTimeVC = [[ServiceTimeViewController alloc] initWithMode:nearbyMode];
            [weakself.navigationController pushViewController:serviceTimeVC animated:YES];
            PostNotificationWithName(kNotificationOrderListBaseViewControllerRefresh);
        } else if (successStart == 1) {
            [weakself.view showHUDForError:request.responseObject[@"message"]];
        }else if (successStart == 2){
            [weakself.view showHUDForError:Localized(@"订单状态错误")];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [superVC.view hideHUD];
        [superVC.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)loadTheUnionStateWithSuccessBlock:(successBlock)success failureBlock:(failureBlock)failure{
    if (![SYAppConfig shared].me.userID) {
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController]) {
        [[UIApplication sharedApplication].keyWindow showHUDWithMessage:@""];
    }
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsTechnician/getStateEvaluation?id=%@",URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID
                        ];
    SYUnionStateApi *api = [[SYUnionStateApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [SYAppConfig shared].me.stateEvaluation = request.responseObject[@"data"][@"stateEvaluation"];
        if ([[SYAppConfig shared].me.stateEvaluation isEqualToString:@"ytg"]) {//审核通过
            [SYAppConfig shared].me.hasJoinIn = YES;
        } else if ([[SYAppConfig shared].me.stateEvaluation isEqualToString:@"dsh"]) {//待审核
            [SYAppConfig shared].me.hasJoinIn = YES;
        }else if ([[SYAppConfig shared].me.stateEvaluation isEqualToString:@"ydj"]) {//已冻结
            [SYAppConfig shared].me.hasJoinIn = NO;
        }else if ([[SYAppConfig shared].me.stateEvaluation isEqualToString:@"shbtg"]) {//审核不通过
            [SYAppConfig shared].me.hasJoinIn = NO;
        }else{
            [SYAppConfig shared].me.hasJoinIn = NO;
        }
        success(request.responseObject);
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:isOnTheLoginViewController]) {
            [[UIApplication sharedApplication].keyWindow showHUDForError:@"获取审核状态失败，请检查网络设置。"];
        }
        failure(request.error);
        NSLog(@"%@", request.error);
    }];
}

#pragma mark - getUserInfo
- (void)requestUserInfo {

}

- (void)updateMeWithUser:(JYUserMode *)user {
    user.loginName = self.me.loginName;
    user.password = self.me.password;

}

#pragma mark - 同步数据
- (void)getUserTempUid {

}

#pragma mark - 错误处理
- (void)setupForRequestErrorHandle {
    [JYRequestHelper shared].userNomatch = ^() {
        
    };
    
    [JYRequestHelper shared].userTimeout = ^() {
        
    };
    
    [JYRequestHelper shared].userNotFound = ^() {
       
    };
    [JYRequestHelper shared].userRemoveFromComapny = ^(){
      
    };
}

- (void)logoutAction{
    [[JYRequestHelper shared] logout];
}


#pragma mark 地图
- (void)startLocation{
    self.mapView;
    //开始定位
    [self.locationManager startUpdatingLocation];
    //设置逆地理编码查询参数
    [self setSearchLocation];
}

- (void)stopLocation{
    [self.locationManager stopUpdatingLocation];
}

- (void)searchAddressWithString:(NSString *)searchString{
//    //设置地理编码查询参数
//    //地理编码，请求参数类为 AMapGeocodeSearchRequest，address是必设参数
//    self.geo.address = searchString;
//    //发起地理编码查询
//    [self.search AMapGeocodeSearch:self.geo];
    
    [self geocoderWithSting:searchString];
}

-(void)geocoderWithSting:(NSString *)searAddress
{
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    WeakSelf;
    [coder geocodeAddressString:searAddress completionHandler:^(NSArray *placemarks, NSError * _Nullable error) {
        //解析response获取地理信息
        [weakself.locationsArray removeAllObjects];
        [weakself.pointAnnotationArray removeAllObjects];
        for (CLPlacemark *placeMark in placemarks) {
            
            //获取位置信息
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
            NSString *administrativeArea = isNull(placeMark.administrativeArea) == YES ? @"":placeMark.administrativeArea;
            NSString *subLocality = isNull(placeMark.subLocality) == YES ? @"":placeMark.subLocality;
            NSString *locality = isNull(placeMark.locality) == YES ? @"":placeMark.locality;
            NSString *thoroughfare = isNull(placeMark.thoroughfare) == YES ? @"":placeMark.thoroughfare;

            NSString *title = [NSString stringWithFormat:@"%@%@%@%@",administrativeArea,subLocality,locality,thoroughfare];
            NSString *name = isNull(placeMark.name) == YES ? @"":placeMark.name;
            [mutDic setObject:title forKey:@"title"];
            [mutDic setObject:name forKey:@"subtitle"];
            
            //添加大头针
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(placeMark.location.coordinate.latitude, placeMark.location.coordinate.longitude);
            pointAnnotation.title = title;
            pointAnnotation.subtitle = placeMark.name;
            [weakself.pointAnnotationArray addObject:pointAnnotation];
            
            NSMutableDictionary *addressInfoDic = [NSMutableDictionary dictionary];
            [addressInfoDic setObject:mutDic forKey:@"addressInfoDic"];
            [addressInfoDic setObject:pointAnnotation forKey:@"pointAnnotation"];
            [addressInfoDic setObject:placeMark forKey:@"placeMark"];
            [weakself.locationsArray addObject:addressInfoDic];
        }
        
        [weakself.delegate addPointAnnotationWithMapGeocode:weakself.pointAnnotationArray];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSearchLocations object:self.locationsArray];
  
       
    }];
}

#pragma mark AMapSearchDelegate
/* 逆地理编码回调.
 当逆地理编码成功时，会进到 onReGeocodeSearchDone 回调函数中，通过解析 AMapReGeocodeSearchResponse 获取这个点的地址信息（包括：标准化的地址、附近的POI、面区域 AOI、道路 Road等）。
 1）可以在回调中解析 response，获取地址信息。
 2）通过 response.regeocode 可以获取到逆地理编码对象 AMapReGeocode。
 3）通过 AMapReGeocode.formattedAddress 返回标准化的地址，AMapReGeocode.addressComponent 返回地址组成要素，包括：省名称、市名称、区县名称、乡镇街道等。
 4）AMapReGeocode.roads 返回地理位置周边的道路信息。
 5）AMapReGeocode.pois 返回地理位置周边的POI（大型建筑物，方便定位）。
 6）AMapReGeocode.aois 返回地理位置所在的AOI（兴趣区域）。
 
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述
        AMapReGeocode *reGeocode = response.regeocode;
        
        if ([SYAppConfig shared].me.currentLocation.coordinate.latitude == DEFAULT_LATITUDE || [SYAppConfig shared].me.currentLocation.coordinate.longitude == DEFAULT_LONGITUDE) {
            [SYAppConfig shared].me.locationAddress = Localized(@"定位中...");
        }else{
            [SYAppConfig shared].me.locationAddress = (isNull(reGeocode.formattedAddress) == YES ? @"" : reGeocode.formattedAddress);
        }
        
        PostNotificationWithName(kNotificationUpdateLocations);
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    //    [self.view showHUDForError:@"AMapSearchRequestdidFail"];
    NSLog(@"Error: %@", error);
}

#pragma mark AMapSearchDelegate
/*在回调中处理数据
 
 当地理编码查询成功时，会进到 onGeocodeSearchDone 回调函数中，通过解析 AMapGeocodeSearchResponse 把检索结果在地图上绘制点展示出来。
 说明：
 1）可以在回调中解析 response，获取地址对应的地理信息。
 2）通过 response.geocodes 可以获取到 AMapGeocode 列表，POI 详细信息可参考 AMapGeocode 类。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    //解析response获取地理信息
//    [self.locationsArray removeAllObjects];
//    for (AMapGeocode *mapGeocode in response.geocodes) {
//        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
//        [mutDic setObject:mapGeocode.formattedAddress forKey:@"title"];
//        [mutDic setObject:mapGeocode.township forKey:@"subtitle"];
//        
//        [self.locationsArray addObject:mutDic];
////        //添加大头针
//        [self.delegate addPointAnnotationWithMapGeocode:mapGeocode];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSearchLocations object:self.locationsArray];
}

#pragma mark CLLocationManagerDelegate
//点击允许
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"定位中....");
    CLLocation *location = [locations lastObject];
    [SYAppConfig shared].me.currentLocation = location;
    //设置逆地理编码查询参数
    [self setSearchLocation];
}

- (void)setSearchLocation{
    //进行逆地编码时，请求参数类为 AMapReGeocodeSearchRequest，location为必设参数。
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:[SYAppConfig shared].me.currentLocation.coordinate.latitude longitude:[SYAppConfig shared].me.currentLocation.coordinate.longitude];
    regeo.requireExtension = YES;
    //发起逆地理编码查询
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"授权状态改变");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    switch ([error code]) {
        case kCLErrorLocationUnknown:// 目前位置是未知的,但CL将继续努力  无法获取位置信息
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"无法获取位置信息")];
        }
            break;
        case kCLErrorDenied:// 获取用户位置或范围被拒绝   访问被拒绝
        {
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
//            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//                [self.locationManager requestAlwaysAuthorization];
//            }
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"访问被拒绝")];
        }
            break;
        case kCLErrorNetwork:// 一般情况下,网络相关的错误
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"网络相关的错误")];
        }
            break;
        case kCLErrorHeadingFailure:// 标题不能确定
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"错误未知")];
        }
            break;
        case kCLErrorRegionMonitoringDenied:// 位置区域监测被用户拒绝
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"位置区域监测被用户拒绝")];
        }
            break;
        case kCLErrorRegionMonitoringFailure:// 注册区域不能监控
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"注册区域不能监控")];
        }
            break;
        case kCLErrorRegionMonitoringSetupDelayed:// CL不能立即初始化区域监控
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"CL不能立即初始化区域监控")];
        }
            break;
        case kCLErrorRegionMonitoringResponseDelayed:// 如果这个防护事件被提交，提交将不会出现
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"如果这个防护事件被提交，提交将不会出现")];
        }
            break;
        case kCLErrorGeocodeFoundNoResult:// 地理编码没有结果
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"地理编码没有结果")];
        }
            break;
        case kCLErrorGeocodeFoundPartialResult:// 地理编码产生一部分结果
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"地理编码产生一部分结果")];
        }
            break;
        case kCLErrorGeocodeCanceled:// 地理编码被取消
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"地理编码被取消")];
        }
            break;
        case kCLErrorDeferredFailed:// 延迟模式失败
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"延迟模式失败")];
        }
            break;
        case kCLErrorDeferredNotUpdatingLocation:// 延迟模式失败了,因为位置更新禁用或暂停
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"延迟模式失败了,因为位置更新禁用或暂停")];
        }
            break;
        case kCLErrorDeferredAccuracyTooLow:// 延迟模式不支持当前精准度
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"延迟模式不支持当前精准度")];
        }
            break;
        case kCLErrorDeferredDistanceFiltered:// 延迟模式不支持距离过滤器
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"延迟模式不支持距离过滤器")];
        }
            break;
        case kCLErrorDeferredCanceled:// 延迟模式请求取消前一个请求
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"延迟模式请求取消前一个请求")];
        }
            break;
        case kCLErrorRangingUnavailable:// 测距杆不能执行
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"测距杆不能执行")];
        }
            break;
        case kCLErrorRangingFailure:// 测距失败
        {
            [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"测距失败")];
        }
            break;
            
        default:
            break;
    }
}

- (void)tipsOpenLocation{
    [[SYAlertViewTwo(Localized(@"定位服务未开启"), Localized(@"请进入系统［设置］> [隐私] > [定位服务]中打开开关，并允许使用定位服务"), Localized(@"取消"), Localized(@"立即开启")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }] show];
    
}

- (BOOL)isOpenLocationService
{
    BOOL isOPen = NO;
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        //定位功能可用
        isOPen = YES;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        isOPen = NO;
    }
    return isOPen;
}

- (void)openLocationService{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
}

#pragma mark - web socket & chat

#pragma mark - me
- (JYUserMode *)me {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _me = [[JYUserMode alloc] init];
    });

    return _me;
}


#pragma mark get
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
    }
    return _locationManager;
}

- (AMapSearchAPI *)search{
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (AMapGeocodeSearchRequest *)geo{
    if (!_geo) {
        _geo = [[AMapGeocodeSearchRequest alloc] init];
    }
    return _geo;
}

- (NSMutableArray *)locationsArray{
    if (!_locationsArray) {
        _locationsArray = [NSMutableArray array];
    }
    return _locationsArray;
}

- (NSMutableArray *)pointAnnotationArray{
    if (!_pointAnnotationArray) {
        _pointAnnotationArray = [NSMutableArray array];
    }
    return _pointAnnotationArray;
}

- (MAMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 250)];
//        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        //YES：显示室内地图；NO：不显示；
        //        _mapView.showsIndoorMap = YES;
    }
    return _mapView;
}

- (LoginViewController *)loginVC{
    if (!_loginVC) {
        _loginVC = [[LoginViewController alloc] init];
        _loginVC.navigationController.navigationBarHidden = YES;
    }
    return _loginVC;
}

@end
