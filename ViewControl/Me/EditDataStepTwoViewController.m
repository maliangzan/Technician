//
//  EditDataStepTwoViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EditDataStepTwoViewController.h"
#import "EditDataStepThreeViewController.h"
#import "UserInfoTextFeildCell.h"
#import "TextViewCell.h"
#import "SYServiceItemCell.h"
#import "SYItemSheet.h"
#import "JYUserMode.h"
#import "SYServiceItemsApi.h"

#define SECTION_HEAD_HEIGHT 10

typedef NS_ENUM(NSInteger, ChangeType) {
    SYActionChangeJobYear = 105,
    SYActionChangeUniversity = 106,
    SYActionChangeGoodAt = 107,
};

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *textViewCellID = @"TextViewCell";
static NSString *serviceItemCellID = @"SYServiceItemCell";
@interface EditDataStepTwoViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) NSMutableArray *serviceItemArray;//服务项目
@property (nonatomic,strong) NSMutableArray *selectedServiceItemArray;//选中的服务项目
@property (nonatomic,strong) NSMutableArray *profitionalLevelArray;//职级
@property (nonatomic,strong) NSMutableArray *tempArray;//保存textFeild，设置keyBoardType
@property (nonatomic,strong) JYUserMode *tempUser;
@end

@implementation EditDataStepTwoViewController

- (instancetype)initWithTempUser:(JYUserMode *)tempUser{
    if (self = [super init]) {
        self.tempUser = tempUser;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationSYItemSheetSelectedService, @selector(selectedItemService:));
    ObserveNotification(kNotificationSYItemSheetCancelSelectedService,@selector(cancelSelectedService:));
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configKeyBoardType];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadServiceItem{
 //http://120.76.119.189:8989/Health/app/dsServiceCategory/queryList
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsServiceCategory/queryList",URL_HTTP_Base];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    SYServiceItemsApi *api = [[SYServiceItemsApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.serviceItemArray removeAllObjects];
        for (NSDictionary *dic in request.responseObject[@"data"]) {
            [weakself.serviceItemArray addObject:dic[@"name"]];
        }
        
        [weakself selectService];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)buildUI{
    [super buildUI];
    
    WeakSelf;
    self.nextStep = ^{
        [weakself nextStepAction];
    };
}


#pragma mark superMethod
- (void)congigHeadView{
    [self.headView.stepOneBtn setBackgroundImage:PNGIMAGE(@"complete") forState:(UIControlStateNormal)];
    [self.headView.stepTwoBtn setBackgroundImage:PNGIMAGE(@"current_selected2") forState:(UIControlStateNormal)];
    [self.headView.stepThreeBtn setBackgroundImage:PNGIMAGE(@"current_unselected3") forState:(UIControlStateNormal)];
}

- (void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:textFeildCellID bundle:nil] forCellReuseIdentifier:textFeildCellID];
    [self.tableView registerNib:[UINib nibWithNibName:textViewCellID bundle:nil] forCellReuseIdentifier:textViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:serviceItemCellID bundle:nil] forCellReuseIdentifier:serviceItemCellID];

}

#pragma mark Method
- (void)configKeyBoardType{
    for (int i = 0; i < self.tempArray.count; i ++) {
        switch (i) {
            case 0:
            {
                UITextField *textFeild = [self.tempArray objectAtIndex:i];
                textFeild.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 1:
            {
                UITextField *textFeild = [self.tempArray objectAtIndex:i];
                textFeild.keyboardType = UIKeyboardTypeDefault;
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

- (void)nextStepAction{
    [self.view endEditing:YES];
    
    if (isNull(self.tempUser.serviceItem) && isNull([SYAppConfig shared].me.serviceItem)) {
        [self.view showHUDForError:Localized(@"请选择职业类型")];
        return;
    }
    if (isNull(self.tempUser.level) && isNull([SYAppConfig shared].me.level)) {
        [self.view showHUDForError:Localized(@"请选择职级")];
        return;
    }
    if (isNull([self.tempUser.workingYear stringValue]) && isNull([[SYAppConfig shared].me.workingYear stringValue])) {
        [self.view showHUDForError:Localized(@"请输入工作年限")];
        return;
    }
    if (isNull(self.tempUser.university)&& isNull([SYAppConfig shared].me.university)) {
        [self.view showHUDForError:Localized(@"请输入毕业院校")];
        return;
    }
    if (isNull(self.tempUser.goodAtIntroduction) && isNull([SYAppConfig shared].me.goodAtIntroduction)) {
        [self.view showHUDForError:Localized(@"请输入擅长简介")];
        return;
    }
    
    EditDataStepThreeViewController *nextVC = [[EditDataStepThreeViewController alloc] initWithTempUser:self.tempUser];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (UserInfoTextFeildCell *)gettingTextFeildCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserInfoTextFeildCell *cell = [tableView dequeueReusableCellWithIdentifier:textFeildCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (SYServiceItemCell *)gettingServiceItemCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYServiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceItemCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (TextViewCell *)gettingTextViewCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textViewCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectedItemService:(NSNotification *)noti{
    if (![self.selectedServiceItemArray containsObject:noti.userInfo]) {
        [self.selectedServiceItemArray addObject:noti.userInfo];
    }
    self.tempUser.serviceItem = [self.selectedServiceItemArray componentsJoinedByString:@"/"];
}

- (void)cancelSelectedService:(NSNotification *)noti{
    if ([self.selectedServiceItemArray containsObject:noti.userInfo]) {
        [self.selectedServiceItemArray removeObject:noti.userInfo];
        self.tempUser.serviceItem = [self.selectedServiceItemArray componentsJoinedByString:@"/"];
    }
}

#pragma mark 选择服务项目
- (void)selectService{
    WeakSelf;
    SYItemSheet *servicePicker = [[SYItemSheet alloc] initWithFrame:self.view.bounds actionType:(ItemActionTypeSelectServiceType) title:Localized(@"请选择职业类型")];
    servicePicker.dataArray = self.serviceItemArray;
    servicePicker.pickerDone = ^(NSString *selectedStr) {
        [weakself.tableView reloadData];
    };
    [self.view addSubview:servicePicker];
}

#pragma mark 选择职级
- (void)selectProfisinalLevel{
    WeakSelf;
    SYItemSheet *servicePicker = [[SYItemSheet alloc] initWithFrame:self.view.bounds actionType:(ItemActionTypeSelectProfessionalLevel) title:Localized(@"您的职级")];
    servicePicker.dataArray = self.profitionalLevelArray;
    servicePicker.pickerDone = ^(NSString *selectedStr) {
        self.tempUser.level = selectedStr;
        [weakself.tableView reloadData];
    };
    [self.view addSubview:servicePicker];
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
        case SYActionChangeGoodAt:
        {
            self.tempUser.goodAtIntroduction = textView.text;
            self.placeHolderLabel.hidden = !isNull(textView.text);
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
        case SYActionChangeJobYear:
        {
            NSString *jobYear = textField.text;
            if (!([jobYear integerValue] <= 40 && [jobYear integerValue] >=0)) {
                [self.view showHUDForError:Localized(@"工作年限应小于40")];
                textField.text = @"40";
                return;
            }
            self.tempUser.workingYear = [NSNumber numberWithInteger:[textField.text integerValue]];
        }
            break;
        case SYActionChangeUniversity:
        {
            self.tempUser.university = textField.text;
        }
            break;
        default:
            break;
    }
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

            switch (indexPath.row) {
                case 0:
                {
                    SYServiceItemCell *cell = [self gettingServiceItemCellInTableView:tableView atIndexPath:indexPath];
                    if (isNull(self.tempUser.serviceItem)) {
                        self.tempUser.serviceItem = [SYAppConfig shared].me.serviceItem;
                    }

                    if (isNull(self.tempUser.serviceItem)) {
                        cell.valueLabel.text = Localized(@"请选择职业类型");
                    } else {
                        cell.valueLabel.text = self.tempUser.serviceItem;
                    }
                    
                    return cell;
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = NO;
                    cell.valueTextFeild.userInteractionEnabled = NO;
                    if (!isNull(self.tempUser.level)) {
                        cell.valueTextFeild.text = self.tempUser.level;
                    }else{
                        cell.valueTextFeild.text = [SYAppConfig shared].me.level;
                        self.tempUser.level = [SYAppConfig shared].me.level;
                    }
                    
                    cell.valueTextFeild.placeholder = Localized(@"您的职级");
                    return cell;
                }
                    break;
                case 2:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.userInteractionEnabled = YES;
                    cell.valueTextFeild.delegate = self;
                    cell.valueTextFeild.tag = SYActionChangeJobYear;
                    [self.tempArray addObject:cell.valueTextFeild];
                    NSString *year = [[SYAppConfig shared].me.workingYear stringValue];
                    if (year.length) {
                        cell.valueTextFeild.text = [NSString stringWithFormat:@"%@ 年",year];
                    }
                    cell.valueTextFeild.placeholder = Localized(@"请输入工作年限");
                    return cell;
                }
                    break;
                case 3:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.userInteractionEnabled = YES;
                    cell.valueTextFeild.delegate = self;
                    cell.valueTextFeild.tag = SYActionChangeUniversity;
                    [self.tempArray addObject:cell.valueTextFeild];
                    cell.valueTextFeild.text = [SYAppConfig shared].me.university;
                    cell.valueTextFeild.placeholder = Localized(@"请输入毕业院校");
                    return cell;
                }
                    break;
                case 4:
                {
                    TextViewCell *cell = [self gettingTextViewCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextView.userInteractionEnabled = YES;
                    cell.valueTextView.delegate = self;
                    cell.valueTextView.tag = SYActionChangeGoodAt;
                    [self.tempArray addObject:cell.valueTextView];
                    if ([SYAppConfig shared].me.goodAtIntroduction.length > 0) {
                        cell.valueTextView.text = [SYAppConfig shared].me.goodAtIntroduction;
                        cell.placeHolderLabel.hidden = YES;
                    }else{
                        cell.placeHolderLabel.hidden = NO;
                    }
                    self.placeHolderLabel = cell.placeHolderLabel;
                    self.placeHolderLabel.text = Localized(@"擅长技能简单介绍（150个字以内）");
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }

    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self loadServiceItem];
        }
            break;
        case 1:
        {
            [self selectProfisinalLevel];
        }
            break;
        case 2:
        {

//            cell.valueTextFeild.text = @"5  年";
        }
            break;
        case 3:
        {

//            cell.valueTextFeild.text = @"湖南岳阳卫生学校";
        }
            break;
        case 4:
        {

//            self.placeHolderLabel.text = @"擅长技能简单介绍（150个字以内）";
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        //简介cell高度
        return 150;
    }else if (indexPath.row == 0){
        NSString *serciceItemString = isNull(self.tempUser.serviceItem) == YES ? [SYAppConfig shared].me.serviceItem : self.tempUser.serviceItem;
        return 45 + [NSString heightForString:serciceItemString labelWidth:KscreenWidth - 143 fontOfSize:17];
    }else{
        //第一段cell高度
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, SECTION_HEAD_HEIGHT)];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEAD_HEIGHT;

}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[Localized(@"职业类别"),Localized(@"职级"),Localized(@"工作经验"),Localized(@"毕业院校"),Localized(@"擅长简介")]];
    }
    return _dataArray;
}

- (NSMutableArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
}

- (NSMutableArray *)serviceItemArray{
//    WithArray:@[@"催乳调理",@"中医理疗",@"小儿推拿",@"子宫修复",@"营养监测",@"形体修复"]
    if (!_serviceItemArray) {
        _serviceItemArray = [NSMutableArray array];
    }
    return _serviceItemArray;
}

- (NSMutableArray *)selectedServiceItemArray{
    if (!_selectedServiceItemArray) {
        _selectedServiceItemArray = [NSMutableArray array];
    }
    return _selectedServiceItemArray;
}

- (NSMutableArray *)profitionalLevelArray{
    if (!_profitionalLevelArray) {
        _profitionalLevelArray = [NSMutableArray arrayWithArray:@[@"高级",@"中级",@"初级"]];
    }
    return _profitionalLevelArray;
}

@end
