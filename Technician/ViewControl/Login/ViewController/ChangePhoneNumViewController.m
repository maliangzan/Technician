//
//  ChangePhoneNumViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ChangePhoneNumViewController.h"
#import "SYChangePhoneNumCell.h"

static NSString *changePhoneNumCellID = @"SYChangePhoneNumCell";

@interface ChangePhoneNumViewController ()<UITableViewDelegate,UITableViewDataSource,SYChangePhoneNumCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"更改手机号";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark SYChangePhoneNumCellDelegate
- (void)gettingErificationCode{
    [SVProgressHUD showErrorWithStatus:@"gettingErificationCode"];
}

- (void)commitNewPhoneNum:(NSString *)phoneNum{
    [SVProgressHUD showErrorWithStatus:@"commitNewPhoneNum"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYChangePhoneNumCell *cell=[tableView dequeueReusableCellWithIdentifier:changePhoneNumCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
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
        [_tableView registerNib:[UINib nibWithNibName:changePhoneNumCellID bundle:nil] forCellReuseIdentifier:changePhoneNumCellID];
        
    }
    return _tableView;
}
@end
