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
#import "NSString+JMValid.h"

#define CELLGEIGHT 45.0*kHeightFactor

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
@property (nonatomic,strong) JYUserMode *user;
@end

@implementation EditDataStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置默认显示年龄
    self.lastSelectedDate = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
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
- (void)nextStepAction{
    EditDataStepTwoViewController *nextVC = [[EditDataStepTwoViewController alloc] init];
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
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.tag = SYActionChangeName;
                    [cell.valueTextFeild addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventEditingChanged];
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入姓名" value:@""];
                    return cell;
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.text = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
                    self.ageTextFeild = cell.valueTextFeild;
                    [self configTextFeildCell:cell imgViewIsHiden:NO userInteraction:NO placeHolder:@"请选择出生日期" value:@""];
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
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:@"请输入邮箱" value:@""];
                    return cell;
                }
                    break;
                case 4:
                {
                    UserInfoTextFeildCell *cell = [self textFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.keyboardType = UIKeyboardTypeNumberPad;
                    cell.valueTextFeild.tag = SYActionChangeIDNum;
                    [self configTextFeildCell:cell imgViewIsHiden:YES userInteraction:YES placeHolder:Localized(@"身份证号") value:@""];
                    
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
        return 60 * kWidthFactor;
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
    
    return cell;
}

- (AddressCell *)addressCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (DetailAddressCell *)detailAddessCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath{
    DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:detailAddressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentTextView.delegate = self;
    self.placeHolderLabel = cell.placeHolderLabel;
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
            [SVProgressHUD showErrorWithStatus:@"最多只能输入15个字"];
        }
    }
    
    NSString *str = [field.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.user.name = str.length>0 ? field.text:@"";
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length > 0;
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    switch (textView.tag) {
        case SYActionChangeDetailAddress:
        {
            Log(@"SYActionChangeDetailAddress %@",textView.text);
        }
            break;
            
        default:
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
        case SYActionChangeName:
        {
            Log(@"SYActionChangeName %@",textField.text);
        }
            break;
        case SYActionChangeEmail:
        {
            NSString *email = textField.text;
            if (![email isValidEmail]) {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
            }
            Log(@"SYActionChangeEmail %@",textField.text);
        }
            break;
        case SYActionChangeIDNum:
        {
            NSString *idNum = textField.text;
            Log(@"SYActionChangeIDNum %@",textField.text);
        }
            break;
        default:
            break;
    }
}

#pragma mark 保存
- (void)savedUserInfomation{
    NSLog(@"保存个人信息");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 选择出生日期
- (void)chooseBirthday{
    NSString *currentYearStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = self.lastSelectedDate;
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        self.lastSelectedDate = dateStr;
        NSInteger theYear = [[dateStr substringToIndex:4] integerValue];
        NSInteger currentYear = [[currentYearStr substringToIndex:4] integerValue];
        NSInteger age = currentYear - theYear;
        NSString *ageStr = [NSString stringWithFormat:@"%ld岁",age];
        if (age >= 0) {
            self.ageTextFeild.text = ageStr;
        }else{
            [SVProgressHUD showErrorWithStatus:@"请选择正确的出生年月"];
        }
        
    };
    [self.view addSubview:datesheet];
}

#pragma mark UserSexCellDelegate
- (void)selectSex:(BOOL)isMan{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"性别%d",isMan] ];
}

#pragma mark 定位现住地址
- (void)gettingAddress{
    [SVProgressHUD showErrorWithStatus:@"定位现住地址"];
}


#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[@"姓名",@"年龄",@"性别",@"邮箱",@"身份证号"],@[@"现住地址",@"请输入楼栋、门牌号等具体位置"]]];
    }
    return _dataArray;
}

@end
