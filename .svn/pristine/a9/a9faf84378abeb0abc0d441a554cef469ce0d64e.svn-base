//
//  ServiceStandardViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceStandardViewController.h"
#import "ServiceStandardCell.h"

static NSString *serviceStandardCellID = @"ServiceStandardCell";

@interface ServiceStandardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ServiceStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"服务标准";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceStandardCell *cell=[tableView dequeueReusableCellWithIdentifier:serviceStandardCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell==nil){
        cell=[[ServiceStandardCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:serviceStandardCellID];
    }
    cell.contentLabel.text = Localized(@"第一条   为加强公司业务上门服务的统一管理，规范上门服务行为，防范风险，保障银企双方资金安全，更好地为客户提供优质服务，提高我行的竞争能力和经营效益，根据中国银行业监督管理委员会《商业银行内部控制指引》以及中信银行会计、合规审计等规章制度，特制定本办法。\n\n第二条  本办法所称公司业务上门服务（以下简称“上门服务”），是指银行根据客户的申请，按照双方协议所约定的服务种类，由银行指派工作人员到客户营业场所，为其办理业务，提供便利的一种服务。\n\n第三条   根据上门服务的内容不同，上门服务包括上门开户、上门取单、上门送单及上门收款");
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KscreenHeight - kCustomNavHeight;
}
#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:serviceStandardCellID bundle:nil] forCellReuseIdentifier:serviceStandardCellID];
    }
    return _tableView;
}

@end
