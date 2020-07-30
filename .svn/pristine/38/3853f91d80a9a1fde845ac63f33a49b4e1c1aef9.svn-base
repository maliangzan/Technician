//
//  SetViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SetViewController.h"
#import "LabelButtonCell.h"
#import "LabelSwitchCell.h"
#import "AboutUsViewController.h"
#import "ServiceStandardViewController.h"
#import "EditPasswordViewController.h"
#import "ChangePhoneNumViewController.h"

#define CELL_HEIGHT 44

static NSString *lableBtnCellID = @"LabelButtonCell";
static NSString *labelSwitchCellID = @"LabelSwitchCell";
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,LabelButtonCellDelegate,LabelSwitchCellDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArray;
@property (nonatomic,strong) UIButton *loginOutBtn;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"设置";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kCustomNavHeight);
        make.bottom.equalTo(self.view);
        
    }];
}

#pragma mark method
- (UITableViewCell *)configCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[self.titleArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    //add line
    if (!(indexPath.section == 2 && indexPath.row ==  4)) {
        //安全退出不需要下划线
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, CELL_HEIGHT - 1, KscreenWidth - 20, 1)];
        line.backgroundColor = kAppColorBackground;
        [cell addSubview:line];
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (LabelButtonCell *)gettingLabelButtonCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    LabelButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:lableBtnCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (LabelSwitchCell *)gettingLabelSwichCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    LabelSwitchCell *cell=[tableView dequeueReusableCellWithIdentifier:labelSwitchCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if(cell==nil){
        cell=[[LabelSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:labelSwitchCellID];
    }
    
    return cell;
}
- (void)loginOutAction:(UIButton *)btn{
    [SVProgressHUD showErrorWithStatus:@"loginOutAction"];
}

#pragma mark LabelSwitchCellDelegate
- (void)swichChangeAtCell:(LabelSwitchCell *)cell forSwitch:(UISwitch *)sender{
    //语音提示
    [SVProgressHUD showErrorWithStatus:@"swichChangeAtCell"];
}

#pragma mark LabelButtonCellDelegate
- (void)rightBtnClickAtCell:(LabelButtonCell *)cell clickButton:(UIButton *)btn{
    btn.selected = !btn.selected;
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.titleArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.titleArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self configCellInTableView:tableView atIndexPath:indexPath];
    NSString *titleStr = [self.titleArray objectAtIndex:indexPath.section][indexPath.row];
    if ([titleStr containsString:@"地址设置"]) {
        LabelButtonCell *cell = [self gettingLabelButtonCellInTableView:tableView atIndexPath:indexPath];
        cell.delegate = self;
        cell.titleLabel.text = titleStr;
        cell.subTitleLabel.text = @"每次上线自动定位";
        return cell;
    }else if ([titleStr containsString:@"版本更新"]){
        LabelButtonCell *cell = [self gettingLabelButtonCellInTableView:tableView atIndexPath:indexPath];
        [cell.rightBtn setImage:PNGIMAGE(@"img_notice") forState:(UIControlStateNormal)];
        cell.titleLabel.text = titleStr;
        cell.subTitleLabel.text = @"V1.0.3";
        return cell;
    }else if ([titleStr containsString:@"语音提示"]){
        return [self gettingLabelSwichCellInTableView:tableView atIndexPath:indexPath];
    }else if([titleStr containsString:@"安全退出"]){
        cell.textLabel.text = @"";
        [cell.contentView addSubview:self.loginOutBtn];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row ==  4) {
        //安全退出
        return 80;
    }
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //地址设置
                }
                    break;
                case 1:
                {
                    //语音提示
                }
                    break;
                case 2:
                {
                    //修改密码
                    EditPasswordViewController *editPaddwordVC = [[EditPasswordViewController alloc] init];
                    [self.navigationController pushViewController:editPaddwordVC animated:YES];
                }
                    break;
                case 3:
                {
                    //更改手机号
                    ChangePhoneNumViewController *phoneVC = [[ChangePhoneNumViewController alloc] init];
                    [self.navigationController pushViewController:phoneVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            //关于我们
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //服务标准
                    ServiceStandardViewController *serviceVC = [[ServiceStandardViewController alloc] init];
                    [self.navigationController pushViewController:serviceVC animated:YES];
                }
                    break;
                case 1:
                {
                    //服务条款
                }
                    break;
                case 2:
                {
                    //服务协议
                }
                    break;
                case 3:
                {
                    //版本更新
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

#pragma mark 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:lableBtnCellID bundle:nil] forCellReuseIdentifier:lableBtnCellID];
        [_tableView registerNib:[UINib nibWithNibName:labelSwitchCellID bundle:nil] forCellReuseIdentifier:labelSwitchCellID];
    }
    return _tableView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        NSArray *array1 = @[@"地址设置",@"语音提示",@"修改密码",@"更改手机号"];
        NSArray *array2 = @[@"关于我们"];
        NSArray *array3 = @[@"服务标准",@"服务条款",@"服务协议",@"版本更新",@"安全退出"];
        _titleArray = @[array1,array2,array3];
    }
    return _titleArray;
}
- (UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginOutBtn.frame = CGRectMake(20, 20, KscreenWidth - 40, 40);
        _loginOutBtn.layer.cornerRadius = 3;
        _loginOutBtn.layer.masksToBounds = YES;
        _loginOutBtn.backgroundColor = kAppColorAuxiliaryGreen;
        [_loginOutBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_loginOutBtn setTitle:Localized(@"安全退出") forState:(UIControlStateNormal)];
        [_loginOutBtn addTarget:self action:@selector(loginOutAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _loginOutBtn;
}

@end
