//
//  AllEvaluationViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "AllEvaluationViewController.h"
#import "EvaluateHeadView.h"
#import "AllEvaluateSubHeadView.h"
#import "AllEvaluateCell.h"

static NSString *allEvaCellID = @"AllEvaluateCell";
@interface AllEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,AllEvaluateCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EvaluateHeadView *headView;
@property (nonatomic,strong) AllEvaluateSubHeadView *subHead;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation AllEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"全部评价");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.tableView];
}

#pragma mark Method
- (void)configAllEvaluateCell:(AllEvaluateCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.iconImageView.image = placeh_userAvatar;
    NSString *thumbUp = dic[@"thumbUp"];
    [cell.thumbUpBtn setTitle:thumbUp forState:(UIControlStateNormal)];
    cell.nameAndTimeLabel.text = dic[@"name"];
    cell.evaluateLabel.text = dic[@"evaluate"];
    cell.replyLabel.text = dic[@"reply"];
}

#pragma mark AllEvaluateCellDelegate
- (void)thumbUpAtCell:(AllEvaluateCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"第%ld个cell点赞",indexPath.row]];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:allEvaCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [self configAllEvaluateCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *evaluate = dic[@"evaluate"];
    NSString *reply = dic[@"reply"];
    return 35
         + 21
         + 20
         + [NSString heightForString:evaluate labelWidth:KscreenWidth - 80 fontOfSize:15]
         + 20
         + [NSString heightForString:reply labelWidth:KscreenWidth - 80 fontOfSize:15]
         + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kAppColorBackground;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:allEvaCellID bundle:nil] forCellReuseIdentifier:allEvaCellID];
        
    }
    return _tableView;
}

- (EvaluateHeadView *)headView{
    if (!_headView) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"EvaluateHeadView" owner:nil options:nil][0];
        _headView.frame = CGRectMake(0, 0, KscreenWidth, 150);
        [_headView.upSubBgView addSubview:self.subHead];
    }
    return _headView;
}

- (AllEvaluateSubHeadView *)subHead{
    if (!_subHead) {
        _subHead = [[NSBundle mainBundle] loadNibNamed:@"AllEvaluateSubHeadView" owner:nil options:nil][0];
        _subHead.frame = CGRectMake(0, 0,self.headView.upSubBgView.frame.size.width , self.headView.upSubBgView.frame.size.height);
    }
    return _subHead;
}


#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
                                                      
  @{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
  ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
  ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"},@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"",@"thumbUp":@"12"}
  ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
  
  ]];
        
    }
    return _dataArray;
}


@end
