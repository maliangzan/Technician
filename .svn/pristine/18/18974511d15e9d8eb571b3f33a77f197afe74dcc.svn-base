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
#import "DataImageCell.h"
#import "EditDataStepOneViewController.h"

#define SECTION_HEAD_HEIGHT 10

static NSString *textFeildCellID = @"UserInfoTextFeildCell";
static NSString *textViewCellID = @"TextViewCell";
static NSString *dataImageCellID = @"DataImageCell";
@interface ProfessionalCertificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UILabel *placeHolderLabel;

@end

@implementation ProfessionalCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        EditDataStepOneViewController *stepOneVC = [[EditDataStepOneViewController alloc] init];
        [weakself.navigationController pushViewController:stepOneVC animated:YES];
    };
    
    [self.view addSubview:self.tableView];
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

- (DataImageCell *)gettingImageCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    DataImageCell *cell = [tableView dequeueReusableCellWithIdentifier:dataImageCellID];
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
    switch (indexPath.section) {
        case 0:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.valueTextFeild.textColor = kAppColorTextLightGray;
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.text = @"150301";
                    return cell;
                }
                    break;
                case 1:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.text = @"中医调理师／催乳师";
                    return cell;
                }
                    break;
                case 2:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.text = @"中级";
                    return cell;
                }
                    break;
                case 3:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.text = @"5  年";
                    return cell;
                }
                    break;
                case 4:
                {
                    UserInfoTextFeildCell *cell = [self gettingTextFeildCellInTableView:tableView atIndexPath:indexPath];
                    cell.rightImgView.hidden = YES;
                    cell.valueTextFeild.text = @"湖南岳阳卫生学校";
                    return cell;
                }
                    break;
                case 5:
                {
                    TextViewCell *cell = [self gettingTextViewCellInTableView:tableView atIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.valueTextView.userInteractionEnabled = NO;
                    self.placeHolderLabel = cell.placeHolderLabel;
                    self.placeHolderLabel.text = @"擅长技能简单介绍（150个字以内）";
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
            DataImageCell *cell = [self gettingImageCellInTableView:tableView atIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
            cell.titleLabel.text = subArray[indexPath.row];
            
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
        return 150 *kHeightFactor;
    }else if (indexPath.section == 0 && indexPath.row != 5){
        //第一段cell高度
        return 45 * kHeightFactor;
    }else{
        //资质证书cell高度
        return 150 * kHeightFactor;
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
        [_tableView registerNib:[UINib nibWithNibName:dataImageCellID bundle:nil] forCellReuseIdentifier:dataImageCellID];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[Localized(@"工号"),Localized(@"职业类别"),Localized(@"职级"),Localized(@"工作经验"),Localized(@"毕业院校"),Localized(@"擅长简介"),],@[Localized(@"职业资格证"),Localized(@"上岗证"),Localized(@"资质证书"),Localized(@"资质证书")]]];
    }
    return _dataArray;
}

@end
