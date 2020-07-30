//
//  EditDataStepOneViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EditDataStepOneViewController.h"
#import "EditDataStepTwoViewController.h"
#import "UserSexCell.h"
#import "UserInfoTextFeildCell.h"
#import "AddressCell.h"
#import "DetailAddressCell.h"
#import "SYTimeHelper.h"
#import "SYChooseImageHelper.h"
#import "ASBirthSelectSheet.h"
#import "JYUserMode.h"
#import "SYServiceAddressMapViewController.h"

#define CELLGEIGHT 44.0

typedef NS_ENUM(NSInteger, ChangeType) {
    SYActionChangeName = 100,
    SYActionChangeEmail = 101,
    SYActionChangeDetailAddress = 102,
    SYActionChangeIDNum = 103,
};

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *sexCellID = @"UserSexCell";
static NSString *addressCellID = @"AddressCell";
static NSString *detailAddressCellID = @"DetailAddressCell";

@interface EditDataStepOneViewController ()<UITextViewDelegate,UITextFieldDelegate,UserSexCellDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITextField *ageTextFeild;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,copy) NSString *lastSelectedDate;
@property (nonatomic,strong) NSMutableArray *tempArray;//保存textFeild，用来设置keyboardtype
@property (nonatomic,strong) JYUserMode *tempUser;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UITextView *detailAddressTextView;
@property (nonatomic,assign) BOOL isFirstEdit;


@end

@implementation EditDataStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationSYServiceAddressMapViewControllerSelectedAddressAction, @selector(changeAddressAction));
    
    [self bindData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configKeyBoardType];
    self.placeHolderLabel.hidden = !isNull(self.detailAddressTextView.text);
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark superMethod
- (void)buildUI{
    [super buildUI];
    
    WeakSelf;
    self.nextStep = ^{
        [weakself nextStepAction];
    };
}

- (void)congigHeadView{
    [self.headView.stepOneBtn setBackgroundImage:PNGIMAGE(@"current_selected1") forState:(UIControlStateNormal)];
    [self.headView.stepTwoBtn setBackgroundImage:PNGIMAGE(@"current_unselected2") forState:(UIControlStateNormal)];
    [self.headView.stepThreeBtn setBackgroundImage:PNGIMAGE(@"current_unselected3") forState:(UIControlStateNormal)];
}

#pragma mark Method
- (void)bindData{
    //设置默认显示年龄
    self.lastSelectedDate = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    self.isFirstEdit = YES;
}

- (void)changeAddressAction{
    self.addressLabel.text = [SYAppConfig shared].me.address;
    self.detailAddressTextView.text = [SYAppConfig shared].me.detailAddress;
    self.tempUser.address = [SYAppConfig shared].me.address;
    self.tempUser.detailAddress = [SYAppConfig shared].me.detailAddress;
    _isFirstEdit = NO;
    [self.tableView reloadData];
}

- (void)configKeyBoardType{
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
                UITextField *textFeild = [self.tempArray objectAtIndex:i];
                textFeild.keyboardType = UIKeyboardTypeDefault;
            }
                break;
            case 3:
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

- (void)nextStepAction{
    
    [self.view endEditing:YES];
    if (isNull(self.tempUser.realName)) {
        [self.view showHUDForError:Localized(@"请输入姓名")];
        return;
    }
    if (isNull(self.tempUser.dateOfBirth)) {
        [self.view showHUDForError:Localized(@"请选择出生日期")];
        return;
    }
    
    if (isNull(self.tempUser.email)) {
        [self.view showHUDForError:Localized(@"请输入邮箱")];
        return;
    }
    
    if (![self.tempUser.email isValidEmail]) {
        [self.view showHUDForError:Localized(@"您输入的邮箱无效！")];
        return;
    }
    
    if (isNull(self.tempUser.idCardNo)) {
        [self.view showHUDForError:Localized(@"请输入身份证号码")];
        return;
    }
    
    if (!IsIdentityCard(self.tempUser.idCardNo)) {
        [self.view showHUDForError:Localized(@"您输入的身份证号无效！")];
        return;
    }
    
    if (isNull(self.tempUser.address)) {
        [self.view showHUDForError:Localized(@"请选择地址")];
        return;
    }
    
    if (isNull(self.tempUser.detailAddress)) {
        [self.view showHUDForError:Localized(@"请输入详细地址")];
        return;
    }
    
    EditDataStepTwoViewController *nextVC = [[EditDataStepTwoViewController alloc] initWithTempUser:self.tempUser];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:textFeildCellID bundle:nil] forCellReuseIdentifier:textFeildCellID];
    [self.tableView registerNib:[UINib nibWithNibName:sexCellID bundle:nil] forCellReuseIdentifier:sexCellID];
    [self.tableView registerNib:[UINib nibWithNibName:addressCellID bundle:nil] forCellReuseIdentifier:addressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:detailAddressCellID bundle:nil] forCellReuseIdentifier:detailAddressCellID];
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
                    //修改姓名
                }
                    break;
                case 1:
                {
                    //选择年龄
                    [self chooseBirthday];
                }
                    break;
                case 2:
                {
                    //选择性别
                }
                    break;
                case 3:
                {
                    //修改邮箱
                }
                    break;
                case 4:
                {
                    //身份证号
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
    JYUserMode *appUser = [SYAppConfig shared].me;
    ;
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.tag = SYActionChangeName;
                    [self.tempArray addObject:cell.valueTextFeild];
                    [cell.valueTextFeild addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventEditingChanged];
                    if (_isFirstEdit) {
                        self.tempUser.realName = appUser.realName;
                    }
                    
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入姓名" value:self.tempUser.realName];
                    return cell;
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.text = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
                    self.ageTextFeild = cell.valueTextFeild;
                    if (_isFirstEdit) {
                        self.tempUser.dateOfBirth = appUser.dateOfBirth;
                    }
                    
                    NSInteger age = [self ageFromDateOfBirthday:self.tempUser.dateOfBirth];
                    if (isNull(self.tempUser.dateOfBirth)) {
                        age = 0;
                    }
                    [self configTextFeildCell:cell imgViewIsHiden:NO userInteraction:NO placeHolder:@"请选择出生日期" value:[NSString stringWithFormat:@"%ld岁",age]];
                    return cell;
                }
                    break;
                case 2:
                {
                    return [self sexCellInTableView:tableView atIndexPath:indexPath];
                }
                    break;
                case 3:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.keyboardType = UIKeyboardTypeEmailAddress;
                    cell.valueTextFeild.tag = SYActionChangeEmail;
                    [self.tempArray addObject:cell.valueTextFeild];
                    if (_isFirstEdit) {
                        self.tempUser.email = appUser.email;
                    }
                    
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入邮箱" value:self.tempUser.email];
                    return cell;
                }
                    break;
                case 4:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.keyboardType = UIKeyboardTypeDefault;
                    cell.valueTextFeild.tag = SYActionChangeIDNum;
                    cell.valueTextFeild.font = [UIFont systemFontOfSize:16];
                    [self.tempArray addObject:cell.valueTextFeild];
                    if (_isFirstEdit) {
                        self.tempUser.idCardNo = appUser.idCardNo;
                    }
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:Localized(@"身份证号") value:self.tempUser.idCardNo];
                    
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
                    cell.contentTextView.tag = SYActionChangeDetailAddress;
                    self.detailAddressTextView = cell.contentTextView;
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
        return 60 * kWidthFactor;
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
    if (section == 1) {
        return 20;
    }
    return 10;
}

- (UserSexCell *)sexCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserSexCell *cell = [tableView dequeueReusableCellWithIdentifier:sexCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (cell.manBtn.selected) {
        self.tempUser.sex = @0;
    }else{
        self.tempUser.sex = @1;
    }
    return cell;
}

- (AddressCell *)addressCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isFirstEdit) {
        self.tempUser.address = [SYAppConfig shared].me.address;
    }
    cell.omtiAddressLabel.text = self.tempUser.address;
    self.addressLabel = cell.omtiAddressLabel;
    return cell;
}

- (DetailAddressCell *)detailAddessCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath{
    DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:detailAddressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentTextView.delegate = self;
    self.placeHolderLabel = cell.placeHolderLabel;
    if (!isNull([SYAppConfig shared].me.detailAddress)) {
        if (_isFirstEdit) {
            self.tempUser.detailAddress = [SYAppConfig shared].me.detailAddress;
        }
        cell.contentTextView.text = self.tempUser.detailAddress;
    }
    cell.placeHolderLabel.hidden = !isNull(cell.contentTextView.text);
    
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
    self.tableView.scrollEnabled = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length > 0;
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.tableView.scrollEnabled = YES;
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
    self.tableView.scrollEnabled = NO;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.tableView.scrollEnabled = YES;

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
        case SYActionChangeIDNum:
        {
            NSString *idNum = textField.text;
            if (!IsIdentityCard(idNum)) {
                [self.view showHUDForError:Localized(@"请输入正确的身份证号")];
            }
            self.tempUser.idCardNo = idNum;
            
        }
            break;
        default:
            break;
    }
}

#pragma mark 选择出生日期
- (void)chooseBirthday{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = self.lastSelectedDate;
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        self.lastSelectedDate = dateStr;
        
        NSInteger age = [self ageFromDateOfBirthday:dateStr];
        NSString *ageStr = [NSString stringWithFormat:@"%ld岁",age];
        if (age >= 0) {
            self.ageTextFeild.text = ageStr;
            self.tempUser.dateOfBirth = dateStr;
        }else{
            [self.view showHUDForError:Localized(@"请选择正确的出生年月")];
        }
        
    };
    [self.view addSubview:datesheet];
}

- (NSInteger)ageFromDateOfBirthday:(NSString *)dateOfBirthday{
    NSString *currentYearStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    if (dateOfBirthday.length >= 4 && currentYearStr.length >= 4) {
        NSInteger theYear = [[dateOfBirthday substringToIndex:4] integerValue];
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
- (void)gettingAddress{
    if ([[SYAppConfig shared] isOpenLocationService]) {
        SYServiceAddressMapViewController *mapVC = [[SYServiceAddressMapViewController alloc] init];
//        mapVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mapVC animated:YES];
    } else {
        [[SYAppConfig shared] tipsOpenLocation];
    }
    
}


#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[@"姓名",@"年龄",@"性别",@"邮箱",@"身份证号"],@[@"现住地址",@"请输入楼栋、门牌号等具体位置"]]];
    }
    return _dataArray;
}

- (NSMutableArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
}

- (JYUserMode *)tempUser{
    if (!_tempUser) {
        _tempUser = [[JYUserMode alloc] init];
    }
    return _tempUser;
}

@end
