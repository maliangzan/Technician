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
#import "SYCustomServiceApi.h"
#import "SYTimeHelper.h"
//#import "SYFeedbackRecordApi.h"
#import "SYUploadFeedbackApi.h"
#import "SYNewFeedBackRecordApi.h"

#define CELLHEIGHT 45 * kHeightFactor

static NSString *textViewCellID = @"TextViewCell";
@interface CustomerViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic, strong)UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *feedbackBtn;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) UITextView *feedBackTextView;
@property (nonatomic,assign) NSInteger feedBackNum;

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindData];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)bindData{
    self.feedBackNum = 0;
}

- (void)loadData{
    
    WeakSelf;
    [[[SYNewFeedBackRecordApi alloc] initWithSource:@"technician"]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             
             if (!isNullDictionary(request.responseObject[@"data"])) {
                 weakself.feedBackNum = [request.responseObject[@"data"][@"num"] integerValue];
                 NSString *feedBackString = [NSString stringWithFormat:@"反馈记录 %ld 条",weakself.feedBackNum];
                 [weakself.feedbackBtn setTitle:feedBackString forState:(UIControlStateNormal)];
             }
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view hideHUD];
         [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
         NSLog(@"%@", request.error);
     }];
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = Localized(@"联系客服");
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
    [self.view endEditing:YES];
    
    NSString *opinion = [SYAppConfig shared].me.opinion;
    opinion = isNull(opinion) == YES ? @"":opinion;
    if (isNull(opinion)) {
        [self.view showHUDForError:Localized(@"请输入您的高见！")];
        return;
    }
    
    opinion = isNull(opinion) == YES ? @"" : opinion;

    [self.view showHUDWithMessage:Localized(@"提交中...")];
    WeakSelf;
    [[[SYUploadFeedbackApi alloc] initWithFeedBackString:opinion]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [weakself.view hideHUD];
             
             [[UIApplication sharedApplication].keyWindow showHUDForSuccess:Localized(@"提交成功！")];
             [SYAppConfig shared].me.opinion = @"";
             weakself.feedBackTextView.text = [SYAppConfig shared].me.opinion;
             weakself.placeHolderLabel.hidden = NO;
             [weakself loadData];
             [weakself goToFeedBackRecordVC];
//             [weakself.navigationController popToRootViewControllerAnimated:YES];
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view hideHUD];
         [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
         NSLog(@"%@", request.error);
     }];
}

- (void)feedBackRecordAction:(UIButton *)btn{
    if (self.feedBackNum == 0) {
        [self.view showHUDForInfo:Localized(@"暂无反馈记录")];
        [self loadData];
        return;
    }
    [self goToFeedBackRecordVC];
}

- (void)goToFeedBackRecordVC{
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
    cell.valueTextView.delegate = self;
    cell.valueTextView.text = [SYAppConfig shared].me.opinion;
    cell.placeHolderLabel.text = Localized(@"您的高见是我们前进的动力");
    self.placeHolderLabel = cell.placeHolderLabel;
    self.feedBackTextView = cell.valueTextView;
    [cell addSubview:self.feedbackBtn];
    return cell;
}


#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.placeHolderLabel.hidden = !isNull(textView.text);
    [SYAppConfig shared].me.opinion = textView.text;
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
                    PaymentIssuesViewController *vc = [[PaymentIssuesViewController alloc] initWithTitle:Localized(@"支付问题") dataArray:[self gettingPaymentIssue]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    //上门时间问题
                    PaymentIssuesViewController *vc = [[PaymentIssuesViewController alloc] initWithTitle:Localized(@"上门时间问题") dataArray:[self gettingTheDoorTimeIssue]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    //服务时长问题
                    PaymentIssuesViewController *vc = [[PaymentIssuesViewController alloc] initWithTitle:Localized(@"服务时长问题") dataArray:[self gettingServiceTimeIssue]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 3:
                {
                    //服务人员问题
                    PaymentIssuesViewController *vc = [[PaymentIssuesViewController alloc] initWithTitle:Localized(@"服务人员问题") dataArray:[self gettingServicePersonIssue]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
//                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.section][indexPath.row]]];
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    //@[@{@"title":@"支付不了",@"content":@"1、请查看网络状态，最好在有WIFI的状态下支付更快哦。\n2、可能遇到幸孕儿正在升级哦，请您稍后再尝试。如还是不行，请联系在线客服。"},@{@"title":@"银行跳转不了",@"content":@"1、请查看网络状态，最好在有WIFI的状态下支付更快哦。\n2、可能遇到幸孕儿正在升级哦，请您稍后再尝试。如还是不行，请联系在线客服。"},]
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
        NSString *feedBackString = [NSString stringWithFormat:@"反馈记录 %ld 条",self.feedBackNum];
        [_feedbackBtn setTitle:feedBackString forState:(UIControlStateNormal)];
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

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (NSMutableArray *)gettingPaymentIssue{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@{@"title":@"支付问题",@"content":@"1、在线支付接入第三方支付，采用都加密通道，安全性完全有保障；\n\n 2、在公共场合进行支付时，注意卡号及密码保护，防止被窥窃；\n\n3、在线支付不收取任何手续费；\n\n4、完成支付过程后，系统会有支付成功提醒；若提醒支付失败，查看个人账户的金额是否被扣除，未被扣除系统会返回待支付状态需用户重新支付，如果已被扣除订单会返回等待服务中状态；\n\n 5、如有其他问题可直接联系客服，会第一时间为您处理。"}]];
    return array;
}

- (NSMutableArray *)gettingTheDoorTimeIssue{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@{@"title":@"上门时间问题",@"content":@"1、技师上门预留时间为一个小时，充裕的时间会让技师在服务开始前赶到。\n\n 2、如果是技师的原因导致迟到，技师也会对客户进行相应的补偿。\n\n3、如有其他问题可直接联系客服，会第一时间为您处理。"}]];
    return array;
}

- (NSMutableArray *)gettingServiceTimeIssue{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@{@"title":@"服务时长问题",@"content":@"1、如操作时间离开始服务2小时以上可以修改服务时间，但需在当前订单技师时间未被占用的情况下可操作；离开始服务2小时内不可修改服务时间；\n\n 2、每个人对服务的接纳程度不一样，服务时长可能不一样，技师可自控时长来完成服务；\n\n3、如果用户要求加服务时长，可与技师协商，产生的额外费用平台不负责；\n\n 4、如有其他问题可直接联系客服，会第一时间为您处理。"}]];
    return array;
}

- (NSMutableArray *)gettingServicePersonIssue{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@{@"title":@"服务人员问题",@"content":@"1、用户可在平台【我的技师】添加常用技师管理；\n\n 2、呼叫技师如果更换，需与客服联系，在双方协商一致情况下可更换技师；\n\n3、用户需与技师沟通一些禁忌或者不适宜的疗法，技师在服务前也会跟用户沟通注意事项，若未告知出现问题需用户自己负责；\n\n4、如有其他问题可直接联系客服，会第一时间为您处理。"}]];
    return array;
}

@end
