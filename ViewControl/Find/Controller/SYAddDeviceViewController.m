//
//  SYAddDeviceViewController.m
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYAddDeviceViewController.h"
#import "SYImageLabelCell.h"
#import "SYTextFeildCell.h"
#import "SYLabelButtonCell.h"
#import "SYDeviceMode.h"
#import "SYAddMyDeviceApi.h"//get
#import "SYAddDeviceApi.h"//post

#import "BabyBluetooth.h"
#import "SYListContenView.h"
#import "SYCustomAlertView.h"
#import "PeripheralInfo.h"

#define channelOnPeropheralView @"peripheralView"

#define SERVICE_UUID_W @"0xFFE5"
#define SERVICE_UUID_R @"0xFFE0"

#define CHARACTOR_UUID_W @"0xFFE9"
#define CHARACTOR_UUID_R @"0xFFE4"

#define DEVICE_PRE @"SYY"

//$SNPM08201703001&
#define EffectiveDevice @"SN111111"
#define CHOOSE_MODE @"$A00000000&"

typedef NS_ENUM(NSInteger, TextFeildInputType) {
    TextFeildInputDeviceNum = 101,//输入设备编码
    TextFeildInputDeviceName = 102,//输入设备名称
};

static NSString *imageCellID = @"SYImageLabelCell";
static NSString *textFeildID = @"SYTextFeildCell";
static NSString *buttonCellID = @"SYLabelButtonCell";
@interface SYAddDeviceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SYLabelButtonCellDelegate,SYListContenViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *textFieldTempArray;
@property (nonatomic,strong) SYDeviceMode *addnewDevice;
@property (nonatomic,strong) SYCustomAlertView *customAlertView;
@property (nonatomic,strong) UIView *blackBackView;
@property (nonatomic,strong) SYListContenView *tipsView;

//蓝牙
@property (nonatomic,strong) NSMutableArray *peripheralDataArray;
@property (nonatomic,strong) BabyBluetooth *baby;
@property (nonatomic,strong) CBPeripheral *currPeripheral;
@property (nonatomic,strong) NSMutableArray *services;
@property (nonatomic,strong) NSMutableArray *readValueArray;
@property (nonatomic,strong) NSMutableArray *descriptors;
@property (nonatomic,strong) CBCharacteristic *characteristic;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;//写数据特征
@property (nonatomic,copy) NSString *reseviceData;//接收到的数据
@property (nonatomic,assign) BOOL isReievedServiceData;

@property (nonatomic,assign) BOOL isLink;//是否连接
@property (nonatomic,assign) BOOL isSearchToTheDevice;//是否搜索到指定设备

@end

@implementation SYAddDeviceViewController

#pragma mark supermethod
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindData];
    [self loadData];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self disconnectTheBluetooth];
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = Localized(@"添加设备");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    WeakSelf;
    self.moreBtn.hidden = NO;
    [self.moreBtn setTitle:Localized(@"搜索") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [weakself searchDevice];
    };
    
    [self.view addSubview:self.tableView];
}

- (void)searchDevice{
    
    [self configBluetooth];
    [self tipsViewShow];
    [self scanDevice];
    
}


#pragma mark bluetooth
- (void)configBluetooth{
    //初始化BabyBluetooth 蓝牙库
    self.baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
}

#pragma mark 扫描设备
- (void)scanDevice{

    //停止之前的连接
    [self.baby cancelAllPeripheralsConnection];
    //开始扫描
    [self.tipsView showHUDWithMessage:Localized(@"  正在搜索蓝牙设备...  ")];
    self.baby.scanForPeripherals().begin().stop(10);
    
    //    延时提示框
    WeakSelf;
    double delayInSeconds = 10.0;
    dispatch_time_t delayInTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_after(delayInTime, concurrentQueue, ^{
        if (weakself.peripheralDataArray.count == 0) {
            [weakself.view hideHUD];
//            [weakself.view showHUDForError:Localized(@"没有找到蓝牙设备！")];
            //停止扫描
            [weakself.baby cancelScan];
        }
    });
}

#pragma mark -蓝牙配置和操作
//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    
    WeakSelf;
    //设置扫描到设备的委托
    [self.baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakself.tipsView hideHUD];
        [weakself.view hideHUD];
//        if ([peripheral.name hasPrefix:DEVICE_PRE]) {
            [weakself insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
//        }
        
//        NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
//        id macNameString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//        NSLog(@"搜索到了设备:peripheral = %@\nadvertisementData = %@\nmacNameString = %@",peripheral,advertisementData,macNameString);
        
    }];
    
    //过滤器
    //设置查找设备的过滤器
    [self.baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备 most common usage is discover for peripheral that name has common prefix
        NSLog(@"peripheralName = %@",peripheralName);
        //保存设备
        //        for (CBPeripheral *peripheral in weakself.peripherals) {
        //            if ( [peripheral.name isEqualToString:weakself.deviceMode.deviceNum]) {
        //                weakself.currPeripheral = peripheral;
        //                //连接设备
        //                [weakself connectPeripheral];
        //                [weakself.view hideHUD];
        //                break;
        //            }
        //        }
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
        weakself.isLink = NO;
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
            [weakself.view showHUDForSuccess:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    //设置查找服务
    [self.baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"找到服务:%@", peripheral.services);
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
//        NSLog(@"找到特征:%@", service.characteristics);
        // 遍历所有的特征
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"###################所有特征:%@#############", characteristic.UUID);

            // 过滤掉不想要的特征
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTOR_UUID_R]]) {
                // 找到想要的特征,读
//                NSLog(@"----------------------找到特征CHARACTOR_UUID_R");
                //            SYLog(@"0xFFF4 的特性已发现，下一步注册监听");
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTOR_UUID_W]]) {
//                NSLog(@"----------------------找到特征CHARACTOR_UUID_W");
                weakself.writeCharacteristic = characteristic;
                //写
//                static dispatch_once_t onceToken;
//                dispatch_once(&onceToken, ^{
//                    NSLog(@"++++++++++++++++++++weakself.writeCharacteristic%@",characteristic.UUID);
//                    weakself.writeCharacteristic = characteristic;
//                });
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
        NSData *data = [NSData dataWithData:characteristic.value];
        NSLog(@"*********接收到的所有数据数据*************: characteristic name:%@ value is:%@ (%@)",characteristic.UUID,characteristic.value,[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
        if (error)
        {
            //                    [weakself.view showHUDForError:[NSString stringWithFormat:@"手机连接设备出错%@",error.localizedDescription]];
            NSLog(@"手机连接设备出错:error - %@ characteristic name:%@ value is:%@", error,characteristic.UUID,characteristic.value);
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
    if (!self.currPeripheral) {
        NSLog(@"没有找到Peripheral");
        return;
    }
    
    if (!self.writeCharacteristic) {
        [self.view showHUDForError:Localized(@"未找到写特征，请连接正确的设备！")];
        return;
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"给外设发数据 data ----- %@",data);
    [self.view showHUDWithMessage:Localized(@"设备确认中，请稍后......")];
    self.isReievedServiceData = NO;
    [self.currPeripheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
    
    //    延时提示框
    WeakSelf;
    double delayInSeconds = 10.0;
    dispatch_time_t delayInTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_after(delayInTime, concurrentQueue, ^{
        if (weakself.peripheralDataArray.count == 0) {
            [weakself.view hideHUD];
            if (!weakself.isReievedServiceData) {
                [weakself.view showHUDForError:Localized(@"未收到设备确认信息！")];
            }
        }
    });
}

#pragma mark 处理接收到的数据
-(void) GetDeviceData{
    [self.view hideHUD];
    self.isReievedServiceData = YES;
    NSString *a = self.reseviceData;
    NSLog(@"处理接收到的数据 self.reseviceData ----- %@",a);
    if ([a containsString:EffectiveDevice]) {
        [self requestDevice];
    }else if ([a hasPrefix:@"SN"]){
        [self.view showHUDForError:Localized(@"设备编码验证失败，请重新确认！")];
    }
}

#pragma mark -插入table数据
//设备
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [self.peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [self.peripheralDataArray addObject:item];
        self.tipsView.dataArray = self.peripheralDataArray;
        [self resetTipsViewFramewithAnimationTime:0.5];
        [self.tipsView.tableView reloadData];
    }
}

//取消连接蓝牙
- (void)cancelConnectBluetooth{
    [self disconnectTheBluetooth];
    [self hiddenTipsView];
}

- (void)disconnectTheBluetooth{
    //取消远程控制事件
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.baby cancelScan];
    [self.baby cancelAllPeripheralsConnection];
    
        self.isLink = NO;
    //    self.isSearchToTheDevice = NO;
    [self.tableView reloadData];
}
//重新搜索
- (void)searchAgain{
    [self hiddenTipsView];
}

- (void)showDeviceListView{
    self.tipsView.dataArray = self.peripheralDataArray;
    [self.tipsView.tableView reloadData];
    
    [self tipsViewShow];
}

//展示设备列表view
- (void)tipsViewShow{
    [self.view addSubview:self.blackBackView];
    self.blackBackView.userInteractionEnabled = NO;
    [self.tipsView show];
}

//隐藏设备列表view
- (void)tipsViewHidden{
    [self.tipsView removeFromSuperview];
    [self.blackBackView removeFromSuperview];
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

#pragma mark 连接设备
- (void)connectPeripheral{
    [self.view showHUDWithMessage:Localized(@"正在连接蓝牙设备...")];
    self.baby.having(self.currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

#pragma mark - addViews

#pragma mark - bindData
- (void)bindData {
    self.isLink = NO;
    self.isReievedServiceData = NO;
}

#pragma mark - loadData
- (void)loadData{
    
}

- (void)requestDevice{
    
    [self.view showHUDWithMessage:Localized(@"")];
    WeakSelf;
    [[[SYAddDeviceApi alloc] initWithDeviceMode:self.addnewDevice]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [weakself.view hideHUD];
             [[UIApplication sharedApplication].keyWindow showHUDForSuccess:Localized(@"添加设备成功！")];
             [weakself.navigationController popToRootViewControllerAnimated:YES];
             PostNotificationWithName(kNotificationSYAddDeviceViewControllerAddDeviceSuccess);
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view hideHUD];
         [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"请求超时...")];
     }];
    
//    WeakSelf;
//    NSString *addDeviceUrl = [NSString stringWithFormat:
//                              @"%@dsEquipment/iu?boundId=%@&no=%@&name=%@&eqType=%@&bluetoothName=%@",
//                              URL_HTTP_Base_Get,
//                              [SYAppConfig shared].me.userID,
//                              self.addnewDevice.deviceNum,
//                              self.addnewDevice.deviceName,
//                              @"负压养生仪",
//                              self.addnewDevice.bluetoothName
//                
//                              ];
//    addDeviceUrl = [addDeviceUrl urlNSUTF8StringEncoding];
//    
//    SYAddMyDeviceApi *addDeviceApi = [[SYAddMyDeviceApi alloc] initWithUrl:addDeviceUrl];
//    
//    [addDeviceApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        [weakself.view showHUDForSuccess:Localized(@"添加设备成功！")];
//        [weakself.navigationController popToRootViewControllerAnimated:YES];
//        PostNotificationWithName(kNotificationSYAddDeviceViewControllerAddDeviceSuccess);
//        
//    } failure:^(YTKBaseRequest *request) {
//        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
//        NSLog(@"%@", request.error);
//    }];
}

#pragma mark - business
- (SYImageLabelCell *)gettingImageLabelCellInTabelView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYImageLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.deviceImageView.image = PNGIMAGE(@"pic_health");
    cell.deviceNameLabel.text = Localized(@"设备名称：负压养生仪");
    cell.guidBtn.hidden = YES;
    
    return cell;
}

- (SYTextFeildCell *)gettingTextFeildCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withPlaceHolder:(NSString *)placeholder{
    SYTextFeildCell *cell = [tableView dequeueReusableCellWithIdentifier:textFeildID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFeild.placeholder = placeholder;
    cell.textFeild.delegate = self;
    
    
    [self.textFieldTempArray addObject:cell.textFeild];
    if (indexPath.section == 1) {
        cell.textFeild.tag = TextFeildInputDeviceNum;
//        cell.textFeild.text = isNull(self.currPeripheral.name) == YES ? @"":self.currPeripheral.name;
    } else if (indexPath.section == 2){
        cell.textFeild.tag = TextFeildInputDeviceName;
    }
    
    return cell;
}

- (SYLabelButtonCell *)gettingButtonCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYLabelButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    return cell;
}

- (void)resetTipsViewFramewithAnimationTime:(CGFloat)time{
    //frame
    CGFloat viewX = 20;
    CGFloat ViewW = KscreenWidth - viewX * 2;
    CGFloat viewH = 60 + self.peripheralDataArray.count * 44 + 20;
    viewH = (viewH > KscreenHeight * 2 / 3) ? (KscreenHeight * 2 / 3) : viewH;
    if (self.peripheralDataArray.count == 0) {
        viewH = 250;
    }
    CGFloat viewY = (KscreenHeight - viewH) / 2;
    
    [UIView animateWithDuration:time animations:^{
        _tipsView.frame = CGRectMake(viewX, viewY, ViewW, viewH);
    }];
    
}
#pragma mark - cell delegate

#pragma mark <SYListContenViewDelegate>
- (void)closeTips{
    //停止扫描
    [self.baby cancelScan];
    [self.peripheralDataArray removeAllObjects];
    
    [self tipsViewHidden];
}

- (void)selectedAtIndexPath:(NSIndexPath *)indexPath{
    //停止扫描
    [self.baby cancelScan];
    
    NSDictionary *item = [self.peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    self.currPeripheral = peripheral;
    self.addnewDevice.bluetoothName = self.currPeripheral.name;
    [self.tableView reloadData];
    
    [self connectPeripheral];
    
}

#pragma mark SYLabelButtonCellDelegate
//提交
- (void)commitAddDevice{
    [self.view endEditing:YES];
    if (!_isLink) {
        [self.view showHUDForError:Localized(@"请连接蓝牙设备！")];
        return;
    }
    //test
//    self.addnewDevice.deviceNum = @"PM08201703001";
        NSString *deviceNumS = self.addnewDevice.deviceNum;
        if (isNull(deviceNumS)) {
            [self.view showHUDForError:Localized(@"请输入设备编码")];
            return;
        }
    
        if (![deviceNumS hasPrefix:@"PM08"]) {
            [self.view showHUDForError:Localized(@"设备编码以 PM08开头")];
            return;
        }
    
        NSString *subStr = [deviceNumS substringWithRange:NSMakeRange(4, deviceNumS.length - 4)];
    
        if (![NSString isPureInt:subStr] || !(subStr.length == 9)) {
            [self.view showHUDForError:Localized(@"设备编码以 PM08 + 9位数字组成")];
            return;
        }
    
        if (isNull(self.addnewDevice.deviceName)) {
            [self.view showHUDForError:Localized(@"请设置设备名称")];
            return;
        }
        if ([NSString hasEmptySubString:self.addnewDevice.deviceName]) {
            [self.view showHUDForError:Localized(@"设备名称不能有空格")];
            return;
        }
    
//#define CHECK_NUM @"$SNPM08201703001&"

    NSString *cheskStr = [NSString stringWithFormat:@"$SN%@&",deviceNumS];
    //发送指令校验
    [self sendDataToBlue:cheskStr];
    
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
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
            SYTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath withPlaceHolder:Localized(@"请输入设备编码")];
            return cell;
        }
            break;
        case 2:
        {
            return [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath withPlaceHolder:Localized(@"请设置设备名称")];
        }
            break;
        case 3:
        {
            return [self gettingButtonCellInTableView:tableView atIndexPath:indexPath];
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 10)];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return KscreenHeight - kCustomNavHeight - 10 * 3 - 60 * 2 - 140;
        }
            break;
        case 1:
        {
            return 60;
        }
            break;
        case 2:
        {
            return 60;
        }
            break;
        case 3:
        {
            return 140;
        }
            break;
        default:
            return 44;
            break;
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case TextFeildInputDeviceNum:
        {
            NSString *deviceNum = textField.text;
            self.addnewDevice.deviceNum = deviceNum;
        }
            break;
        case TextFeildInputDeviceName:
        {
            NSString *deviceName = textField.text;
            self.addnewDevice.deviceName = deviceName;
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - collection


#pragma mark - Get
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //这行代码必须加上，可以去除tableView的多余的线，否则会影响美观
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:imageCellID bundle:nil] forCellReuseIdentifier:imageCellID];
        [_tableView registerNib:[UINib nibWithNibName:textFeildID bundle:nil] forCellReuseIdentifier:textFeildID];
        [_tableView registerNib:[UINib nibWithNibName:buttonCellID bundle:nil] forCellReuseIdentifier:buttonCellID];
    }
    return _tableView;
}

- (NSMutableArray *)textFieldTempArray{
    if (!_textFieldTempArray) {
        _textFieldTempArray = [NSMutableArray array];
    }
    return _textFieldTempArray;
}
- (SYDeviceMode *)addnewDevice{
    if (!_addnewDevice) {
        _addnewDevice = [[SYDeviceMode alloc] init];
    }
    return _addnewDevice;
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

- (SYListContenView *)tipsView{
    if (!_tipsView) {
        _tipsView = [[[NSBundle mainBundle] loadNibNamed:@"SYListContenView" owner:nil options:nil] objectAtIndex:0];
        _tipsView.delegate = self;
        [self resetTipsViewFramewithAnimationTime:0];
        
        _tipsView.dataArray = self.peripheralDataArray;
    }
    return _tipsView;
}

- (UIView *)blackBackView{
    if (!_blackBackView) {
        _blackBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blackBackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        _blackBackView.userInteractionEnabled = NO;
    }
    return _blackBackView;
}

- (NSMutableArray *)peripheralDataArray{
    if (!_peripheralDataArray) {
        _peripheralDataArray = [NSMutableArray array];
    }
    return _peripheralDataArray;
}

- (NSMutableArray *)services{
    if (!_services) {
        _services = [NSMutableArray array];
    }
    return _services;
}

- (NSMutableArray *)readValueArray{
    if (!_readValueArray) {
        _readValueArray = [NSMutableArray array];
    }
    return _readValueArray;
}

- (NSMutableArray *)descriptors{
    if (!_descriptors) {
        _descriptors = [NSMutableArray array];
    }
    return _descriptors;
}

@end
