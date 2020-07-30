//
//  BaseEditDataViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseEditDataViewController.h"
#define HEAD_HEIGHT 70
#define ACTION_BTN_WIDTH KscreenWidth

#define ACTION_BTN_HEIGHT 45

@interface BaseEditDataViewController ()

@end

@implementation BaseEditDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"填写资料");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.nextActionBtn];
    [self.view addSubview:self.tableView];
    
    [self congigHeadView];
    [self registerCell];
}

#pragma mark Method
- (void)next:(UIButton *)btn{
    if (self.nextStep) {
        self.nextStep();
    }
}

- (void)congigHeadView{
    [self.headView.stepOneBtn setBackgroundImage:PNGIMAGE(@"current_selected1") forState:(UIControlStateNormal)];
    [self.headView.stepTwoBtn setBackgroundImage:PNGIMAGE(@"current_unselected2") forState:(UIControlStateNormal)];
    [self.headView.stepThreeBtn setBackgroundImage:PNGIMAGE(@"current_unselected3") forState:(UIControlStateNormal)];
}

- (void)registerCell{}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight - ACTION_BTN_HEIGHT) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.tableHeaderView = self.headView;

    }
    return _tableView;
}

- (EditDataHeadView *)headView{
    if (!_headView) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"EditDataHeadView" owner:self options:nil][0];
        _headView.frame = CGRectMake(0, 0, KscreenWidth, HEAD_HEIGHT);
    }
    return _headView;
}

- (UIButton *)nextActionBtn{
    if (!_nextActionBtn) {
        _nextActionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _nextActionBtn.frame = CGRectMake(0, KscreenHeight - ACTION_BTN_HEIGHT, ACTION_BTN_WIDTH, ACTION_BTN_HEIGHT);
        _nextActionBtn.backgroundColor = kAppColorAuxiliaryGreen;
        [_nextActionBtn setTitle:Localized(@"下一步") forState:(UIControlStateNormal)];
        [_nextActionBtn addTarget:self action:@selector(next:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nextActionBtn;
}

@end
