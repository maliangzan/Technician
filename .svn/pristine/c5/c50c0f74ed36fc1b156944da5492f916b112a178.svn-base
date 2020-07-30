////
////  testObject.m
////  Technician
////
////  Created by 马良赞 on 17/3/15.
////  Copyright © 2017年 马良赞. All rights reserved.
////
//
//#import "testObject.h"
//
//@implementation testObject
//
//@end
////
////  FindViewController.m
////  Technician
////
////  Created by 马良赞 on 16/12/26.
////  Copyright © 2016年 马良赞. All rights reserved.
////
//
//#import "FindViewController.h"
//#import <CoreBluetooth/CoreBluetooth.h>
//#import "BabyBluetooth.h"
//#import "SVProgressHUD.h"
//#import "AdvertisingColumn.h"
//
//#define channelOnPeropheralView @"peripheralView"
//#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
//#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
//static float AD_height = 150;//广告栏高度
//
//@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
//{
//    NSMutableArray *peripheralDataArray;
//    BabyBluetooth *baby;
//    AdvertisingColumn *_headerView; //广告栏
//    NSMutableArray *_cellArray;     //collectionView数据
//}
//@property(nonatomic , strong)UIButton *deviceBtn;
//@property(nonatomic , strong)UIImageView *imageView;
//@property(nonatomic , strong)UITableView *tableView;
//@property (nonatomic, strong) UICollectionView *collectionView;
//@end
//
//@implementation FindViewController
//
//#pragma mark - 创建collectionView并设置代理
//- (UICollectionView *)collectionView
//{
//    if (!_collectionView) {
//        
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        
//        //        flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部大小
//        
//        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        
//        //定义每个UICollectionView 的大小
//        flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/3, (fDeviceWidth-20)/3+50);
//        //定义每个UICollectionView 横向的间距
//        flowLayout.minimumLineSpacing = 5;
//        //定义每个UICollectionView 纵向的间距
//        flowLayout.minimumInteritemSpacing = 0;
//        //定义每个UICollectionView 的边距距
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
//        
//        //注册cell和ReusableView（相当于头部）
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
//        
//        //设置代理
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        
//        //背景颜色
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        //自适应大小
//        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        
//    }
//    return _collectionView;
//}
//#pragma mark - 定时滚动scrollView
//-(void)viewDidAppear:(BOOL)animated {//显示窗口
//    [super viewDidAppear:animated];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_headerView openTimer];//开启定时器
//    });
//}
//-(void)viewWillDisappear:(BOOL)animated {//将要隐藏窗口
//    [super viewWillDisappear:animated];
//    if (_headerView.totalNum>1) {
//        [_headerView closeTimer];//关闭定时器
//    }
//}
//#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [_headerView closeTimer];//关闭定时器
//}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    if (_headerView.totalNum>1) {
//        [_headerView openTimer];//开启定时器
//    }
//}
//
//#pragma mark - UICollectionView delegate dataSource
//#pragma mark 定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//#pragma mark 定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//#pragma mark 每个UICollectionView展示的内容
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"cell";
//    // 从队列中取出一个Cell
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//    return cell;
//}
//
//#pragma mark 头部显示的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
//                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
//    
//    [headerView addSubview:_headerView];//头部广告栏
//    return headerView;
//}
//
//#pragma mark UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"选择%ld",indexPath.item);
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    //    [SVProgressHUD showInfoWithStatus:@"准备打开设备"];
//    //    NSLog(@"viewDidLoad");
//    //    peripheralDataArray = [[NSMutableArray alloc]init];
//    //
//    //    //初始化BabyBluetooth 蓝牙库
//    //    baby = [BabyBluetooth shareBabyBluetooth];
//    //    //设置蓝牙委托
//    //    [self babyDelegate];
//    
//    
//}
////-(void)viewDidAppear:(BOOL)animated{
////    NSLog(@"viewDidAppear");
////    //停止之前的连接
//////    [baby cancelAllPeripheralsConnection];
//////    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
//////    baby.scanForPeripherals().begin();
////    //baby.scanForPeripherals().begin().stop(10);
////}
//
//#pragma mark -蓝牙配置和操作
////蓝牙网关初始化和委托方法设置
//-(void)babyDelegate{
//    
//    __weak typeof(self) weakSelf = self;
//    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
//        if (central.state == CBCentralManagerStatePoweredOn) {
//            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
//        }
//    }];
//    
//    //设置扫描到设备的委托
//    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
//        NSLog(@"搜索到了设备:%@",peripheral.name);
//        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
//    }];
//    
//    
//    //设置发现设service的Characteristics的委托
//    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
//        NSLog(@"===service name:%@",service.UUID);
//        for (CBCharacteristic *c in service.characteristics) {
//            NSLog(@"charateristic name is :%@",c.UUID);
//        }
//    }];
//    
//    //设置读取characteristics的委托
//    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
//        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
//    }];
//    //设置发现characteristics的descriptors的委托
//    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
//        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
//        for (CBDescriptor *d in characteristic.descriptors) {
//            NSLog(@"CBDescriptor name is :%@",d.UUID);
//        }
//    }];
//    //设置读取Descriptor的委托
//    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
//        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
//    }];
//    
//    //设置查找设备的过滤器
//    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
//        
//        //最常用的场景是查找某一个前缀开头的设备
//        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
//        //            return YES;
//        //        }
//        //        return NO;
//        
//        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
//        if (peripheralName.length >0) {
//            return YES;
//        }
//        return NO;
//    }];
//    
//    
//    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
//        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
//    }];
//    
//    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
//        NSLog(@"setBlockOnCancelScanBlock");
//    }];
//    
//    
//    /*设置babyOptions
//     
//     参数分别使用在下面这几个地方，若不使用参数则传nil
//     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
//     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
//     - [peripheral discoverServices:discoverWithServices];
//     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
//     
//     该方法支持channel版本:
//     [baby setBabyOptionsAtChannel:<#(NSString *)#> scanForPeripheralsWithOptions:<#(NSDictionary *)#> connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:<#(NSArray *)#>]
//     */
//    
//    //示例:
//    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
//    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
//    //连接设备->
//    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
//    
//}
//#pragma mark -UIViewController 方法
////插入table数据
//-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
//    
//    NSArray *peripherals = [peripheralDataArray valueForKey:@"peripheral"];
//    if(![peripherals containsObject:peripheral]) {
//        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
//        [indexPaths addObject:indexPath];
//        
//        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
//        [item setValue:peripheral forKey:@"peripheral"];
//        [item setValue:RSSI forKey:@"RSSI"];
//        [item setValue:advertisementData forKey:@"advertisementData"];
//        [peripheralDataArray addObject:item];
//        
//        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//-(UIButton *)deviceBtn{
//    if (!_deviceBtn) {
//        _deviceBtn = [[UIButton alloc]init];
//        [_deviceBtn setBackgroundColor:getColor(@"1cc6a2")];
//        _deviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _deviceBtn.titleLabel.font = [UIFont systemFontOfSize:13*kWidthFactor];
//        [_deviceBtn setTitle:@"      我的设备" forState:UIControlStateNormal];
//        [_deviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    return _deviceBtn;
//}
//-(UIImageView *)imageView{
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc]init];
//        _imageView.image = [UIImage imageNamed:@"find_Image"];
//    }
//    return _imageView;
//}
//-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]init];
//    }
//    return _tableView;
//}
//-(void)buildUI{
//    [super buildUI];
//    self.backBtn.hidden = YES;
//    self.titleLabel.text = @"发现";
//    [self.view addSubview:self.deviceBtn];
//    [self.deviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(65*kWidthFactor);
//        make.height.mas_equalTo(37*kHeightFactor);
//    }];
//    
//    [self.view addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.deviceBtn.mas_bottom).offset(0);;
//        make.bottom.equalTo(self.view);
//    }];
//    
//    
//    
//    //    [self.view addSubview:self.imageView];
//    //    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.left.equalTo(self.view);
//    //        make.right.equalTo(self.view);
//    //        make.top.equalTo(self.deviceBtn.mas_bottom).offset(0*kWidthFactor);
//    //        make.height.mas_equalTo(160*kHeightFactor);
//    //    }];
//    
//    //    [self.view addSubview:self.tableView];
//    //    self.tableView.delegate = self;
//    //    self.tableView.dataSource = self;
//    //    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.left.equalTo(self.view);
//    //        make.right.equalTo(self.view);
//    //        make.top.equalTo(self.view).offset(65*kWidthFactor);
//    //        make.bottom.equalTo(self.view);
//    //    }];
//}
//#pragma mark -table委托 table delegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return peripheralDataArray.count;
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
//    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
//    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
//    NSDictionary *advertisementData = [item objectForKey:@"advertisementData"];
//    NSNumber *RSSI = [item objectForKey:@"RSSI"];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
//    NSString *peripheralName;
//    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
//        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
//    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
//        peripheralName = peripheral.name;
//    }else{
//        peripheralName = [peripheral.identifier UUIDString];
//    }
//    
//    cell.textLabel.text = peripheralName;
//    //信号和服务
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",RSSI];
//    
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //停止扫描
//    [baby cancelScan];
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
//    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
//    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
//    
//    //连接指定的蓝牙
//    baby.having(peripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
//    
//    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
//    [baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
//    }];
//    
//    //设置设备连接失败的委托
//    [baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
//        NSLog(@"设备：%@--连接失败",peripheral.name);
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
//    }];
//    
//    //设置设备断开连接的委托
//    [baby setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
//        NSLog(@"设备：%@--断开连接",peripheral.name);
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
//    }];
//    //    PeripheralViewController *vc = [[PeripheralViewController alloc]init];
//    //    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
//    //    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
//    //    vc.currPeripheral = peripheral;
//    //    vc->baby = self->baby;
//    //    [self.navigationController pushViewController:vc animated:YES];
//    
//}
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
