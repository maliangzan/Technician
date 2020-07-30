//
//  FindViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "FindViewController.h"
#import "FindViewCollectionCell.h"
#import "SYDeviceMode.h"
#import "SYAddDeviceViewController.h"
#import "SYConnectDeviceViewController.h"
#import "SYCustomAlertView.h"
#import "SYMyDeviceListApi.h"
#import "SYDeleteMyDeviceApi.h"

#define channelOnPeropheralView @"peripheralView"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
#define kDeviceBtnHeight 37*kHeightFactor

static NSString *cellID = @"FindViewCollectionCell";
@interface FindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,FindViewCollectionCellDelegate>
{
}
@property(nonatomic , strong)UIButton *deviceBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *deviceArray;
@property (nonatomic,strong) SYCustomAlertView *customAlertView;
@property (nonatomic,strong) UIView *blackBackView;
@end

@implementation FindViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ObserveNotification(kNotificationSYAddDeviceViewControllerAddDeviceSuccess, @selector(addDeviceSucces));
    ObserveNotification(kNotificationLoginSuccess, @selector(loadData));
//    [self testData];
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated{
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"发现";
    WeakSelf;
    self.backBtn.hidden = YES;
    self.leftTextBtn.hidden = NO;
    [self.leftTextBtn setTitle:Localized(@"添加") forState:(UIControlStateNormal)];
    self.leftBtn = ^{
        [weakself addDevice];
    };
    
    self.moreBtn.hidden = NO;
    
    [self.moreBtn setBackgroundImage:nil forState:(UIControlStateNormal)];
    [self.moreBtn setTitle:Localized(@"解绑") forState:(UIControlStateNormal)];
    [self.moreBtn setTitle:Localized(@"保存") forState:(UIControlStateSelected)];
    
    self.rightBtn = ^{
        [weakself rigthBtnAction];
    };
    
    
    
    [self.view addSubview:self.deviceBtn];
    [self.deviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.height.mas_equalTo(kDeviceBtnHeight);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.deviceBtn.mas_bottom).offset(0);;
        make.bottom.equalTo(self.view);
    }];
    
}

#pragma mark method
- (void)addDeviceSucces{
    [self loadData];
}

- (void)bindData{
}

- (void)loadData{
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                            @"%@dsEquipment/queryList?boundId=%@",
                            URL_HTTP_Base_Get,
                            [SYAppConfig shared].me.userID
                            ];
    
    SYMyDeviceListApi *deviceApi = [[SYMyDeviceListApi alloc] initWithUrl:urlStr];
    
    [deviceApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.deviceArray removeAllObjects];
        deviceApi.responseData;
        NSArray *array = request.responseObject[@"data"];
        for (NSDictionary *dic in request.responseObject[@"data"]) {
            SYDeviceMode *deviceMode = [SYDeviceMode fromJSONDictionary:dic];
            [weakself.deviceArray addObject:deviceMode];
        }
        [weakself.collectionView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)addDevice{
    
//    if (![self canGoOn]) {
//        return;
//    }
    
    WeakSelf;
    [[SYAppConfig shared] loadTheUnionStateWithSuccessBlock:^(id responseObject) {
        [weakself canAddDevice];
    } failureBlock:^(id error) {
        
    }];
    
}

- (void)canAddDevice{
    if (![[SYAppConfig shared].me.stateEvaluation isEqualToString:@"ytg"]) {
        [self.view showHUDForError:Localized(@"加盟通过后才能添加设备哦！")];
        return;
    }
    
    SYAddDeviceViewController *addVC = [[SYAddDeviceViewController alloc] init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (BOOL)canGoOn{
    if (self.moreBtn.selected) {
        [self showActionTipsView];
        return NO;
    }
    return YES;
}

- (void)rigthBtnAction{
//    if (isNullArray(self.deviceArray)) {
//        [self.view showHUDForError:Localized(@"请先添加设备！")];
//        return;
//    }
    self.moreBtn.selected = !self.moreBtn.selected;
    [self.collectionView reloadData];
    
    if (self.moreBtn.selected) {
        [self fireDevice];
        
    } else {
        [self saveFireDevice];
    }
}

- (void)showActionTipsView{
    [self.view addSubview:self.blackBackView];
    [self.customAlertView show];
}

- (void)hiddenActionTipsView{
    [self.customAlertView removeFromSuperview];
    [self.blackBackView removeFromSuperview];
}

- (void)fireDevice{
    
}

- (void)saveFireDevice{
    
}

- (void)myDeviceAction:(UIButton *)btn{
    if (![self canGoOn]) {
        return;
    }
//    [self.view showHUDForError:@"myDeviceAction"];
}

- (void)configCell:(FindViewCollectionCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    SYDeviceMode *device = [self.deviceArray objectAtIndex:indexPath.row];
    cell.deviceNameLabel.text = device.deviceName;
    
    if (!self.moreBtn.selected || device.isInTheUse) {
        cell.deleteBtn.hidden = YES;
    } else {
        cell.deleteBtn.hidden = NO;
    }
    
    //设置图片
    NSString *stateStr = @"un";
    if (device.isInTheUse) {
        stateStr = @"on";
    }else{
        stateStr = @"un";
    }
    //iocn_equipment_on_use0   iocn_equipment_un_use0
    device.deviceImageName = [NSString stringWithFormat:@"iocn_equipment_%@_use%ld",stateStr,indexPath.row % 3];
    cell.deviceImageView.image = PNGIMAGE(device.deviceImageName);

}

#pragma mark FindViewCollectionCellDelegate
- (void)fireDeviceAtCell:(FindViewCollectionCell *)cell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    SYDeviceMode *device = [self.deviceArray objectAtIndex:indexPath.row];
    
    
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsEquipment/del?id=%@",
                        URL_HTTP_Base_Get,
                        device.deviceID
                        ];
    
    
    SYDeleteMyDeviceApi *deleteApi = [[SYDeleteMyDeviceApi alloc] initWithUrl:urlStr];
    
    [deleteApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view showHUDForSuccess:Localized(@"删除成功！")];
        [weakself loadData];
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

#pragma mark - UICollectionView delegate dataSource

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.deviceArray.count;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从队列中取出一个Cell
    FindViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [self configCell:cell atIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (![self canGoOn]) {
        return;
    }
    
    SYDeviceMode *device = [self.deviceArray objectAtIndex:indexPath.row];
    SYConnectDeviceViewController *vc = [[SYConnectDeviceViewController alloc] initWithDeviceMode:device];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark 懒加载

#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/3, (fDeviceWidth-20)/3);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 5;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}

-(UIButton *)deviceBtn{
    if (!_deviceBtn) {
        _deviceBtn = [[UIButton alloc]init];
        [_deviceBtn setBackgroundColor:kAppColorAuxiliaryGreen];
        _deviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _deviceBtn.titleLabel.font = [UIFont systemFontOfSize:13*kWidthFactor];
        [_deviceBtn setTitle:@"      我的设备" forState:UIControlStateNormal];
        [_deviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        UIImageView *rightImage = [[UIImageView alloc] initWithImage:PNGIMAGE(@"comein")];
//        rightImage.frame = CGRectMake(KscreenWidth - 30, kDeviceBtnHeight / 2 - 10, 10, 20);
//        [_deviceBtn addSubview:rightImage];
        [_deviceBtn addTarget:self action:@selector(myDeviceAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deviceBtn;
}

- (NSMutableArray *)deviceArray{
    if (!_deviceArray) {
        _deviceArray = [NSMutableArray array];
    }
    return _deviceArray;
}

- (void)testData{
    
    for (int i = 0; i < 5; i ++) {
        NSString *name = [NSString stringWithFormat:@"养生仪0%d",i];
        NSString *imageStr = [NSString stringWithFormat:@"iocn_equipment0%d_state",arc4random() % 3];
        SYDeviceMode *device = [[SYDeviceMode alloc] init];
        device.deviceImageName = imageStr;
        device.deviceName = name;
        device.isInTheUse = i;
        [self.deviceArray addObject:device];
    }
}

- (SYCustomAlertView *)customAlertView{
    if (!_customAlertView) {
        _customAlertView = [[SYCustomAlertView alloc] initWithTitle:Localized(@"提示！") tips:Localized(@"请保存当前操作!") cancelTitle:nil sureTitle:nil];
    }
    return _customAlertView;
}

- (UIView *)blackBackView{
    if (!_blackBackView) {
        _blackBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blackBackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenActionTipsView)];
        [_blackBackView addGestureRecognizer:tap];
    }
    return _blackBackView;
}

@end
