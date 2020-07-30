//
//  SYAppConfig.h
//  PartsMall
//
//  Created by Jim on 16/9/12.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserMode.h"
#import "LoginViewController.h"
#import "SYNearbyOrderMode.h"
#import "OrdersCell.h"
//#import "JYUpdateDaemon.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchKit.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(id error);

@protocol SYAppConfigDelegate <NSObject>

- (void)addPointAnnotationWithMapGeocode:(NSMutableArray *)pointAnnotationArray;

@end

@interface SYAppConfig : NSObject<CLLocationManagerDelegate,AMapSearchDelegate>

@property (nonatomic, strong) JYUserMode *me;
@property (nonatomic,strong) LoginViewController *loginVC;

//@property (nonatomic, strong) JYUpdateDaemon *updateDaemon;
@property (nonatomic, copy) void(^goToLoginBlock)();
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapGeocodeSearchRequest *geo;
@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) NSMutableArray *locationsArray;
@property (nonatomic,strong) NSMutableArray *pointAnnotationArray;//大头针

@property (nonatomic,weak) id<SYAppConfigDelegate> delegate;


+ (instancetype)shared;
- (void)setup;
- (void)requestUserInfo;
- (void)getUserTempUid;

- (void)dissMissLoginControllerAndBackToHome;
- (void)gotoHomeViewController;
- (void)gotoLoginViewController;//跳转到登录界面
- (void)gotoMessageViewControllerWithUserInfo:(NSDictionary *)userInfo;//跳转到消息界面
- (void)loginWithAccount:(NSString *)account password:(NSString *)password;//登录
- (void)logout;//退出登录
- (void)startServiceTimeWithOrder:(SYNearbyOrderMode *)nearbyMode withSuperViewController:(UIViewController *)superVC;//服务计时开始
- (void)setupForRequestErrorHandle;//登录互踢

- (void)requestAudioTransferKey:(NSString *)key result:(void (^)(NSString* audioToken))resultBlock;

- (void)startLocation;
- (void)stopLocation;
- (BOOL)isOpenLocationService;
- (void)tipsOpenLocation;
- (void)searchAddressWithString:(NSString *)searchString;
- (void)loadTheUnionStateWithSuccessBlock:(successBlock)success failureBlock:(failureBlock)failure;

@end

