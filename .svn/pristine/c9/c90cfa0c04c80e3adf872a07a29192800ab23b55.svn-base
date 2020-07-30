//
//  SYServiceAddressMapViewController.m
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYServiceAddressMapViewController.h"
#import "SYServiceAddressMapBackView.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface SYServiceAddressMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,SYServiceAddressMapBackViewDelegate,SYAppConfigDelegate>
@property (nonatomic,strong) SYServiceAddressMapBackView *serviceAddressMapBackView;
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *searchAddress;
@property (nonatomic,strong) CLPlacemark *placeMark;

@end

@implementation SYServiceAddressMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ObserveNotification(kNotificationSearchAddressAction, @selector(searchAddressWithKeyWord:));
    ObserveNotification(kNotificationSearchLocations, @selector(searchNewLocations:));
    [SYAppConfig shared].delegate = self;
    [[SYAppConfig shared] startLocation];
    [self configMapView];
    
    if (!isNull([SYAppConfig shared].me.locationAddress)) {
        //发起地理编码查询
        [[SYAppConfig shared] searchAddressWithString:[SYAppConfig shared].me.locationAddress];
    }
    
    [self bindData];
    [self loadData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view hideHUD];
//    [[SYAppConfig shared] stopLocation];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - addViews
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"服务地点";//
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = NO;
    [self.moreBtn setTitle:Localized(@"确定") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [weakself sureAddress];
    };
    
    [self.view addSubview:self.serviceAddressMapBackView];
    [self.serviceAddressMapBackView.mapBgView addSubview:self.mapView];
}
#pragma mark - bindData
- (void)configMapView{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
}

- (void)bindData {
    
}

- (void)sureAddress{
    [self.view endEditing:YES];
    [self.serviceAddressMapBackView endEditing:YES];
    
    if (isNull(self.serviceAddressMapBackView.searchBar.text)) {
        [self.view showHUDForError:Localized(@"请输入地址")];
        return;
    }
    
//    if (isNull(self.serviceAddressMapBackView.detailAddressTextFeild.text)) {
//        [self.view showHUDForError:Localized(@"请输入详细地址")];
//        return;
//    }
    
    NSString *detailAddress = self.serviceAddressMapBackView.detailAddressTextFeild.text;
    [SYAppConfig shared].me.detailAddress = detailAddress;
    [SYAppConfig shared].me.address = self.serviceAddressMapBackView.searchBar.text;
    [SYAppConfig shared].me.locationAddress = self.serviceAddressMapBackView.searchBar.text;
    if (self.placeMark.location) {
        [SYAppConfig shared].me.changeLocation = self.placeMark.location;
    }
    PostNotificationWithName(kNotificationSYServiceAddressMapViewControllerSelectedAddressAction);
    PostNotificationWithName(kNotificationOrdersViewControllerRefresh);
    PostNotificationWithName(kNotificationHomeViewControllerLoadData);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - loadData
- (void)loadData{
    
}

#pragma mark - business
- (void)searchAddressWithKeyWord:(NSNotification *)noty{
    NSString *keyWord = (NSString *)noty.object;
    [[SYAppConfig shared] searchAddressWithString:keyWord];
}

- (void)searchNewLocations:(NSNotification *)noty{
    self.dataArray = (NSMutableArray *)noty.object;
    NSMutableArray *addressInfoArr = [NSMutableArray array];
    for (NSMutableDictionary *mutDic in self.dataArray) {
        [addressInfoArr addObject:[mutDic objectForKey:@"addressInfoDic"]];
    }
    self.serviceAddressMapBackView.dataArray = addressInfoArr;
    [self.serviceAddressMapBackView.tableView reloadData];
}

- (void)addPointAnnotationAMapGeocode:(NSMutableArray *)pointAnnotationArray{
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (MAPointAnnotation *pointAnnotation in pointAnnotationArray) {
        [self.mapView addAnnotation:pointAnnotation];
    }
    
    MAPointAnnotation *ann = [pointAnnotationArray lastObject];
    self.mapView.centerCoordinate = ann.coordinate;
}

#pragma mark SYAppConfigDelegate
- (void)addPointAnnotationWithMapGeocode:(NSMutableArray *)pointAnnotationArray{
    [self addPointAnnotationAMapGeocode:pointAnnotationArray];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark SYServiceAddressMapBackViewDelegate
- (void)selectedAddressAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableDictionary *mutDic = [self.dataArray objectAtIndex:indexPath.row];
    if (!isNullDictionary(mutDic)) {
        MAPointAnnotation *pointAnnotation = [mutDic objectForKey:@"pointAnnotation"];
        [self addPointAnnotationAMapGeocode:[NSMutableArray arrayWithObject:pointAnnotation]];
        self.placeMark = mutDic[@"placeMark"];
    }
}

#pragma mark - collection


#pragma mark - Get
- (SYServiceAddressMapBackView *)serviceAddressMapBackView{
    if (!_serviceAddressMapBackView) {
        _serviceAddressMapBackView = [[[NSBundle mainBundle] loadNibNamed:@"SYServiceAddressMapBackView" owner:nil options:nil] objectAtIndex:0];
        _serviceAddressMapBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _serviceAddressMapBackView.dataArray = self.dataArray;
        if (self.dataArray.count > 10) {
            _serviceAddressMapBackView.dataArray = [NSMutableArray arrayWithArray:[self.dataArray subarrayWithRange:NSMakeRange(0, 10)]];
        }
        _serviceAddressMapBackView.delegate = self;
        _serviceAddressMapBackView.searchBar.text = [SYAppConfig shared].me.locationAddress;
    }
    return _serviceAddressMapBackView;
}

- (MAMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth + 100, 200)];
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
         //YES：显示室内地图；NO：不显示；
//        _mapView.showsIndoorMap = YES;
    }
    return _mapView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
