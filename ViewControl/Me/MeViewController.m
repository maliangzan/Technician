//
//  MeViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "MeViewController.h"
#import "WalletViewController.h"
#import "CustomerViewController.h"
#import "SetOrderViewController.h"
#import "NewsViewController.h"
#import "FriendViewController.h"
#import "SetViewController.h"
#import "BaseUserInfoViewController.h"
#import "SYChooseImageHelper.h"
#import "SYActionSheet.h"
#import "SYItemSheet.h"
#import "ProfessionalCertificationViewController.h"
#import "MyEvaluationViewController.h"
#import "SYMyEvaluateApi.h"
#import "MyEvaluateMode.h"
#import "SYUploadImageHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SYMeViewContrlGetTechInfoApi.h"
#import "SYUploadServiceTimeApi.h"
#import "SYUploadWorkingStadusApi.h"
#import "SYWeekServiceTimeApi.h"
#import "SYTimeHelper.h"
#import "SYMeViewContrlUserInfoApi.h"

#define CELLGEIGHT 45.0*kHeightFactor

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *editInfoBtn;
@property (nonatomic, strong) UILabel *jobNumberLabel;
@property (nonatomic, strong) UILabel *evaluateLabel;
@property (nonatomic, strong) UIButton *ordersBtn;
@property (nonatomic, strong) UIButton *editServiceTimeBtn;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) UIView *lineViewTwo;
@property (nonatomic, strong) UIImageView *noticeMsgImgView;
@property (nonatomic, strong) NSArray *cellImageViewArray;
@property (nonatomic, strong) NSArray *cellTitleArray;
@property (nonatomic, strong) NSArray *allVcArray;
@property (nonatomic, strong) MyEvaluateMode *myEvaluate;
@property (nonatomic,strong) NSMutableArray *serviceStartTimeArray;
@property (nonatomic,strong) NSMutableArray *serviceEndTimeArray;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationBaseUserInfoViewControllerRefresh, @selector(refreshData));
    ObserveNotification(kNotificationLoginSuccess, @selector(configOrderBtn));
    ObserveNotification(kNotificationLoginSuccess, @selector(refreshData));
    ObserveNotification(kNotificationChangeOrderState, @selector(changeOrderState));
    ObserveNotification(kNotificationUnionInfomationUploadSuccess, @selector(refreshData));
    ObserveNotification(kNotificationUnionInfomationUploadSuccess, @selector(loadTechInfo));
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self loadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    
    self.headImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(190*kHeightFactor);
    }];
    
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.headImageView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view);
        
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.iconBtn.imageView.layer.cornerRadius = self.iconBtn.frame.size.width / 2;
    self.iconBtn.imageView.layer.masksToBounds = YES;
    
}

#pragma mark method
- (void)configOrderBtn{
    if ([[SYAppConfig shared].me.state isEqualToString:@"jdz"]) {
        [_ordersBtn setTitle:@"接单中" forState:UIControlStateNormal];
    } else {
        [_ordersBtn setTitle:@"休息中" forState:UIControlStateNormal];
    }
}

-(void)changeOrderState{
    [self configOrderBtn];
}

- (void)loadData{
    [self loadMyEvaluate];
    [self loadTechInfo];
    [self loadUserInfo];
}

- (void)loadTechInfo{
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsSkill/queryList?tid=%@",URL_HTTP_Base,[SYAppConfig shared].me.userID];
    WeakSelf;
    SYMeViewContrlGetTechInfoApi *api = [[SYMeViewContrlGetTechInfoApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSString *levelStr = [request.responseObject[@"data"] firstObject][@"category"];
        NSString *idString = [request.responseObject[@"data"] firstObject][@"jobNum"];
        levelStr = isNull(levelStr) == YES ? @"":[NSString stringWithFormat:@"%@       ",levelStr];
        idString = isNull(idString) == YES ? @"000000":idString;
        weakself.jobNumberLabel.text = [NSString stringWithFormat:@"%@工号：%@",levelStr,idString];
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)loadMyEvaluate{
    NSString *urlStr = [NSString stringWithFormat:@"%@dsSaleOrder/queryList?tid=%@",URL_HTTP_Base_Get,[SYAppConfig shared].me.userID];
    WeakSelf;
    SYMyEvaluateApi *api = [[SYMyEvaluateApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        api.responseData;
        weakself.myEvaluate = [MyEvaluateMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself configData];
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)loadUserInfo{
    NSString *urlStr = [NSString stringWithFormat:@"%@dsTechnician/iu?id=%@",URL_HTTP_Base_Get,[SYAppConfig shared].me.userID];
    WeakSelf;
    SYMeViewContrlUserInfoApi *api = [[SYMeViewContrlUserInfoApi alloc] initWithUrl:urlStr];
    
    [self.view showHUDWithMessage:Localized(@"")];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        JYUserMode *userMode = [JYUserMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself.iconImageView sd_setImageWithURL:[NSURL URLWithString:userMode.portrait] placeholderImage:placeh_userAvatar];
        weakself.nameLabel.text = userMode.realName;
        [SYAppConfig shared].me.portrait = userMode.portrait;
        [SYAppConfig shared].me.realName = userMode.realName;
        [SYAppConfig shared].me.dateOfBirth = userMode.dateOfBirth;
        [SYAppConfig shared].me.sex = userMode.sex;
        [SYAppConfig shared].me.email = userMode.email;
        [SYAppConfig shared].me.address = userMode.address;
        [SYAppConfig shared].me.detailAddress = userMode.detailAddress;
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)refreshData{
//刷新
//    JYUserMode *userMode = [SYAppConfig shared].me;
//    //设置头像
//    NSString *iconString = userMode.portrait;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:placeh_userAvatar];
//    //姓名
//    self.nameLabel.text = userMode.realName;
    [self loadData];
}

- (void)configData{
    //评分
    NSString *scoreString = self.myEvaluate.techCollScore;
    
    _evaluateLabel.attributedText = [self gettingAttributeStringWithServiceCount:[self.myEvaluate.serNum stringValue] evaluationCount:[self.myEvaluate.num stringValue] scoreString:scoreString];
}

#pragma mark 选择头像
- (void)chooseIcon:(UIButton *)btn{
    SYChooseImageHelper *imageHelper = [SYChooseImageHelper shared];
    imageHelper.allowsEditing = YES;
    
    imageHelper.resultImage = ^(SYChooseImageHelper *helper, NSDictionary *imageInfo){
        
        if (imageInfo) {
            [self changeAvatarWithImage:helper.editedImage];
        }
        [helper close];
    };
    [imageHelper show];
}

- (void)changeAvatarWithImage:(UIImage *)image{
    if (image) {
        [self uploadImage:image];
    }else{
        [self.iconBtn setImage:placeh_userAvatar forState:(UIControlStateNormal)];
    }
}

-(void)uploadImage:(UIImage *)image
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsTechnician/setPhoto",URL_HTTP_Base];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    NSString *loginName = [SYAppConfig shared].me.loginName;
    [params setValue:isNull(loginName) == YES ? @"":loginName forKey:@"loginName"];
    
    WeakSelf;
    [[SYUploadImageHelper shared] uploadImage:image withURLString:urlStr parameters:params imageKey:@"storePic" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        [weakself.view showHUDForError:Localized(@"保存成功")];
        [weakself.iconImageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"]] placeholderImage:placeh_userAvatar options:SDWebImageRefreshCached];

    } failure:^(NSError *error) {
        [weakself.view showHUDForError:Localized(@"图片上传失败，请检查网络状态！")];
        
    }];
}

//生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark 编辑资料
- (void)editUserInfomation{
    BaseUserInfoViewController *userInfoVC = [[BaseUserInfoViewController alloc] init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

#pragma mark 修改接单状态
- (void)changeWorkingStadues:(UIButton *)btn{
    WeakSelf;
    SYActionSheet *staduesPicker = [[SYActionSheet alloc] initWithFrame:self.view.bounds];
    staduesPicker.dataArray = [NSMutableArray arrayWithArray:@[@[@"接单中",@"休息中"]]];
    staduesPicker.pickerDone = ^(NSString *selectedStr) {
        [weakself uploadWorkingStaduesWithString:selectedStr];
    };
    [self.view addSubview:staduesPicker];
}

- (void)uploadWorkingStaduesWithString:(NSString *)string{
    NSString *stateString;
    if ([string isEqualToString:@"接单中"]) {
        stateString = @"jdz";
    } else {
        stateString = @"xxz";
    }
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsTechnician/iu?id=%@&state=%@",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        stateString
                        ];
    urlStr = [urlStr urlNSUTF8StringEncoding];
    WeakSelf;
    SYUploadWorkingStadusApi *api = [[SYUploadWorkingStadusApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.ordersBtn setTitle:string forState:(UIControlStateNormal)];
        [SYAppConfig shared].me.state = stateString;
        PostNotificationWithName(kNotificationChangeOrderState);
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"修改失败，连接不到服务器")];
        NSLog(@"%@", request.error);
    }];
    
}

#pragma mark 修改服务时间
- (void)editServiceTime{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsTechnicianServiceTime/queryList?tid=%@",URL_HTTP_Base,[SYAppConfig shared].me.userID];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"正在获取服务时间，请稍后...")];
    SYWeekServiceTimeApi *api = [[SYWeekServiceTimeApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.serviceStartTimeArray removeAllObjects];
        [weakself.serviceEndTimeArray removeAllObjects];
        for (NSDictionary *dic in request.responseObject[@"data"]) {
            [weakself.serviceStartTimeArray addObject:[weakself dateTimeOf:dic[@"startTime"]]];
            [weakself.serviceEndTimeArray addObject:[weakself dateTimeOf:dic[@"endTime"]]];
        }
        
        SYItemSheet *weekTimePicker = [[SYItemSheet alloc] initWithFrame:weakself.view.bounds actionType:(ItemActionTypeSelectWeekTime) title:Localized(@"一周工作时间")];
        weekTimePicker.serviceStarTimeArray = weakself.serviceStartTimeArray;
        weekTimePicker.serviceEndTimeArray = weakself.serviceEndTimeArray;
        [weekTimePicker dayPickerView];
        weekTimePicker.pickerDone = ^(NSString *selectedStr) {
            [weakself uploadServiceTimeWithSting:selectedStr];
        };
        [weakself.view addSubview:weekTimePicker];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"获取服务时间失败,连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
    
}

- (NSString *)dateTimeOf:(NSString *)timeString{
    
    NSTimeInterval _interval=[timeString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSString *currentDateStr = [SYTimeHelper niceDateFrom_HH_mm_ss:date];

    return currentDateStr;
}

- (void)uploadServiceTimeWithSting:(NSString *)string{
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    [[[SYUploadServiceTimeApi alloc] initWithServiceTimeString:string]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         [weakself.view hideHUD];
         if ([request isSuccess]) {
             [weakself.view showHUDForSuccess:Localized(@"服务时间已修改！")];
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view hideHUD];
         [weakself.view showHUDForError:Localized(@"修改失败，连接不到服务器")];
     }];
}
#pragma mark 职业认证
- (void)professionalCertification{
    ProfessionalCertificationViewController *professionalCertication = [[ProfessionalCertificationViewController alloc] init];
//    professionalCertication.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:professionalCertication animated:YES];
}
#pragma mark 我的评价
- (void)myEvaluation{
    MyEvaluationViewController *myEva = [[MyEvaluationViewController alloc] init];
    myEva.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myEva animated:YES];
}

- (NSMutableAttributedString *)gettingAttributeStringWithServiceCount:(NSString *)serviceCount evaluationCount:(NSString *)evaluationCount scoreString:(NSString *)scoreString{
    NSString *servieceStr = serviceCount;
    NSString *evaluationStr = evaluationCount;
    NSString *scoreStr = scoreString;
    
    NSString *oneStr = @"服务";
    NSString *twoStr = @"次          评价";
    NSString *treeStr = @"条          ";
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@分",oneStr,servieceStr,twoStr,evaluationStr,treeStr,scoreStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    textAttachment.image = PNGIMAGE(@"img_star_orange");; //设置图片
    textAttachment.bounds = CGRectMake(0, 0, 10, 10); //图片范围
    NSAttributedString *textString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:textString atIndex:
     oneStr.length
     +  servieceStr.length
     + twoStr.length
     + evaluationStr.length
     + treeStr.length];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(oneStr.length, servieceStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(oneStr.length + servieceStr.length + twoStr.length, evaluationStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(attrStr.length - 1 - scoreStr.length, scoreStr.length)];
    return attrStr;
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = PNGIMAGE(self.cellImageViewArray[[indexPath row]]);
    cell.textLabel.textColor = kAppColorTextLightBlack;
    cell.textLabel.text = self.cellTitleArray[[indexPath row]];
    //自定义分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELLGEIGHT - 1, KscreenWidth, 1)];
    line.backgroundColor = kAppColorBackground;
    [cell addSubview:line];
    
    //新消息显示橘色小圆点
    if (indexPath.row == 3) {
//        [cell addSubview:self.noticeMsgImgView];
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cellTitleArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELLGEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *VC = (UIViewController *)[self.allVcArray objectAtIndex:[indexPath row]];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark get
-(NSArray *)allVcArray{
    if (!_allVcArray) {
        _allVcArray = @[[WalletViewController new],[CustomerViewController new],[SetOrderViewController new],[[NewsViewController alloc] initWithUserInfo:nil isNoticeMessage:NO],[FriendViewController new],[SetViewController new],];
    }
    return _allVcArray;
}
-(NSArray *)cellImageViewArray{
    if (!_cellImageViewArray) {
        _cellImageViewArray =@[@"leftbar_wallet",@"leftbar_service",@"leftbar_order",@"leftbar_message",@"leftbar_friends",@"leftbar_setting"];
    }
    return _cellImageViewArray;
}
-(NSArray *)cellTitleArray{
    if (!_cellTitleArray) {
        _cellTitleArray = @[@"钱包",@"客服",@"订单",@"消息",@"推荐好友",@"设置"];
    }
    return _cellTitleArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 15)];
        view.backgroundColor = kAppColorBackground;
        _tableView.tableHeaderView = view;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UIButton *)iconBtn{
    if (!_iconBtn){
        _iconBtn = [[UIButton alloc]init];
//        [_iconBtn setBackgroundImage:PNGIMAGE(@"bg_evaluation") forState:UIControlStateNormal];
//        [_iconBtn setBackgroundImage:placeh_userAvatar forState:UIControlStateNormal];
        [_iconBtn addTarget:self action:@selector(chooseIcon:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _iconBtn;
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = placeh_userAvatar;
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.layer.cornerRadius = 75*kWidthFactor / 2;
        _iconImageView.layer.masksToBounds = YES;
        NSString *iconString = [SYAppConfig shared].me.portrait;
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:placeh_userAvatar];
    }
    return _iconImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = kAppColorTextBlack;
        _nameLabel.font = [UIFont systemFontOfSize:15*kHeightFactor];
        NSString *name = [SYAppConfig shared].me.realName;
        _nameLabel.text = isNull(name) == YES ? @"":name;
    }
    return _nameLabel;
}

- (UIButton *)editInfoBtn{
    if (!_editInfoBtn) {
        _editInfoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editInfoBtn setTitle:Localized(@"编辑资料") forState:(UIControlStateNormal)];
        [_editInfoBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];;
        _editInfoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _editInfoBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_editInfoBtn addTarget:self action:@selector(editUserInfomation) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _editInfoBtn;
}

-(UILabel *)jobNumberLabel{
    if (!_jobNumberLabel) {
        _jobNumberLabel = [[UILabel alloc]init];
        _jobNumberLabel.backgroundColor = [UIColor clearColor];
        _jobNumberLabel.textColor = kAppColorTextLightBlack;
        _jobNumberLabel.font = [UIFont systemFontOfSize:12*kHeightFactor];
        NSString *levelStr = [SYAppConfig shared].me.serviceItem;
        NSString *idString = [SYAppConfig shared].me.userNum;
        levelStr = isNull(levelStr) == YES ? @"":levelStr;
        idString = isNull(idString) == YES ? @"000000":idString;
        _jobNumberLabel.text = [NSString stringWithFormat:@"%@       工号：%@",levelStr,idString];
        _jobNumberLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(professionalCertification)];
        _jobNumberLabel.userInteractionEnabled = YES;
        [_jobNumberLabel addGestureRecognizer:tap];
    }
    return _jobNumberLabel;
}

-(UILabel *)evaluateLabel{
    if (!_evaluateLabel) {
        _evaluateLabel = [[UILabel alloc]init];
        _evaluateLabel.backgroundColor = [UIColor clearColor];
        _evaluateLabel.textColor = kAppColorTextLightBlack;
        _evaluateLabel.font = [UIFont systemFontOfSize:12*kHeightFactor];
        _evaluateLabel.attributedText = [self gettingAttributeStringWithServiceCount:@"0" evaluationCount:@"0" scoreString:@"0"];
        _evaluateLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myEvaluation)];
        _evaluateLabel.userInteractionEnabled = YES;
        [_evaluateLabel addGestureRecognizer:tap];
    }
    return _evaluateLabel;
    
}

-(UIButton *)ordersBtn{
    if (!_ordersBtn) {
        _ordersBtn = [[UIButton alloc]init];
        [_ordersBtn setBackgroundImage:PNGIMAGE(@"bg_OrderStatus") forState:UIControlStateNormal];
        [self configOrderBtn];
        
        [_ordersBtn setTitleColor:kAppColorAuxiliaryGreen forState:UIControlStateNormal];
        _ordersBtn.titleLabel.font = [UIFont systemFontOfSize:13 * kWidthFactor];
        [_ordersBtn addTarget:self action:@selector(changeWorkingStadues:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _ordersBtn;
}

- (UIButton *)editServiceTimeBtn{
    if (!_editServiceTimeBtn) {
        _editServiceTimeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editServiceTimeBtn setImage:PNGIMAGE(@"btn_edit") forState:(UIControlStateNormal)];
        [_editServiceTimeBtn setTitle:Localized(@"修改服务时间") forState:(UIControlStateNormal)];
        [_editServiceTimeBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
        _editServiceTimeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, - 6 * kWidthFactor, 0, 0);
        _editServiceTimeBtn.titleLabel.font = [UIFont systemFontOfSize:10 * kWidthFactor];
        _editServiceTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_editServiceTimeBtn addTarget:self action:@selector(editServiceTime) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _editServiceTimeBtn;
}

- (UIView *)lineViewOne{
    if (!_lineViewOne) {
        _lineViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 1)];
        _lineViewOne.backgroundColor = kAppColorLineLightWhite;
    }
    return _lineViewOne;
}

- (UIView *)lineViewTwo{
    if (!_lineViewTwo) {
        _lineViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 1)];
        _lineViewTwo.backgroundColor = kAppColorLineLightWhite;
    }
    return _lineViewTwo;
}

- (UIImageView *)noticeMsgImgView{
    if (!_noticeMsgImgView) {
        _noticeMsgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth - 40 * kWidthFactor, CELLGEIGHT / 2 - 5 * kWidthFactor, 10 * kWidthFactor, 10 * kWidthFactor)];
        _noticeMsgImgView.image = PNGIMAGE(@"img_notice");
    }
    return _noticeMsgImgView;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = PNGIMAGE(@"bg_PersonalCenter");
            imageView;
        });
        [_headImageView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView).offset(20*kWidthFactor);
            make.top.equalTo(_headImageView).offset(30*kHeightFactor);
            make.size.mas_equalTo(CGSizeMake(75*kWidthFactor, 75*kHeightFactor));
            
        }];

        [_headImageView addSubview:self.iconBtn];
        [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView).offset(20*kWidthFactor);
            make.top.equalTo(_headImageView).offset(30*kHeightFactor);
            make.size.mas_equalTo(CGSizeMake(75*kWidthFactor, 75*kHeightFactor));
            
        }];
        
        [_headImageView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconBtn.mas_right).offset(5*kWidthFactor);
            make.centerY.equalTo(self.iconBtn).offset(-5*kHeightFactor);
            
        }];
        
        [_headImageView addSubview:self.editInfoBtn];
        [self.editInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconBtn.mas_right).offset(5*kWidthFactor);
            make.centerY.equalTo(self.iconBtn).offset(15*kHeightFactor);
        }];
        
        [_headImageView addSubview:self.ordersBtn];
        [self.ordersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headImageView);
            make.centerY.equalTo(self.iconBtn);
            make.size.mas_equalTo(CGSizeMake(69*kWidthFactor, 23*kHeightFactor));
            
        }];
        
        [_headImageView addSubview:self.editServiceTimeBtn];
        [self.editServiceTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headImageView);
            make.centerY.equalTo(self.ordersBtn).offset(25 * kHeightFactor);
            make.size.mas_equalTo(CGSizeMake(85*kWidthFactor, 20*kHeightFactor));
            
        }];
        
        [_headImageView addSubview:self.jobNumberLabel];
        [self.jobNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconBtn.mas_bottom).offset(20*kWidthFactor);
            make.centerX.equalTo(_headImageView);
            make.left.equalTo(_headImageView.mas_left);
            make.right.equalTo(_headImageView.mas_right);
        }];
        
        [_headImageView addSubview:self.lineViewOne];
        [self.lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconBtn.mas_bottom).offset(8*kWidthFactor);
            make.left.equalTo(self.headImageView.mas_left);
            make.size.mas_equalTo(CGSizeMake(KscreenWidth * kWidthFactor, 0.5 * kHeightFactor));
            
        }];
        
        [_headImageView addSubview:self.evaluateLabel];
        [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jobNumberLabel.mas_bottom).offset(20*kWidthFactor);
            make.centerX.equalTo(_headImageView);
            make.left.equalTo(_headImageView.mas_left);
            make.right.equalTo(_headImageView.mas_right);
        }];
        

        [_headImageView addSubview:self.lineViewTwo];
        [self.lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconBtn.mas_bottom).offset(45*kWidthFactor);
            make.left.equalTo(self.headImageView.mas_left);
            make.size.mas_equalTo(CGSizeMake(KscreenWidth * kWidthFactor, 0.5 * kHeightFactor));
            
        }];
        
    }
    return _headImageView;
}

- (NSMutableArray *)serviceStartTimeArray{
    if (!_serviceStartTimeArray) {
        _serviceStartTimeArray = [NSMutableArray array];
    }
    return _serviceStartTimeArray;
}

- (NSMutableArray *)serviceEndTimeArray{
    if (!_serviceEndTimeArray) {
        _serviceEndTimeArray = [NSMutableArray array];
    }
    return _serviceEndTimeArray;
}

@end
