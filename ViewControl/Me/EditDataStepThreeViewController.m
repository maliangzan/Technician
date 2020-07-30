//
//  EditDataStepThreeViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EditDataStepThreeViewController.h"
#import "DataImageCell.h"
#import "CustomTipsSheet.h"
#import "SYUploadImageHelper.h"
#import "ProfessionalCertificationViewController.h"
#import "SYUnionApi.h"

static NSString *dataImageCellID = @"DataImageCell";
@interface EditDataStepThreeViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) JYUserMode *tempUser;
@property (nonatomic,strong) NSMutableArray *idCardImageArray;//手持身份证明
@property (nonatomic,strong) NSMutableArray *professionalArray;//职业资格证明
@end

@implementation EditDataStepThreeViewController
- (instancetype)initWithTempUser:(JYUserMode *)tempUser{
    if (self = [super init]) {
        self.tempUser = tempUser;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationUnionImagesSeletes, @selector(unionImagesSeletes:));
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildUI{
    [super buildUI];
    self.tableView.scrollEnabled = YES;
    
    [self.nextActionBtn setTitle:Localized(@"提交审核") forState:(UIControlStateNormal)];
    
    WeakSelf;
    self.nextStep = ^{
        [weakself CommitAction];
    };
}

-(void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:dataImageCellID bundle:nil] forCellReuseIdentifier:dataImageCellID];
}

- (void)unionImagesSeletes:(NSNotification *)noty{
    NSMutableDictionary *mutDic = noty.object;
    NSInteger indexOfRow = [[mutDic objectForKey:@"indexOfRow"] integerValue];
    NSArray *images = [mutDic objectForKey:@"images"];
    switch (indexOfRow) {
        case 0:
        {
            [self.idCardImageArray addObjectsFromArray:images];
        }
            break;
        case 1:
        {
            [self.professionalArray addObjectsFromArray:images];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark superMethod
- (void)congigHeadView{
    [self.headView.stepOneBtn setBackgroundImage:PNGIMAGE(@"complete") forState:(UIControlStateNormal)];
    [self.headView.stepTwoBtn setBackgroundImage:PNGIMAGE(@"complete") forState:(UIControlStateNormal)];
    [self.headView.stepThreeBtn setBackgroundImage:PNGIMAGE(@"current_selected3") forState:(UIControlStateNormal)];
}

#pragma mark Method
- (void)CommitAction{
    if (self.idCardImageArray.count != 3) {
        [self.view showHUDForError:Localized(@"手持身份证明需要三张！")];
        return;
    }
    if (self.professionalArray.count < 1) {
        [self.view showHUDForError:Localized(@"职业资格证明最少一张！")];
        return;
    }
    
    JYUserMode *appUser = [SYAppConfig shared].me;
    if (!isNull(self.tempUser.realName)) {
        appUser.realName = self.tempUser.realName;
    }
    if (!isNull(self.tempUser.dateOfBirth)) {
        appUser.dateOfBirth = self.tempUser.dateOfBirth;
    }
    if (self.tempUser.sex) {
        appUser.sex = self.tempUser.sex;
    }
    if (!isNull(self.tempUser.email)) {
        appUser.email = self.tempUser.email;
    }
    if (!isNull(self.tempUser.idCardNo)) {
        appUser.idCardNo = self.tempUser.idCardNo;
    }
    if (!isNull(self.tempUser.address)) {
        appUser.address = self.tempUser.address;
    }
    if (!isNull(self.tempUser.detailAddress)) {
        appUser.detailAddress = self.tempUser.detailAddress;
    }
    if (!isNull(self.tempUser.serviceItem)) {
        appUser.serviceItem = self.tempUser.serviceItem;
    }
    if (!isNull(self.tempUser.level)) {
        appUser.level = self.tempUser.level;
    }
    if (!isNull([self.tempUser.workingYear stringValue])) {
        appUser.workingYear = self.tempUser.workingYear;
    }
    if (!isNull(self.tempUser.university)) {
        appUser.university = self.tempUser.university;
    }
    if (!isNull(self.tempUser.goodAtIntroduction)) {
        appUser.goodAtIntroduction = self.tempUser.goodAtIntroduction;
    }
    
    [self uploadUserImfoWithMode:[SYAppConfig shared].me];
}


- (void)uploadUserImfoWithMode:(JYUserMode *)appUser{
    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"拼命提交中，请稍后...")];
    WeakSelf;
    [[[SYUnionApi alloc] initWithUser:appUser]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             
             [weakself uploadImages];
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"提交失败，连接不到服务器")];
     }];
    
}

-(void)uploadImages
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsTechnician/setPhotos1?",URL_HTTP_Base];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    NSString *loginName = [SYAppConfig shared].me.loginName;
    [params setValue:isNull(loginName) == YES ? @"":loginName forKey:@"loginName"];
    
    NSMutableArray *imageKeyArray = [NSMutableArray arrayWithArray:@[@"idImgfile1",@"idImgfile2",@"idImgfile3",@"cerImgfile1"]];
    NSData *firstIDCardImageData = UIImageJPEGRepresentation(self.idCardImageArray[0], 1);
    NSData *secondIDCardImageData = UIImageJPEGRepresentation(self.idCardImageArray[1], 1);
    NSData *thirdIDCardImageData = UIImageJPEGRepresentation(self.idCardImageArray[2], 1);
    
    NSData *firstProssionalImageData = UIImageJPEGRepresentation(self.professionalArray[0], 1);
    NSMutableArray *uploadImageDataArray = [NSMutableArray arrayWithArray:@[firstIDCardImageData,secondIDCardImageData,thirdIDCardImageData,firstProssionalImageData]];
    
    if (self.professionalArray.count == 2) {
        NSData *secondProssionalImageData = UIImageJPEGRepresentation(self.professionalArray[1], 1);
        [imageKeyArray addObject:@"cerImgfile2"];
        [uploadImageDataArray addObject:secondProssionalImageData];
    }
    
    if (self.professionalArray.count == 3) {
        NSData *secondProssionalImageData = UIImageJPEGRepresentation(self.professionalArray[1], 1);
        NSData *thirdProssionalImageData = UIImageJPEGRepresentation(self.professionalArray[2], 1);
        [imageKeyArray addObjectsFromArray:@[@"cerImgfile2",@"cerImgfile3"]];
        [uploadImageDataArray addObjectsFromArray:@[secondProssionalImageData,thirdProssionalImageData]];
        
    }
    
    WeakSelf;
//    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"提交中...")];
    [[SYUploadImageHelper shared] uploadImages:uploadImageDataArray withURLString:urlStr parameters:params imageKey:imageKeyArray progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        PostNotificationWithName(kNotificationUnionInfomationUploadSuccess);
        PostNotificationWithName(kNotificationUnionImagesUploadSuccess);
        //提交成功，加盟状态改为待审核，首页不提示加盟
        JYUserMode *user = [SYAppConfig shared].me;
        user.stateEvaluation = @"dsh";
        [[JYRequestHelper shared] setupWithUser:user];
        
        //提示
        CustomTipsSheet *servicePicker = [[CustomTipsSheet alloc] initWithFrame:self.view.bounds tipType:SYTipTypeCommitSuccess title:Localized(@"资料成功提交！") contenViewHeight:0];
        servicePicker.closeDone = ^() {
            
            for (UIViewController *subVC in weakself.navigationController.childViewControllers) {
                if ([subVC isKindOfClass:[ProfessionalCertificationViewController class]]) {
                    [weakself.navigationController popToViewController:subVC animated:NO];
                    [[SYAppConfig shared] gotoHomeViewController];
                    break;
                }else{
                    [weakself.navigationController popToRootViewControllerAnimated:NO];
                    [[SYAppConfig shared] gotoHomeViewController];
                }
            }
        };
        [weakself.view addSubview:servicePicker];
    } failure:^(NSError *error) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"图片上传失败,连接不到服务器！")];
    }];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataImageCell *cell = [tableView dequeueReusableCellWithIdentifier:dataImageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            cell.tag = 100 + 0;
            cell.titleLabel.text = Localized(@"手持身份证明");
        }
            break;
        case 1:
        {
            cell.tag = 100 + 1;
            cell.titleLabel.text = Localized(@"职业资格证明");
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return 250;
            
        }
            break;
        case 1:
        {
            return 180;
        }
            break;
            
        default:
            return 180;
            break;
    }
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"手持身份证明",@"职业资格证明"]];
    }
    return _dataArray;
}
- (NSMutableArray *)idCardImageArray{
    if (!_idCardImageArray) {
        _idCardImageArray = [NSMutableArray array];
    }
    return _idCardImageArray;
}

- (NSMutableArray *)professionalArray{
    if (!_professionalArray) {
        _professionalArray = [NSMutableArray array];
    }
    return _professionalArray;
}

@end
