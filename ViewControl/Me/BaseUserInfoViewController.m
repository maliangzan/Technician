//
//  BaseUserInfoViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseUserInfoViewController.h"
#import "UserInfoTextFeildCell.h"
#import "UserInfoIconCell.h"
#import "UserSexCell.h"
#import "AddressCell.h"
#import "DetailAddressCell.h"
#import "SYChooseImageHelper.h"
#import "JYUserMode.h"
#import "ASBirthSelectSheet.h"
#import "SYTimeHelper.h"
#import "SYEditUserInfoApi.h"
#import "JYUserMode.h"
#import "SYUploadImageHelper.h"
#import "SYServiceAddressMapViewController.h"
#import "SYMeViewContrlUserInfoApi.h"

#define CELLGEIGHT 45.0*kHeightFactor

typedef NS_ENUM(NSInteger, ChangeType) {
    SYActionChangeName = 100,
    SYActionChangeEmail = 101,
    SYActionChangeDetailAddress = 102,
};

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *iconCellID = @"UserInfoIconCell";
static NSString *sexCellID = @"UserSexCell";
static NSString *addressCellID = @"AddressCell";
static NSString *detailAddressCellID = @"DetailAddressCell";
@interface BaseUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UserSexCellDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *cellIconArray;
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UITextField *ageTextFeild;
@property (nonatomic,strong) UITextView *detailAddressTextFeild;
@property (nonatomic,strong) UILabel *omtiAddressLabel;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,copy) NSString *lastSelectedDate;
@property (nonatomic,strong) NSMutableArray *tempArray;//存放textFeild，用来设置键盘

@property (nonatomic,strong) JYUserMode *tempUser;

@end

@implementation BaseUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationSYServiceAddressMapViewControllerSelectedAddressAction, @selector(changeAddressAction));
    
    //设置默认显示年龄
    self.lastSelectedDate = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self configKeyboardType];
}

- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"基本信息");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = NO;
    [self.moreBtn setTitle:Localized(@"完成") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [weakself savedUserInfomation];
        
    };
    
    [self.view addSubview:self.tableview];
}

- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"%@dsTechnician/iu?id=%@",URL_HTTP_Base_Get,[SYAppConfig shared].me.userID];
    WeakSelf;
    SYMeViewContrlUserInfoApi *api = [[SYMeViewContrlUserInfoApi alloc] initWithUrl:urlStr];
    
    [self.view showHUDWithMessage:Localized(@"")];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        JYUserMode *userMode = [JYUserMode fromJSONDictionary:request.responseObject[@"data"]];
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

#pragma mark 保存
- (void)savedUserInfomation{
    [self.view endEditing:YES];
    
    JYUserMode *appUser = [SYAppConfig shared].me;
    
    if (appUser == nil) {
        [self.view showHUDForError:Localized(@"连接不到服务器！")];
        return;
    }
    
    if (self.tempUser.realName) {
        appUser.realName = self.tempUser.realName;
    }
    if (self.tempUser.dateOfBirth) {
        appUser.dateOfBirth = self.tempUser.dateOfBirth;
    }
    if (self.tempUser.sex) {
        appUser.sex = self.tempUser.sex;
    }
    if (self.tempUser.email) {
        appUser.email = self.tempUser.email;
    }
    if (self.tempUser.address) {
        appUser.address = self.tempUser.address;
    }
    if (self.tempUser.detailAddress) {
        appUser.detailAddress = self.tempUser.detailAddress;
    }
    
    if (isNull(appUser.realName) ) {
        [self.view showHUDForError:Localized(@"请输入真实姓名")];
        return;
    }
    if (isNull(appUser.dateOfBirth) ) {
        [self.view showHUDForError:Localized(@"请选择出生日期")];
        return;
    }

    if (![appUser.email isValidEmail]) {
        [self.view showHUDForError:Localized(@"请填写正确的邮箱")];
        return;
    }
    if (isNull(appUser.address) ) {
        [self.view showHUDForError:Localized(@"请选择现住地址")];
        return;
    }
    if (isNull(appUser.detailAddress) ) {
        [self.view showHUDForError:Localized(@"请填写详细地址")];
        return;
    }
    
    [self uploadImage:self.iconImgView.image];
    [self uploadUserInfo:appUser];
}

-(void)uploadImage:(UIImage *)image
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsTechnician/setPhoto",URL_HTTP_Base];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    NSString *loginName = [SYAppConfig shared].me.loginName;
    [params setValue:isNull(loginName) == YES ? @"":loginName forKey:@"loginName"];
    
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"正在努力上传...")];
    [[SYUploadImageHelper shared] uploadImage:image withURLString:urlStr parameters:params imageKey:@"storePic" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        NSString *iconString = responseObject[@"data"];
        [SYAppConfig shared].me.portrait = iconString;
        
        PostNotificationWithName(kNotificationBaseUserInfoViewControllerRefresh);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popToRootViewControllerAnimated:YES];
            [weakself.view hideHUD];
        });

    } failure:^(NSError *error) {
        [weakself.view showHUDForError:Localized(@"图片上传失败！")];
        [weakself.view hideHUD];
    }];
}

- (void)uploadUserInfo:(JYUserMode *)appUser{
    WeakSelf;
    [[[SYEditUserInfoApi alloc] initWithUser:appUser]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         if ([request isSuccess]) {
             PostNotificationWithName(kNotificationBaseUserInfoViewControllerRefresh);
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"未连接到服务器，资料修改失败！")];
     }];
}

#pragma mark 修改头像
- (void)chooseIcon{
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
        self.iconImgView.image = image;
    }else{
        self.iconImgView.image = placeh_userAvatar;
    }
}

#pragma mark 选择出生日期
- (void)chooseBirthday{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = self.lastSelectedDate;
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        self.tempUser.dateOfBirth = dateStr;
        self.lastSelectedDate = dateStr;
        if ([self AgeFromBirthday:dateStr] >= 0) {
            self.ageTextFeild.text = [NSString stringWithFormat:@"%ld岁",[self AgeFromBirthday:dateStr]];
        }else{
            [self.view showHUDForError:Localized(@"请选择正确的出生年月")];
        }
        
    };
    [self.view addSubview:datesheet];
}

- (NSInteger)AgeFromBirthday:(NSString *)dateOfBirth{
     NSString *currentYearStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    if (dateOfBirth.length >= 4) {
        NSInteger theYear = [[dateOfBirth substringToIndex:4] integerValue];
        NSInteger currentYear = [[currentYearStr substringToIndex:4] integerValue];
        NSInteger age = currentYear - theYear;
        return age;
    }
    return 0;
}

#pragma mark UserSexCellDelegate
- (void)selectSex:(BOOL)isMan{
    if (isMan) {
        self.tempUser.sex = @0;
    } else {
        self.tempUser.sex = @1;
    }
}

#pragma mark 定位现住地址
- (void)changeAddressAction{
    self.omtiAddressLabel.text = [SYAppConfig shared].me.address;
    self.detailAddressTextFeild.text = [SYAppConfig shared].me.detailAddress;
    self.tempUser.address = self.omtiAddressLabel.text;
    self.tempUser.detailAddress = self.detailAddressTextFeild.text;
}

- (void)gettingAddress{
    if ([[SYAppConfig shared] isOpenLocationService]) {
        SYServiceAddressMapViewController *mapVC = [[SYServiceAddressMapViewController alloc] init];
        [self.navigationController pushViewController:mapVC animated:YES];
    } else {
        [[SYAppConfig shared] tipsOpenLocation];
    }
    
}
#pragma mark UITabelViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [self.dataArray objectAtIndex:section];
    return array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //修改头像
                    [self chooseIcon];
                }
                    break;
                case 1:
                {
                    //修改姓名
                }
                    break;
                case 2:
                {
                    //选择年龄
                    [self chooseBirthday];
                }
                    break;
                case 3:
                {
                    //选择性别
                }
                    break;
                case 4:
                {
                    //修改邮箱
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //修改住址
                    [self gettingAddress];
                }
                    break;
                case 1:
                {
                    //输入地址具体信息
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYUserMode *user = [SYAppConfig shared].me;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return [self iconCellInTableView:tableView atIndexPath:indexPath];
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.tag = SYActionChangeName;
                    [self.tempArray addObject:cell.valueTextFeild];
                    [cell.valueTextFeild addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventEditingChanged];
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入姓名" value:user.realName];
                    return cell;
                }
                    break;
                case 2:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.text = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
                    self.ageTextFeild = cell.valueTextFeild;
                    NSString *ageStr = [NSString stringWithFormat:@"%ld岁",[self AgeFromBirthday:user.dateOfBirth]];
                    if (isNull(user.dateOfBirth)) {
                        ageStr = @"请选择出生日期";
                    }
                    [self configTextFeildCell:cell imgViewIsHiden:NO userInteraction:NO placeHolder:@"请选择出生日期" value:ageStr];
                    return cell;
                }
                    break;
                case 3:
                {
                    return [self sexCellInTableView:tableView atIndexPath:indexPath];
                }
                    break;
                case 4:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.tag = SYActionChangeEmail;
                    [self.tempArray addObject:cell.valueTextFeild];
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入邮箱" value:user.email];
                    return cell;
                }
                    break;
                    
                default:
                    return [UITableViewCell new];
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return [self addressCellInTableView:tableView atIndexPath:indexPath];
                }
                    break;
                case 1:
                {
                    DetailAddressCell *cell = [self detailAddessCellInTableView:tableView atIndexPath:indexPath];
                    [self.tempArray addObject:cell.contentTextView];
                    if (!isNull(user.detailAddress)) {
                        cell.contentTextView.text = user.detailAddress;
                        cell.placeHolderLabel.hidden = YES;
                    }else{
                        cell.placeHolderLabel.hidden = NO;
                    }
                    
                    cell.contentTextView.tag = SYActionChangeDetailAddress;
                    return cell;
                }
                    break;
                    
                default:
                {
                    return [UITableViewCell new];
                }
                    break;
            }
        }
            break;
            
        default:
            return [UITableViewCell new];
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //修改头像cell高度
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 65;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        NSString *addressString = [SYAppConfig shared].me.address;
        return CELLGEIGHT + [NSString heightForString:addressString labelWidth:KscreenWidth - 200 fontOfSize:17];
    }
    return CELLGEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 20)];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UserInfoIconCell *)iconCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)idexPath{
    UserInfoIconCell *cell = [tableView dequeueReusableCellWithIdentifier:iconCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *iconString = [SYAppConfig shared].me.portrait;
    self.iconImgView = cell.userIconImgView;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:placeh_userAvatar];

    return cell;
}

- (UserSexCell *)sexCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserSexCell *cell = [tableView dequeueReusableCellWithIdentifier:sexCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    return cell;
}

- (AddressCell *)addressCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.omtiAddressLabel.text = [SYAppConfig shared].me.address;
    self.omtiAddressLabel = cell.omtiAddressLabel;
    self.omtiAddressLabel.numberOfLines = 2;
    
    return cell;
}

- (DetailAddressCell *)detailAddessCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath{
    DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:detailAddressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentTextView.delegate = self;
    self.placeHolderLabel = cell.placeHolderLabel;
    self.detailAddressTextFeild = cell.contentTextView;
    return cell;
}

- (UserInfoTextFeildCell *)textFeildCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserInfoTextFeildCell *cell = [tableView dequeueReusableCellWithIdentifier:textFeildCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)configTextFeildCell:(UserInfoTextFeildCell *)cell imgViewIsHiden:(BOOL)isHiden userInteraction:(BOOL)canEdit placeHolder:(NSString *)placeHolder value:(NSString *)contentStr{
    cell.valueTextFeild.delegate = self;
    cell.valueTextFeild.keyboardType = UIKeyboardTypeDefault;
    
    cell.rightImgView.hidden = isHiden;
    cell.valueTextFeild.userInteractionEnabled = canEdit;
    cell.valueTextFeild.placeholder = Localized(placeHolder);
    cell.valueTextFeild.text = contentStr;
}

- (void)nameChanged:(UITextField *)field {
    NSString *toBeString = field.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [field markedTextRange]; // 获取高亮部分
        UITextPosition *position = [field positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 15) {
                field.text = [toBeString substringToIndex:15];
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 15) {
            field.text = [toBeString substringToIndex: 15];
            [self.view showHUDForError:Localized(@"最多只能输入15个字")];
        }
    }
    
    NSString *str = [field.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.tempUser.realName = str.length>0 ? field.text:@"";
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.tableview.scrollEnabled = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length > 0;
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.tableview.scrollEnabled = YES;
    
    switch (textView.tag) {
        case SYActionChangeDetailAddress:
        {
            self.tempUser.detailAddress = textView.text;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.tableview.scrollEnabled = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.tableview.scrollEnabled = YES;
    
    switch (textField.tag) {
        case SYActionChangeName:
        {
            self.tempUser.realName = textField.text;
        }
            break;
        case SYActionChangeEmail:
        {
            NSString *email = textField.text;
            if (![email isValidEmail]) {
                [self.view showHUDForError:Localized(@"请输入正确的邮箱")];
            }
            self.tempUser.email = textField.text;
        }
            break;
        default:
            break;
    }
}

#pragma mark 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65*kHeightFactor, KscreenWidth, KscreenHeight - 65*kHeightFactor)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = kAppColorBackground;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerNib:[UINib nibWithNibName:textFeildCellID bundle:nil] forCellReuseIdentifier:textFeildCellID];
        [_tableview registerNib:[UINib nibWithNibName:iconCellID bundle:nil] forCellReuseIdentifier:iconCellID];
        [_tableview registerNib:[UINib nibWithNibName:sexCellID bundle:nil] forCellReuseIdentifier:sexCellID];
        [_tableview registerNib:[UINib nibWithNibName:addressCellID bundle:nil] forCellReuseIdentifier:addressCellID];
        [_tableview registerNib:[UINib nibWithNibName:detailAddressCellID bundle:nil] forCellReuseIdentifier:detailAddressCellID];
        _tableview.scrollEnabled = YES;
    }
    return _tableview;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[@"修改头像",@"姓名",@"年龄",@"性别",@"邮箱"],@[@"现住地址",@"请输入楼栋、门牌号等具体位置"]]];
    }
    return _dataArray;
}

- (NSArray *)cellIconArray{
    if (!_cellIconArray) {
        _cellIconArray = @[@"地点",@"输入填写"];
    }
    return _cellIconArray;
}

- (JYUserMode *)tempUser{
    if (!_tempUser) {
        _tempUser = [[JYUserMode alloc] init];
    }
    return _tempUser;
}

- (NSMutableArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
}

- (void)configKeyboardType{
    for (int i = 0; i < self.tempArray.count; i ++) {
        switch (i) {
            case 0:
            {
                UITextField *textFeild = [self.tempArray objectAtIndex:i];
                textFeild.keyboardType = UIKeyboardTypeDefault;
            }
                break;
            case 1:
            {
                UITextField *textFeild = [self.tempArray objectAtIndex:i];
                textFeild.keyboardType = UIKeyboardTypeEmailAddress;
            }
                break;
            case 2:
            {
                UITextView *textView = [self.tempArray objectAtIndex:i];
                textView.keyboardType = UIKeyboardTypeDefault;
            }
                break;
                
            default:
                break;
        }
    }
}

@end
