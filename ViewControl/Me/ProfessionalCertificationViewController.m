//
//  ProfessionalCertificationViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ProfessionalCertificationViewController.h"
#import "UserInfoTextFeildCell.h"
#import "TextViewCell.h"
#import "ImageShowCell.h"
#import "EditDataStepOneViewController.h"
#import "SYReadProfessionalApi.h"
#import "SYServiceItemCell.h"

#define SECTION_HEAD_HEIGHT 10

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *textViewCellID = @"TextViewCell";
static NSString *imageShowCellID = @"ImageShowCell";
static NSString *serviceItemCellID = @"SYServiceItemCell";

@interface ProfessionalCertificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *technicianArray;
@property (nonatomic,strong) NSMutableArray *certificatesArray;
@property (nonatomic,strong) NSMutableArray *skillArray;

@end

@implementation ProfessionalCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationUnionImagesUploadSuccess, @selector(reloaddata));
    ObserveNotification(kNotificationUnionInfomationUploadSuccess, @selector(reloaddata));
    [self loadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"职业认证");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = NO;
    [self.moreBtn setTitle:Localized(@"修改") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [[SYAppConfig shared] loadTheUnionStateWithSuccessBlock:^(id responseObject) {
            [weakself editData];
        } failureBlock:^(id error) {
            
        }];
        
    };
    
    [self.view addSubview:self.tableView];
}

- (void)editData{
    WeakSelf;
    if ([[SYAppConfig shared].me.stateEvaluation isEqualToString:@"dsh"]) {
        [weakself.view showHUDForError:Localized(@"系统审核中，暂不可修改！")];
        return;
    }
    
    EditDataStepOneViewController *stepOneVC = [[EditDataStepOneViewController alloc] init];
    [weakself.navigationController pushViewController:stepOneVC animated:YES];
}

- (void)reloaddata{
    [self loadData];
}

- (void)loadData{
    WeakSelf;
    NSString *url = [NSString stringWithFormat:
                     @"%@Health/app/dsTechnician/read?id=%@",
                     URL_HTTP_Base,
                     [SYAppConfig shared].me.userID
                     ];
    [self.view showHUDWithMessage:Localized(@"拼命加载中...")];
    SYReadProfessionalApi *earningApi = [[SYReadProfessionalApi alloc] initWithUrl:url];
    
    [earningApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.technicianArray removeAllObjects];
        [weakself.certificatesArray removeAllObjects];
        [weakself.skillArray removeAllObjects];
        if (!isNullDictionary(request.responseObject[@"data"])&&!isNullDictionary(request.responseObject[@"data"][@"entity"])) {
            weakself.dataDic = request.responseObject[@"data"][@"entity"];
            NSString *technicianString = weakself.dataDic[@"technician"][@"idPhoto"];//身份证
            NSString *certificatesString = weakself.dataDic[@"certificates"][@"picture"];//职业资格证
            NSString *skillString = weakself.dataDic[@"skill"][@"certificateOfInduction"];//上岗证
            [weakself.technicianArray addObjectsFromArray:[self parsingPicwithString:technicianString]];
            [weakself.certificatesArray addObjectsFromArray:[self parsingPicwithString:certificatesString]];
            [weakself.skillArray addObjectsFromArray:[self parsingPicwithString:skillString]];
            
            JYUserMode *user = [SYAppConfig shared].me;
            user.jobNum = weakself.dataDic[@"skill"][@"jobNum"];
            user.serviceItem = weakself.dataDic[@"skill"][@"category"];
            user.level = weakself.dataDic[@"skill"][@"professionLevel"];
            user.workingYear = weakself.dataDic[@"skill"][@"jobYear"];
            user.university = weakself.dataDic[@"skill"][@"graduateCollege"];
            user.goodAtIntroduction = weakself.dataDic[@"skill"][@"specialityDesc"];
            
            [weakself.tableView reloadData];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (id)parsingPicwithString:(NSString *)picString{
    
    if (isNull(picString)) {
        return nil;
    }
    
    NSData *data = [picString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id picArray = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
    if (error) {
        NSLog(@"%@",error);
        
    }
    return picArray;
}

#pragma mark Method
- (UserInfoTextFeildCell *)gettingTextFeildCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserInfoTextFeildCell *cell = [tableView dequeueReusableCellWithIdentifier:textFeildCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    cell.titleLabel.text = subArray[indexPath.row];
    cell.valueTextFeild.userInteractionEnabled = NO;
    return cell;
}

- (TextViewCell *)gettingTextViewCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textViewCellID];
    return cell;
}

- (ImageShowCell *)gettingImageCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ImageShowCell *cell = [tableView dequeueReusableCellWithIdentifier:imageShowCellID];
    return cell;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArray = [self.dataArray objectAtIndex:section];
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYUserMode *appUser = [SYAppConfig shared].me;
    switch (indexPath.section) {
        case 0:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.textColor = kAppColorTextLightGray;
                    cell.rightImgView.hidden = YES;
                    NSString *jobNumString = appUser.jobNum;
                    cell.valueTextFeild.text = isNull(jobNumString) == YES ? @"" : jobNumString;
                    return cell;
                }
                    break;
                case 1:
                {
                    SYServiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceItemCellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.rightImgView.hidden = YES;
                    NSString *categoryString = appUser.serviceItem;
                    cell.valueLabel.text = isNull(categoryString) == YES ? @"" : categoryString;
                    return cell;
                }
                    break;
                case 2:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    NSString *professionLevelString = appUser.level;
                    cell.valueTextFeild.text = isNull(professionLevelString) == YES ? @"" : professionLevelString;
                    return cell;
                }
                    break;
                case 3:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    NSString *jobYearString = [appUser.workingYear stringValue];
                    jobYearString = isNull(jobYearString) == YES ? @"0" : jobYearString;
                    cell.valueTextFeild.text = [NSString stringWithFormat:@"%@  年",jobYearString];
                    return cell;
                }
                    break;
                case 4:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    NSString *graduateCollegeString = appUser.university;
                    cell.valueTextFeild.text = isNull(graduateCollegeString) == YES ? @"" : graduateCollegeString;
                    return cell;
                }
                    break;
                case 5:
                {
                    TextViewCell *cell = [self gettingTextViewCellInTableView:tableView atIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.valueTextView.userInteractionEnabled = NO;
                    self.placeHolderLabel = cell.placeHolderLabel;
                    NSString *graduateCollegeString = appUser.goodAtIntroduction;
                    graduateCollegeString = isNull(graduateCollegeString) == YES ? @"" : graduateCollegeString;
                    cell.valueTextView.text = graduateCollegeString;
                    self.placeHolderLabel.hidden = !isNull(graduateCollegeString);
                    self.placeHolderLabel.text = @"暂无简介";
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            ImageShowCell *cell = [self gettingImageCellInTableView:tableView atIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
            cell.titleLabel.text = subArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                {
                    cell.images = self.technicianArray;
                }
                    break;
                case 1:
                {
                    cell.images = self.certificatesArray;
                }
                    break;
                case 2:
                {
                    cell.images = self.skillArray;
                }
                    break;
                    
                default:
                    break;
            }
            [cell.collectionView reloadData];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 5) {
        //简介cell高度
        return 120 + [NSString heightForString:[SYAppConfig shared].me.goodAtIntroduction labelWidth:KscreenWidth - 40 fontOfSize:15];
    }else if (indexPath.section == 0 && indexPath.row != 5){
        if (indexPath.row == 1) {
            NSString *serciceItemString = [SYAppConfig shared].me.serviceItem;
            return 45 + [NSString heightForString:serciceItemString labelWidth:KscreenWidth - 143 fontOfSize:17];
        } else {
            //第一段cell高度
            return 45;
        }
    }else{
        //资质证书cell高度
        return 180;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, SECTION_HEAD_HEIGHT)];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        return SECTION_HEAD_HEIGHT;
    }
    return 0;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kAppColorBackground;
        [_tableView registerNib:[UINib nibWithNibName:textFeildCellID bundle:nil] forCellReuseIdentifier:textFeildCellID];
        [_tableView registerNib:[UINib nibWithNibName:textViewCellID bundle:nil] forCellReuseIdentifier:textViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:imageShowCellID bundle:nil] forCellReuseIdentifier:imageShowCellID];
        [_tableView registerNib:[UINib nibWithNibName:serviceItemCellID bundle:nil] forCellReuseIdentifier:serviceItemCellID];
        
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[Localized(@"工号"),Localized(@"职业类别"),Localized(@"职级"),Localized(@"工作经验"),Localized(@"毕业院校"),Localized(@"擅长简介"),],@[Localized(@"手持身份证明"),Localized(@"职业资格证明"),Localized(@"上岗证")]]];
    }
    return _dataArray;
}

- (NSMutableArray *)technicianArray{
    if (!_technicianArray) {
        _technicianArray = [NSMutableArray array];
    }
    return _technicianArray;
}

- (NSMutableArray *)certificatesArray{
    if (!_certificatesArray) {
        _certificatesArray = [NSMutableArray array];
    }
    return _certificatesArray;
}

- (NSMutableArray *)skillArray{
    if (!_skillArray) {
        _skillArray = [NSMutableArray array];
    }
    return _skillArray;
}

@end
