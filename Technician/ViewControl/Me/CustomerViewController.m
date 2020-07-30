//
//  CustomerViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "CustomerViewController.h"
#import "TextViewCell.h"
#import "PaymentIssuesViewController.h"
#import "FeedbackRecordViewController.h"

#define CELLHEIGHT 45 * kHeightFactor

static NSString *textViewCellID = @"TextViewCell";
@interface CustomerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *feedbackBtn;
@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"客服";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.tableView];
}

#pragma mark method
- (void)commitAction:(UIButton *)btn{
    [SVProgressHUD showErrorWithStatus:@"commit"];
}

- (void)feedBackRecordAction:(UIButton *)btn{
    FeedbackRecordViewController *vc = [[FeedbackRecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)callPhoneAction:(UIButton *)btn{
    CallWithPhoneNumber(@"4008004016");
}

- (UITableViewCell *)gettingTableCellAt:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELLHEIGHT - 1, KscreenWidth, 1)];
    line.backgroundColor = kAppColorBackground;
    [cell addSubview:line];
    return cell;
}

- (TextViewCell *)gettingTextViewCellAt:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textViewCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.placeHolderLabel.text = Localized(@"您的高见是我们前进的动力");
    [cell addSubview:self.feedbackBtn];
    return cell;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArr = [self.dataArray objectAtIndex:section];
    return subArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            
            return [self gettingTableCellAt:tableView atIndexPath:indexPath];
        }
            break;
        case 1:
        {
            return [self gettingTextViewCellAt:tableView atIndexPath:indexPath];
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //支付问题
                    PaymentIssuesViewController *vc = [[PaymentIssuesViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;

                default:
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.section][indexPath.row]]];
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 200 * kHeightFactor;
    }
    return CELLHEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.tableFooterView = self.footerView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:textViewCellID bundle:nil] forCellReuseIdentifier:textViewCellID];
    }
    return _tableView;
}

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _commitBtn.frame = CGRectMake(20, 30, KscreenWidth - 40, 40);
        _commitBtn.backgroundColor = kAppColorAuxiliaryGreen;
        _commitBtn.layer.cornerRadius = 5;
        _commitBtn.layer.masksToBounds = YES;
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_commitBtn setTitle:Localized(@"提交") forState:(UIControlStateNormal)];
        [_commitBtn addTarget:self action:@selector(commitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commitBtn;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 100 * kHeightFactor)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100 * kHeightFactor - 1, KscreenWidth, 1)];
        line.backgroundColor = kAppColorBackground;
        [_headView addSubview:self.phoneBtn];
        [_headView addSubview:line];
    }
    return _headView;
}

- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _phoneBtn.frame = CGRectMake(0, 20, KscreenWidth, 60);
        [_phoneBtn setImage:PNGIMAGE(@"img_call") forState:(UIControlStateNormal)];
        [_phoneBtn setTitle:@"  400 800 4016" forState:(UIControlStateNormal)];
        [_phoneBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateNormal)];
        [_phoneBtn addTarget:self action:@selector(callPhoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _phoneBtn;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 100 * kHeightFactor)];
        _footerView.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:self.commitBtn];
    }
    return _footerView;
}

- (UIButton *)feedbackBtn{
    if (!_feedbackBtn) {
        _feedbackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _feedbackBtn.frame = CGRectMake(KscreenWidth - 120, 200 * kHeightFactor - 40, 110, 40);
        _feedbackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_feedbackBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateNormal)];
        [_feedbackBtn setTitle:@"反馈记录 2 条" forState:(UIControlStateNormal)];
        [_feedbackBtn addTarget:self action:@selector(feedBackRecordAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _feedbackBtn;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@[@"支付问题",@"上门时间问题",@"服务时长问题",@"服务人员问题"],@[@"其他意见反馈与投诉"]]];
    }
    return _dataArray;
}

@end
