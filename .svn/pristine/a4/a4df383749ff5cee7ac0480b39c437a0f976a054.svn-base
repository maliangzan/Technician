//
//  MyEvaluationViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "AllEvaluationViewController.h"
#import "EvaluateHeadView.h"
#import "MyEvaluateSubHeadView.h"
#import "MyEvaluateCell.h"

#define ACTION_BTN_HEIGHT 45 * kHeightFactor

static NSString *evaluateCellID = @"MyEvaluateCell";
@interface MyEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *lookAllEvaluationBtn;
@property (nonatomic,strong) EvaluateHeadView *headView;
@property (nonatomic,strong) MyEvaluateSubHeadView *subHeadView;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"我的评价");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.lookAllEvaluationBtn];
    [self.view addSubview:self.tableView];
}

#pragma mark method
- (void)lookAllEvaluation:(UIButton *)btn{
    AllEvaluationViewController *allEva = [[AllEvaluationViewController alloc] init];
    [self.navigationController pushViewController:allEva animated:YES];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 * kHeightFactor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20 * kHeightFactor;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            cell.firstStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.secondStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.thirdStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.fourthStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.fifthStarImgView.image = PNGIMAGE(@"img_star_orange");
        }
            break;
        case 1:
        {
            cell.firstStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.secondStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.thirdStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.fourthStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.fifthStarImgView.image = PNGIMAGE(@"img_star_gray");
        }
            break;
        case 2:
        {
            cell.firstStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.secondStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.thirdStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.fourthStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.fifthStarImgView.image = PNGIMAGE(@"img_star_gray");
        }
            break;
        case 3:
        {
            cell.firstStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.secondStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.thirdStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.fourthStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.fifthStarImgView.image = PNGIMAGE(@"img_star_gray");
        }
            break;
        case 4:
        {
            cell.firstStarImgView.image = PNGIMAGE(@"img_star_orange");
            cell.secondStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.thirdStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.fourthStarImgView.image = PNGIMAGE(@"img_star_gray");
            cell.fifthStarImgView.image = PNGIMAGE(@"img_star_gray");
        }
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - ACTION_BTN_HEIGHT - 10) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = kAppColorBackground;
        [_tableView registerNib:[UINib nibWithNibName:evaluateCellID bundle:nil] forCellReuseIdentifier:evaluateCellID];
    }
    return _tableView;
}

- (EvaluateHeadView *)headView{
    if (!_headView) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"EvaluateHeadView" owner:nil options:nil][0];
        _headView.frame = CGRectMake(0, 0, KscreenWidth, 250);
        [_headView.upSubBgView addSubview:self.subHeadView];
    }
    return _headView;
}

- (MyEvaluateSubHeadView *)subHeadView{
    if (!_subHeadView) {
        _subHeadView = [[NSBundle mainBundle] loadNibNamed:@"MyEvaluateSubHeadView" owner:nil options:nil][0];
        _subHeadView.frame = CGRectMake(0, 0,self.headView.upSubBgView.frame.size.width , self.headView.upSubBgView.frame.size.height);
    }
    return _subHeadView;
}

- (UIButton *)lookAllEvaluationBtn{
    if (!_lookAllEvaluationBtn) {
        _lookAllEvaluationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _lookAllEvaluationBtn.frame = CGRectMake(0, KscreenHeight - ACTION_BTN_HEIGHT, KscreenWidth, ACTION_BTN_HEIGHT );
        _lookAllEvaluationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _lookAllEvaluationBtn.backgroundColor = [UIColor whiteColor];
        NSString *evaNumStr = @"119";
        NSString *str = [NSString stringWithFormat:@"查看全部%@评论",evaNumStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
         [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorTextMiddleBlack range:NSMakeRange(0, str.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4, evaNumStr.length)];
       
        [_lookAllEvaluationBtn setAttributedTitle:attrStr forState:(UIControlStateNormal)];
        [_lookAllEvaluationBtn addTarget:self action:@selector(lookAllEvaluation:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lookAllEvaluationBtn;
}

@end
