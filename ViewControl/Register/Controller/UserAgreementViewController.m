//
//  UserAgreementViewController.m
//  Technician
//
//  Created by TianQian on 2017/7/20.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "UserAgreementViewController.h"
#import "UserAgreementVCCell.h"

static NSString *cellID = @"UserAgreementVCCell";
@interface UserAgreementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindData];
    [self loadData];
    
}
#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = Localized(@"用户服务协议");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - addViews

#pragma mark - bindData
- (void)bindData {
    
}

#pragma mark - loadData
- (void)loadData{
    
}

#pragma mark - business


#pragma mark - cell delegate
#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserAgreementVCCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
    cell.titleLabel.text = dic[@"title"];
    cell.contentLabel.text = dic[@"content"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
    return 40 + [NSString heightForString:dic[@"content"] labelWidth:KscreenWidth - 40 fontOfSize:15];
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

#pragma mark - collection


#pragma mark - Get
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
  @{@"title":@"一、特别提示",@"content":@"在此特别提醒您（用户）在注册成为幸孕儿-上门服务技师端用户之前，请认真阅读本《用户服务协议》（以下简称“协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。除非您接受本协议所有条款，否则您无权注册、登录或使用本协议所涉服务。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。  本协议约定幸孕儿-上门服务技师端平台与用户之间关于“幸孕儿-上门服务技师端”服务（以下简称“服务”）的权利义务。“用户”是指注册、登录、使用本服务的个人。本协议可由幸孕儿-上门服务技师端随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本APP中查阅最新版协议条款。在修改协议条款后，如果用户不接受修改后的条款，请立即停止使用幸孕儿上门服务提供的服务，用户继续使用平台提供的服务将被视为接受修改后的协议。"},
  @{@"title":@"二、账号注册",@"content":@"1、用户在使用本服务前需要注册一个“幸孕儿-上门服务技师端”账号。“幸孕儿-上门服务技师端”账号应当使用手机号码绑定注册，请用户使用尚未与“幸孕儿-上门服务技师端”账号绑定的手机号码，以及未被幸孕儿上门服务技师端平台封禁的手机号码注册“幸孕儿-上门服务技师端”账号。幸孕儿-上门服务技师端可以根据用户需求或产品需要对账号注册和绑定的方式进行变更，而无须事先通知用户。\n2、如果注册申请者有被幸孕儿-上门服务技师端封禁的先例或涉嫌虚假注册及滥用他人名义注册，及其他不能得到许可的理由， 幸孕儿-上门服务技师端将拒绝其注册申请。\n3、鉴于“幸孕儿-上门服务技师端”账号的绑定注册方式，您同意幸孕儿-上门服务技师端在注册时将允许您的手机号码及手机设备识别码等信息用于注册。\n4、在用户注册及使用本服务时，幸孕儿-上门服务技师端需要搜集能识别用户身份的个人信息以便幸孕儿-上门服务技师端可以在必要时联系用户，或为用户提供更好的使用体验。幸孕儿-上门服务技师端搜集的信息包括但不限于用户的姓名、地址；幸孕儿-上门服务技师端同意对这些信息的使用将受限于第三条用户个人隐私信息保护的约束。"},
  @{@"title":@"三、账户安全",@"content":@"1、用户一旦注册成功，成为幸孕儿-上门服务技师端的用户，将得到一个用户名和密码，并有权利使用自己的用户名及密码随时登陆幸孕儿-上门服务技师端。\n2、用户对用户名和密码的安全负全部责任，同时对以其用户名进行的所有活动和事件负全责。\n3、用户不得以任何形式擅自转让或授权他人使用自己的幸孕儿-上门服务技师端的用户名。\n4、如果用户泄漏了密码，有可能导致不利的法律后果，因此不管任何原因导致用户的密码安全受到威胁，应该立即和幸孕儿客服人员取得联系，否则后果自负。\n"},
  @{@"title":@"四、用户声明与保证",@"content":@"1、用户承诺其为具有完全民事行为能力的民事主体，且具有达成交易履行其义务的能力。\n2、用户有义务在注册时提供自己的真实资料，并保证诸如手机号码、姓名、所在地区等内容的有效性及安全性，保证幸孕儿工作人员可以通过上述联系方式与用户取得联系。同时，用户也有义务在相关资料实际变更时及时更新有关注册资料。\n3、用户通过使用幸孕儿-上门服务技师端的过程中所制作、上载、复制、发布、传播的任何内容，包括但不限于账号头像、名称、用户说明等注册信息及认证资料，或文字、语音、图片、视频、图文等发送、回复和相关链接页面，以及其他使用账号或本服务所产生的内容，不得违反国家相关法律制度，包含但不限于如下原则：  （1）反对宪法所确定的基本原则的；  （2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的； （3）损害国家荣誉和利益的；  （4）煽动民族仇恨、民族歧视，破坏民族团结的； （5）破坏国家宗教政策，宣扬邪教和封建迷信的； （6）散布谣言，扰乱社会秩序，破坏社会稳定的；  （7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的； （8）侮辱或者诽谤他人，侵害他人合法权益的； （9）含有法律、行政法规禁止的其他内容的。\n4、用户不得利用“幸孕儿-上门服务技师端”账号或本服务制作、上载、复制、发布、传播下干扰“幸孕儿-上门服务技师端”正常运营，以及侵犯其他用户或第三方合法权益的内容：  （1）含有任何性或性暗示的； （2）含有辱骂、恐吓、威胁内容的；  （3）含有骚扰、垃圾广告、恶意信息、诱骗信息的；"},
  
  ]];
    }
    return _dataArray;
}
@end
