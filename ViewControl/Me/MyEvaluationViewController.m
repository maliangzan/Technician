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
#import "SYMyEvaluateApi.h"
#import "MyEvaluateMode.h"
#import "SYTabMode.h"
#import "SYStarLevelMode.h"

#define ACTION_BTN_HEIGHT 45 * kHeightFactor

static NSString *evaluateCellID = @"MyEvaluateCell";
@interface MyEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *lookAllEvaluationBtn;
@property (nonatomic,strong) EvaluateHeadView *headView;
@property (nonatomic,strong) MyEvaluateSubHeadView *subHeadView;
@property (nonatomic,strong) MyEvaluateMode *myEvaluate;
@property (nonatomic,strong) NSMutableArray *evaluateArray;
@property (nonatomic,strong) NSMutableArray *starArray;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
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
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"%@dsSaleOrder/queryList?tid=%@",URL_HTTP_Base_Get,[SYAppConfig shared].me.userID];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    SYMyEvaluateApi *api = [[SYMyEvaluateApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        api.responseData;
        weakself.myEvaluate = [MyEvaluateMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself configSubHeadView];
        [weakself addEvaluateDataString];
        [weakself addStarDataString];
        [weakself configLookAllEvaluateBtn];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}
 
- (void)configSubHeadView{
    NSString *professinalStr = self.myEvaluate.homePageProfessAndAttitudeDic[@"profession"];
    self.subHeadView.leftPercentLabel.attributedText = [NSString joiningTogetherSting:Localized(@"专业") withAStringColor:kAppColorTextMiddleBlack andBString:professinalStr withBStringColor:kAppColorAuxiliaryLightOrange];
    
    NSString *attributeStr = self.myEvaluate.homePageProfessAndAttitudeDic[@"attitude"];
    self.subHeadView.rightPercentLabel.attributedText = [NSString joiningTogetherSting:Localized(@"态度") withAStringColor:kAppColorTextMiddleBlack andBString:attributeStr withBStringColor:kAppColorAuxiliaryLightOrange];
    
    self.subHeadView.scoreLabel.text = [NSString stringWithFormat:@"%.1f分",[self.myEvaluate.techCollScore floatValue]];
    NSString *grayStr = Localized(@"恭喜满意度");
    NSString *orangeStr = self.myEvaluate.homePageProfessAndAttitudeDic[@"ave"];
    self.subHeadView.satisfactionPercentLabel.attributedText = [NSString joiningTogetherSting:grayStr withAStringColor:kAppColorTextMiddleBlack andBString:orangeStr withBStringColor:kAppColorAuxiliaryLightOrange];
}

- (void)addEvaluateDataString{
    NSArray *titleArray = @[@"态度很好",@"手法专业",@"效果不错",@"颜值爆表",@"非常礼貌",@"很有耐心"];
    SYTabMode *tabMode = [SYTabMode fromJSONDictionary:self.myEvaluate.tabDic];
    NSString *attitudeGood = [tabMode.attitudeGood stringValue];
    if ([tabMode.attitudeGood integerValue] > 99) {
        attitudeGood = @"99+";
    }
    NSString *manipulationProfession = [tabMode.manipulationProfession stringValue];
    if ([tabMode.manipulationProfession integerValue] > 99) {
        manipulationProfession = @"99+";
    }
    NSString *effectGood = [tabMode.effectGood stringValue];
    if ([tabMode.effectGood integerValue] > 99) {
        effectGood = @"99+";
    }
    NSString *goodLooking = [tabMode.goodLooking stringValue];
    if ([tabMode.goodLooking integerValue] > 99) {
        goodLooking = @"99+";
    }
    NSString *politeness = [tabMode.politeness stringValue];
    if ([tabMode.politeness integerValue] > 99) {
        politeness = @"99+";
    }
    NSString *patience = [tabMode.patience stringValue];
    if ([tabMode.patience integerValue] > 99) {
        patience = @"99+";
    }
    
    NSMutableArray *numArray = [NSMutableArray arrayWithObjects:
                                isNull(attitudeGood) == YES ?@"0":attitudeGood,
                                isNull(manipulationProfession) == YES ?@"0":manipulationProfession,
                                isNull(effectGood) == YES ?@"0":effectGood,
                                isNull(goodLooking) == YES ?@"0":goodLooking,
                                isNull(politeness) == YES ?@"0":politeness,
                                isNull(patience) == YES ?@"0":patience,
                                nil];
    if (numArray.count >= titleArray.count) {
        for (int i = 0; i < titleArray.count; i++) {
            NSString *titleStr = titleArray[i];
            NSString *numStr = numArray[i];
            NSMutableAttributedString *attributeStr = [NSString joiningTogetherSting:titleStr withAStringColor:kAppColorTextMiddleBlack andBString:numStr withBStringColor:kAppColorAuxiliaryLightOrange];
            [self.evaluateArray addObject:attributeStr];
        }
    }
    self.headView.dataArray = self.evaluateArray;
    [self.headView.myCollectionView reloadData];
}

- (void)addStarDataString{
    SYStarLevelMode *starMode = [SYStarLevelMode fromJSONDictionary:self.myEvaluate.starLevelDic];
    NSString *oneStar = [starMode.starOfOne stringValue];
    NSString *twoStar = [starMode.starOfTwo stringValue];
    NSString *threeStar = [starMode.starOfThree stringValue];
    NSString *fourStar = [starMode.starOfFour stringValue];
    NSString *fiveStar = [starMode.starOfFive stringValue];
    NSMutableArray *starArr = [NSMutableArray arrayWithObjects:
                               isNull(oneStar) == YES ? @"":oneStar,
                               isNull(twoStar) == YES ? @"":twoStar,
                               isNull(threeStar) == YES ? @"":threeStar,
                               isNull(fourStar) == YES ? @"":fourStar,
                               isNull(fiveStar) == YES ? @"":fiveStar,
                                                              nil];
    for (NSString *starStr in starArr) {
        NSMutableAttributedString *attribute = [NSString joiningTogetherSting:starStr withAStringColor:kAppColorAuxiliaryLightOrange andBString:Localized(@"单") withBStringColor:kAppColorTextMiddleBlack];
        [self.starArray addObject:attribute];
    }
    [self.tableView reloadData];

}

- (void)configLookAllEvaluateBtn{
    NSString *evaNumStr = [NSString stringWithFormat:@"%ld",self.myEvaluate.appraiseDetailArr.count];
    NSString *str = [NSString stringWithFormat:@"查看全部%@条评论",evaNumStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorTextMiddleBlack range:NSMakeRange(0, str.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4, evaNumStr.length)];
    
    [_lookAllEvaluationBtn setAttributedTitle:attrStr forState:(UIControlStateNormal)];
}

- (void)lookAllEvaluation:(UIButton *)btn{
    if (self.myEvaluate.appraiseDetailArr.count == 0) {
        [self.view showHUDForInfo:Localized(@"暂无评价！")];
        return;
    }
    AllEvaluationViewController *allEva = [[AllEvaluationViewController alloc] init];
    [self.navigationController pushViewController:allEva animated:YES];
}


- (void)configCell:(MyEvaluateCell *)cell withFirstStarImage:(NSString *)fImageName secondStarImage:(NSString *)SImageName thirdStarImage:(NSString *)tImageName fourthStarImage:(NSString *)foImageName fifthStarImage:(NSString *)fifImageName{
    cell.firstStarImgView.image = PNGIMAGE(fImageName);
    cell.secondStarImgView.image = PNGIMAGE(SImageName);
    cell.thirdStarImgView.image = PNGIMAGE(tImageName);
    cell.fourthStarImgView.image = PNGIMAGE(foImageName);
    cell.fifthStarImgView.image = PNGIMAGE(fifImageName);
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.starArray.count;
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
    NSAttributedString *attribute = [self.starArray objectAtIndex:self.starArray.count - indexPath.row - 1];
    cell.numLabel.attributedText = attribute;
    switch (indexPath.row) {
        case 0:
        {
            [self configCell:cell withFirstStarImage:@"img_star_orange" secondStarImage:@"img_star_orange" thirdStarImage:@"img_star_orange" fourthStarImage:@"img_star_orange" fifthStarImage:@"img_star_orange"];
        }
            break;
        case 1:
        {
            [self configCell:cell withFirstStarImage:@"img_star_orange" secondStarImage:@"img_star_orange" thirdStarImage:@"img_star_orange" fourthStarImage:@"img_star_orange" fifthStarImage:@"img_star_gray"];
        }
            break;
        case 2:
        {
            [self configCell:cell withFirstStarImage:@"img_star_orange" secondStarImage:@"img_star_orange" thirdStarImage:@"img_star_orange" fourthStarImage:@"img_star_gray" fifthStarImage:@"img_star_gray"];
        }
            break;
        case 3:
        {
            [self configCell:cell withFirstStarImage:@"img_star_orange" secondStarImage:@"img_star_orange" thirdStarImage:@"img_star_gray" fourthStarImage:@"img_star_gray" fifthStarImage:@"img_star_gray"];
        }
            break;
        case 4:
        {
            [self configCell:cell withFirstStarImage:@"img_star_orange" secondStarImage:@"img_star_gray" thirdStarImage:@"img_star_gray" fourthStarImage:@"img_star_gray" fifthStarImage:@"img_star_gray"];
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
        NSString *evaNumStr = @"0";
        NSString *str = [NSString stringWithFormat:@"查看全部%@条评论",evaNumStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
         [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorTextMiddleBlack range:NSMakeRange(0, str.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4, evaNumStr.length)];
       
        [_lookAllEvaluationBtn setAttributedTitle:attrStr forState:(UIControlStateNormal)];
        [_lookAllEvaluationBtn addTarget:self action:@selector(lookAllEvaluation:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lookAllEvaluationBtn;
}

- (NSMutableArray *)evaluateArray{
    if (!_evaluateArray) {
        _evaluateArray = [NSMutableArray array];
        
    }
    return _evaluateArray;
}

- (NSMutableArray *)starArray{
    if (!_starArray) {
        _starArray = [NSMutableArray array];
        
    }
    return _starArray;
}

@end
