//
//  SYConnectDeviceViewController.m
//  Technician
//
//  Created by TianQian on 2017/5/23.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYConnectDeviceViewController.h"
#import "SYImageLabelCell.h"
#import "SYBluetoothStaduesCell.h"
#import "SYCustomAlertView.h"
#import "SYConnectBluetoothApi.h"
#import "BabyBluetooth.h"
#import "SYTimeHelper.h"

#define SERVICE_UUID_W @"0xFFE5"
#define SERVICE_UUID_R @"0xFFE0"

#define CHARACTOR_UUID_W @"0xFFE9"
#define CHARACTOR_UUID_R @"0xFFE4"

//#define SERVICE_UUID_W_R @"0xFFE5"
//#define CHARACTOR_UUID_W_R @"0xFFE9"

#define channelOnSYView @"peripheralSYView"
#define kTimeBtnHeight 37*kHeightFactor

#define UnlockDevice @"$UL0000000&"

@interface SYConnectDeviceViewController ()<UITableViewDelegate,UITableViewDataSource,SYImageLabelCellDelegate>
@property (nonatomic,strong) UIButton *timeBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) SYCustomAlertView *customAlertView;
@property (nonatomic,strong) SYCustomAlertView *lockTipsView;
@property (nonatomic,strong) UIView *blackBackView;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) SYDeviceMode *deviceMode;
@property (nonatomic,copy) NSString *firstConnectTime;

@property (nonatomic,strong) BabyBluetooth *baby;
@property (nonatomic, strong) NSMutableArray *peripherals;//保存外设
@property (nonatomic, strong) CBPeripheral *currPeripheral;//当前的外设
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;//写数据特征
@property (nonatomic,strong) CBCharacteristic *reseviceCharacteristic;//读数据特征
@property (nonatomic,copy) NSString *reseviceData;//接收到的数据
@property (nonatomic,assign) BOOL isLink;//是否连接
@property (nonatomic,assign) BOOL isSearchToTheDevice;//是否搜索到指定设备


@end

static NSString *imageCellID = @"SYImageLabelCell";
static NSString *bluetoothCellID = @"SYBluetoothStaduesCell";
@implementation SYConnectDeviceViewController

- (instancetype)initWithDeviceMode:(SYDeviceMode *)deviceMode{
    if (self = [super init]) {
//        deviceMode.bluetoothName = @"SAYESPM08";
        self.deviceMode = deviceMode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindData];
    [self loadData];
    
    [self configBluetooth];
    [self scanPeripheral];
}


- (void)viewDidDisappear:(BOOL)animated
{
    //    [self disconnectTheBluetooth];
}



#pragma mark - addViews
#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = isNull(self.deviceMode.eqType) == YES ? @"" : self.deviceMode.eqType;
    WeakSelf;
    self.backBtn.hidden = NO;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.height.mas_equalTo(kTimeBtnHeight);
    }];
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - bindData
- (void)bindData {
    self.isLink = NO;
    self.isSearchToTheDevice = NO;
}

#pragma mark - loadData
- (void)loadData{
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsEquipmentConnectLog/queryList?eid=%@",
                        URL_HTTP_Base_Get,
                        self.deviceMode.deviceID
                        ];
    
    SYConnectBluetoothApi *api = [[SYConnectBluetoothApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *array = request.responseObject[@"data"];
        if (!isNullArray(array)) {
            weakself.firstConnectTime = [array firstObject][@"connectTime"];
            NSString *startStr = [NSString stringWithFormat:@"   开始时间：%@",isNull(weakself.firstConnectTime) == YES ? @"" : weakself.firstConnectTime];
            [_timeBtn setTitle:startStr forState:UIControlStateNormal];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

#pragma mark - business
- (void)immediatelyUnlock{
    [self sendDataToBlue:UnlockDevice];
}

- (void)configBluetooth{
    _isLink = NO;
    //初始化BabyBluetooth 蓝牙库
    self.baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态
}


- (void)showLockTipsView{
    [self.lockTipsView show];
    [self.view addSubview:self.blackBackView];
}

- (void)hiddenLockTipsView{
    [self.lockTipsView removeFromSuperview];
    [self.blackBackView removeFromSuperview];
}

#pragma mark 扫描设备
- (void)scanPeripheral{
    //    [self.peripherals removeAllObjects];
    //停止之前的连接
    [self.baby cancelAllPeripheralsConnection];
    //开始扫描
    [self.view showHUDWithMessage:Localized(@"  正在搜索蓝牙设备...  ")];
    self.baby.scanForPeripherals().begin().stop(10);
    
    //    延时提示框
    WeakSelf;
    double delayInSeconds = 10.0;
    dispatch_time_t delayInTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_after(delayInTime, concurrentQueue, ^{
        if (!weakself.isSearchToTheDevice) {
            [weakself.view hideHUD];
            [weakself showTipsView];
            //停止扫描
            [weakself.baby cancelScan];
        }
    });
}

#pragma mark 连接设备
- (void)connectPeripheral{
    [self.view showHUDWithMessage:Localized(@"正在连接蓝牙设备...")];
    self.baby.having(self.currPeripheral).and.channel(channelOnSYView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

//未搜索到设备提示view
- (void)showTipsView{
    [self.view addSubview:self.blackBackView];
    [self.customAlertView show];
}

//隐藏未搜索到设备提示view
- (void)hiddenTipsView{
    [self.customAlertView removeFromSuperview];
    [self.blackBackView removeFromSuperview];
}
#pragma mark 设置蓝牙委托 babyDelegate
-(void)babyDelegate{
    WeakSelf;
    //设置扫描到设备的委托
    [self.baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral);
        if (![weakself.peripherals containsObject:peripheral]) {
            [weakself.peripherals addObject:peripheral];
        }
    }];
    
    //过滤器
    //设置查找设备的过滤器
    [self.baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备 most common usage is discover for peripheral that name has common prefix
        NSLog(@"peripheralName = %@",peripheralName);
        //保存设备
        for (CBPeripheral *peripheral in weakself.peripherals) {
            if ( [peripheral.name isEqualToString:weakself.deviceMode.bluetoothName]) {
                weakself.currPeripheral = peripheral;
                //连接设备
                [weakself connectPeripheral];
                [weakself.view hideHUD];
                break;
            }
        }
        return YES;
        
        return NO;
    }];
    
    //连接成功
    [self.baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        [weakself.baby cancelScan];
        weakself.isLink = YES;
        weakself.isSearchToTheDevice = YES;
        [weakself.view hideHUD];
        [weakself.view showHUDForSuccess:Localized(@"设备连接成功")];
        [weakself.tableView reloadData];
    }];
    
    //连接Peripherals失败的
    [self.baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        //        PostNotificationWithName(kNotificationConnectBluetoothFailureForShapingApparatus);
        [weakself.view showHUDForError:Localized(@"设备连接失败")];
        weakself.isLink = NO;
        [weakself.tableView reloadData];
    }];
    
    //断开Peripherals的连接
    [self.baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"失去连接 Peripheral:%@", peripheral.name);
    }];
    
    //设备状态改变
    [self.baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBManagerStateUnknown){
            [weakself.view showHUDForError:Localized(@"状态未知!")];
        }else if (central.state == CBManagerStateResetting){
            [weakself.view showHUDForError:Localized(@"与系统连接服务暂时丢失!")];
        }else if (central.state == CBManagerStateUnsupported){
            [weakself.view showHUDForError:Localized(@"平台不支持蓝牙!")];
        }else if (central.state == CBManagerStateUnauthorized){
            [weakself.view showHUDForError:Localized(@"应用程序未被授权使用蓝牙低电量!")];
        }else if (central.state == CBManagerStatePoweredOff){//蓝牙关闭
            // 蓝牙断开连接
            [weakself disconnectTheBluetooth];
        }
        else if (central.state == CBManagerStatePoweredOn){
            //            [MBProgressHUD showSuccess:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    //设置查找服务
    [self.baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"didDiscoverServices:%@", peripheral.services);
        [weakself.baby cancelScan];
        // 遍历所有的服务
        for (CBService *service in peripheral.services) {
            // 过滤掉不想要的服务
            if ([service.UUID isEqual:[CBUUID UUIDWithString:SERVICE_UUID_R]]) {
                // 找到想要的服务"@"""
                
                // 扫描服务下面的特征
                //#warning 通过传入一个存放特征UDID的数组进去，过滤掉一些不要的特征
                [peripheral discoverCharacteristics:nil forService:service];
            }
            
            if ([service.UUID isEqual:[CBUUID UUIDWithString:SERVICE_UUID_W]]) {
                // 找到想要的服务"@"""
                
                // 扫描服务下面的特征
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    }];
    
    //设置查找到Characteristics
    [self.baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"didDiscoverCharacteristicsForService:%@", service.characteristics);
        // 遍历所有的特征
        for (CBCharacteristic *characteristic in service.characteristics) {
            // 过滤掉不想要的特征
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTOR_UUID_R]]) {
                // 找到想要的特征,读
                NSLog(@"----------------------找到特征");
                //            SYLog(@"0xFFF4 的特性已发现，下一步注册监听");
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTOR_UUID_W]]) {
                NSLog(@"----------------------找到特征");
                //写
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    NSLog(@"++++++++++++++++++++");
                    weakself.writeCharacteristic = characteristic;
                });
            }
        }
        
    }];
    //
    [self.baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
        //        [MBProgressHUD showSuccess:@"CancelAllPeripherals成功！"];
    }];
    
    [self.baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
        //        [MBProgressHUD showSuccess:@"CancelScan成功！"];
    }];
    //设置获取到最新Characteristics值
    [self.baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristic.UUID,characteristic.value);
        if (error)
        {
            //                    [weakself.view showHUDForError:[NSString stringWithFormat:@"手机连接设备出错%@",error.localizedDescription]];
            NSLog(@"手机连接设备出错: %@", error);
            return;
        }
        
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTOR_UUID_R]])
        {
#pragma mark 接收处理数据
            NSData *data = [NSData dataWithData:characteristic.value];
            
            weakself.reseviceData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"接收数据: %@", data);
            
            // 接收到蓝牙数据 先分析 再回传给代理 最后发送指令关机
            //                    [NSString stringWithCString:string encoding: NSASCIIStringEncoding];
            //                    NSString *test= [[NSString alloc] initWithUTF8String:string];
            weakself.currPeripheral = peripheral;
            
            [weakself GetDeviceData];
            
        }
    }];
    //
    //设置查找到Descriptors名称
    [self.baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    
    //设置读取到Descriptors值
    [self.baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    //写Characteristic成功后
    [self.baby setBlockOnDidWriteValueForCharacteristic:^(CBCharacteristic *characteristic, NSError *error) {
        //            [MBProgressHUD showSuccess:@"写Characteristic成功后"];
    }];
    
    //写descriptor成功后
    [self.baby setBlockOnDidWriteValueForDescriptor:^(CBDescriptor *descriptor, NSError *error) {
        [weakself.view showHUDForSuccess:Localized(@"写descriptor成功后")];
    }];
    
    //characteristic订阅状态改变
    [self.baby setBlockOnDidUpdateNotificationStateForCharacteristic:^(CBCharacteristic *characteristic, NSError *error) {
        
    }];
    
    //读取RSSI的委托
    [self.baby setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        
    }];
    
    //外设更新名字后
    [self.baby setBlockOnDidUpdateName:^(CBPeripheral *peripheral) {
        
    }];
    
    //外设更新服务后
    [self.baby setBlockOnDidModifyServices:^(CBPeripheral *peripheral, NSArray *invalidatedServices) {
        
    }];
    
    
}
#pragma mark 给外设发数据
-(void)sendDataToBlue:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"给外设发数据 str ----- %@",str);
    if (self.currPeripheral && self.writeCharacteristic) {
        [self.currPeripheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

#pragma mark 处理接收到的数据
-(void) GetDeviceData{
    
    NSString *a = self.reseviceData;
    NSLog(@"处理接收到的数据 self.reseviceData ----- %@",a);
    if ([a hasPrefix:@"SL"]) {
        //屏幕锁定，提示解锁
        [self showLockTipsView];
    }else if ([a hasPrefix:@"SA"]){
        //接收到下位机的开始命令，获取开始时间
        NSDate *currentDate = [NSDate date];
        self.deviceMode.connectTime = [SYTimeHelper niceDateFrom_YYYY_MM_DD:currentDate];
        NSString *startStr = [NSString stringWithFormat:@"   开始时间：%@",isNull(self.deviceMode.connectTime) == YES ? @"" : self.deviceMode.connectTime];
        [_timeBtn setTitle:startStr forState:UIControlStateNormal];
    }
    
}

- (void)disconnectTheBluetooth{
    //取消远程控制事件
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.baby cancelScan];
    [self.baby cancelAllPeripheralsConnection];
    //    [self.peripherals removeAllObjects];
    
    self.isLink = NO;
    self.isSearchToTheDevice = NO;
    [self.tableView reloadData];
}

//取消连接蓝牙
- (void)cancelConnectBluetooth{
    [self disconnectTheBluetooth];
    [self hiddenTipsView];
}
//重新搜索
- (void)searchAgain{
    [self hiddenTipsView];
    [self scanPeripheral];
}

- (SYImageLabelCell *)gettingImageLabelCellInTabelView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYImageLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.deviceImageView.image = PNGIMAGE(@"pic_health");
    cell.deviceNameLabel.text = Localized(@"设备名称：负压养生仪");
    cell.deviceNameLabelHeight.constant = 30;
    cell.deviceNameLabel.text = @"";
    
    return cell;
}

- (SYBluetoothStaduesCell *)gettingBluetoothCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYBluetoothStaduesCell *cell = [tableView dequeueReusableCellWithIdentifier:bluetoothCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.isLink) {
        cell.leftImageView.image = PNGIMAGE(@"ing_mobilelike");
        cell.rightImageView.image = PNGIMAGE(@"ing_bluetoothike");
    } else {
        cell.leftImageView.image = PNGIMAGE(@"ing_mobilecut");
        cell.rightImageView.image = PNGIMAGE(@"img_bluetoothcut");
    }
    return cell;
}

#pragma mark - cell delegate


#pragma mark SYImageLabelCellDelegate
- (void)usedToGuid{
    [self.view showHUDForError:@"使用指导"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
        {
            return [self gettingImageLabelCellInTabelView:tableView atIndexPath:indexPath];
        }
            break;
        case 1:
        {
            return [self gettingBluetoothCellInTableView:tableView atIndexPath:indexPath];
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 30)];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return KscreenHeight - kCustomNavHeight - 10 * 3 - 60 * 2 - 140;
        }
            break;
        default:
            return 44;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
    }
    
}


#pragma mark - collection


#pragma mark - Get
-(UIButton *)timeBtn{
    if (!_timeBtn) {
        _timeBtn = [[UIButton alloc]init];
        [_timeBtn setBackgroundColor:kAppColorAuxiliaryGreen];
        _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:13*kWidthFactor];
        NSString *startStr = [NSString stringWithFormat:@"   开始时间：%@",isNull(self.deviceMode.connectTime) == YES ? @"" : self.deviceMode.connectTime];
        [_timeBtn setTitle:startStr forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _timeBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + kTimeBtnHeight, KscreenWidth, KscreenHeight - kCustomNavHeight - kTimeBtnHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //这行代码必须加上，可以去除tableView的多余的线，否则会影响美观
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:imageCellID bundle:nil] forCellReuseIdentifier:imageCellID];
        [_tableView registerNib:[UINib nibWithNibName:bluetoothCellID bundle:nil] forCellReuseIdentifier:bluetoothCellID];
    }
    return _tableView;
}

- (SYCustomAlertView *)customAlertView{
    if (!_customAlertView) {
        _customAlertView = [[SYCustomAlertView alloc] initWithTitle:Localized(@"提示！") tips:Localized(@"请确认设备已打开，并保持靠近手机。") cancelTitle:Localized(@"取消") sureTitle:Localized(@"重新搜索")];
        WeakSelf;
        _customAlertView.complateBlock = ^(NSInteger index){
            if (index == 0) {
                [weakself cancelConnectBluetooth];
            } else if (index == 1) {
                [weakself searchAgain];
            }
            
        };
    }
    return _customAlertView;
}

- (SYCustomAlertView *)lockTipsView{
    if (!_lockTipsView) {
        _lockTipsView = [[SYCustomAlertView alloc] initWithTitle:Localized(@"提示！") tips:Localized(@"设备已锁定，已进入保护模式。") cancelTitle:nil sureTitle:Localized(@"立即解锁")];
        
        WeakSelf;
        _lockTipsView.complateBlock = ^(NSInteger index){
            if (index == 0) {
                
            } else if (index == 1) {
                [weakself hiddenLockTipsView];
                [weakself immediatelyUnlock];
            }
            
        };
    }
    return _lockTipsView;
}

- (UIView *)blackBackView{
    if (!_blackBackView) {
        _blackBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blackBackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        _blackBackView.userInteractionEnabled = NO;
    }
    return _blackBackView;
}

- (NSMutableArray *)peripherals{
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}
@end
