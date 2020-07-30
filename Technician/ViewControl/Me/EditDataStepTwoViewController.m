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
#import "SYItemSheet.h"
#import "JYUserMode.h"

#define SECTION_HEAD_HEIGHT 10

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *textViewCellID = @"TextViewCell";
@interface EditDataStepTwoViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UILabel *placeHolderLabel;
//服务项目
@property (nonatomic,strong) NSMutableArray *serviceItemArray;
//选中的服务项目
@property (nonatomic,strong) NSMutableArray *selectedServiceItemArray;
//职级
@property (nonatomic,strong) NSMutableArray *profitionalLevelArray;

@end

@implementation EditDataStepTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationSYItemSheetSelectedService, @selector(selectedItemService:));
    ObserveNotification(kNotificationSYItemSheetCancelSelectedService,@selector(cancelSelectedService:));
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
}

#pragma mark Method
- (void)nextStepAction{
    EditDataStepThreeViewController *nextVC = [[EditDataStepThreeViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (UserInfoTextFeildCell *)gettingTextFeildCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UserInfoTextFeildCell *cell = [tableView dequeueReusableCellWithIdentifier:textFeildCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (TextViewCell *)gettingTextViewCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textViewCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectedItemService:(NSNotification *)noti{
    [self.selectedServiceItemArray addObject:noti.userInfo];
    [SYAppConfig shared].me.serviceItem = [self.selectedServiceItemArray componentsJoinedByString:@"/"];
}

- (void)cancelSelectedService:(NSNotification *)noti{
    if ([self.selectedServiceItemArray containsObject:noti.userInfo]) {
        [self.selectedServiceItemArray removeObject:noti.userInfo];
        [SYAppConfig shared].me.serviceItem = [self.selectedServiceItemArray componentsJoinedByString:@"/"];
    }
}

#pragma mark 选择服务项目
- (void)selectService{
    WeakSelf;
    SYItemSheet *servicePicker = [[SYItemSheet alloc] initWithFrame:self.view.bounds actionType:(ItemActionTypeSelectServiceType) title:Localized(@"请选择服务项目")];
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
        [SYAppConfig shared].me.profitionalLevel = selectedStr;
        [weakself.tableView reloadData];
    };
    [self.view addSubview:servicePicker];
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
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = NO;
                    cell.valueTextFeild.userInteractionEnabled = NO;
                    cell.valueTextFeild.text = [SYAppConfig shared].me.serviceItem;
                    cell.valueTextFeild.placeholder = Localized(@"请选择服务项目");
                    return cell;
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = NO;
                    cell.valueTextFeild.userInteractionEnabled = NO;
                    cell.valueTextFeild.text = [SYAppConfig shared].me.profitionalLevel;
                    cell.valueTextFeild.placeholder = Localized(@"您的职级");
                    return cell;
                }
                    break;
                case 2:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.userInteractionEnabled = YES;
                    NSString *year = [SYAppConfig shared].me.workingYear;
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
                    cell.valueTextFeild.text = [SYAppConfig shared].me.university;
                    cell.valueTextFeild.placeholder = Localized(@"请输入毕业院校");
                    return cell;
                }
                    break;
                case 4:
                {
                    TextViewCell *cell = [self gettingTextViewCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextView.userInteractionEnabled = YES;
                    if ([SYAppConfig shared].me.goodAtIntroduction.length) {
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
            [self selectService];
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
        return 150 *kHeightFactor;
    }else{
        //第一段cell高度
        return 45 * kHeightFactor;
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

- (NSMutableArray *)serviceItemArray{
    if (!_serviceItemArray) {
        _serviceItemArray = [NSMutableArray arrayWithArray:@[@"催乳调理",@"小儿推拿",@"中医理疗",@"小儿推拿",@"子宫修复",@"营养监测",@"形体修复"]];
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
