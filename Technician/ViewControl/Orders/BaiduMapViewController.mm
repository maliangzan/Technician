//
//  BaiduMapViewController.m
//  Technician
//
//  Created by 马良赞 on 17/1/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaiduMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
@interface BaiduMapViewController ()<BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)BMKMapView *mapView;;
@property(nonatomic, strong)BMKLocationService *locService;
@property(nonatomic, strong)NSMutableArray *addressArr;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSMutableArray *)addressArr{
    if (!_addressArr) {
        _addressArr = [[NSMutableArray alloc]init];
    }
    return _addressArr;
}
-(BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]init];
    }
    return _mapView;
}
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"定位";
    self.moreBtn.hidden = NO;
    [self.moreBtn setTitle:@"开始" forState:UIControlStateNormal];
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.rightBtn =^{
        [weakSelf leftAction];
    };
    
    self.locService = [[BMKLocationService alloc]init];
    self.locService.delegate = self;
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.height.mas_equalTo(APP_Frame_Height/2);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.mapView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view);;
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
-(void)leftAction{
    [self.locService startUserLocationService];
    self.locService.delegate = self;
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
}

#pragma mark - BMKlocationService的代理方法
- (void)willStartLocatingUser
{
    NSLog(@"开始定位");
}
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"定位失败error:%@",error);
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [_mapView updateLocationData:userLocation];
    //  定义打头阵标注
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    // 设置标注的位置坐标
    annotation.coordinate = userLocation.location.coordinate;
    //
    annotation.title = @"光辉科技园";
    //添加到地图里
    [self.mapView addAnnotation:annotation];
    // 使地图显示该位置
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    //调用搜索
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc]init];
    search.delegate = self;
    BMKReverseGeoCodeOption *rever = [[BMKReverseGeoCodeOption alloc]init];
    rever.reverseGeoPoint = userLocation.location.coordinate;
    //这段代码不要删
    NSLog(@"%d",[search reverseGeoCode:rever]);
}
-(void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}
- (void)dealloc {
    if (self.mapView) {
        self.mapView = nil;
    }
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//    [_mapView removeOverlays:array];
    
    [self.addressArr removeAllObjects];
    for(BMKPoiInfo *poiInfo in result.poiList)
    {
        NSLog(@"========%@",poiInfo.address);
        [self.addressArr addObject:poiInfo.address];
    }
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.addressArr objectAtIndex:[indexPath row]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.addressArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0*kHeightFactor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
