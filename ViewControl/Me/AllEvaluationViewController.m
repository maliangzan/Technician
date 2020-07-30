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
#import "SYMyEvaluateApi.h"
#import "MyEvaluateMode.h"
#import "SYTabMode.h"
#import "SYAppraiseMode.h"
#import "SYAppraiseReplyMode.h"
#import "SYAppraiseDetialsMode.h"

static NSString *allEvaCellID = @"AllEvaluateCell";
@interface AllEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,AllEvaluateCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EvaluateHeadView *headView;
@property (nonatomic,strong) AllEvaluateSubHeadView *subHead;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) MyEvaluateMode *myEvaluate;
@property (nonatomic,strong) NSMutableArray *evaluateArray;
@property (nonatomic,strong) NSMutableArray *testArray;
@property (nonatomic,strong) NSMutableArray *appraiseDetials;


@end

@implementation AllEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
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
- (void)loadData{
    [self.view showHUDWithMessage:Localized(@"")];
    NSString *urlStr = [NSString stringWithFormat:@"%@Health/app/dsSaleOrder/queryList?tid=%@",URL_HTTP_Base,[SYAppConfig shared].me.userID];
    WeakSelf;
    SYMyEvaluateApi *api = [[SYMyEvaluateApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        api.responseData;
        [weakself.dataArray removeAllObjects];
        weakself.myEvaluate = [MyEvaluateMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself.appraiseDetials addObjectsFromArray:weakself.myEvaluate.appraiseDetailArr];
        [weakself congfigSubHeadView];
        [weakself addEvaluateDataString];
        //        [weakself addStarDataString];
        //        [weakself configLookAllEvaluateBtn];
        [weakself.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)congfigSubHeadView{
    NSString *toString = Localized(@"全部（）");
    NSString *insertString = [NSString stringWithFormat:@"%ld条",self.myEvaluate.appraiseDetailArr.count];
    self.subHead.allNumLabel.attributedText = [NSString insertString:insertString withInsertStringColor:kAppColorAuxiliaryLightOrange toString:toString stringColor:kAppColorTextMiddleBlack atIndex:toString.length - 1];
    
    //综合评分
    CGFloat professionPer = [self.myEvaluate.homePageProfessAndAttitudeDic[@"profession"] floatValue] / 100;
    CGFloat attributePer = [self.myEvaluate.homePageProfessAndAttitudeDic[@"attitude"] floatValue] / 100;
    CGFloat professionScr = 5 * professionPer;
    CGFloat attributeScr = 5 * attributePer;
    
    NSString *scroreStr = [NSString stringWithFormat:@"%.1f分",[self.myEvaluate.techCollScore floatValue]];
    
    self.subHead.scoreLabel.attributedText = [NSString joiningTogetherSting:Localized(@"综合评分：") withAStringColor:kAppColorTextMiddleBlack andBString:scroreStr withBStringColor:kAppColorAuxiliaryLightOrange];
}

- (void)addEvaluateDataString{
    NSArray *titleArray = @[@"态度很好",@"手法专业",@"效果不错",@"颜值爆表",@"非常礼貌",@"很有耐心"];
    SYTabMode *tabMode = [SYTabMode fromJSONDictionary:self.myEvaluate.tabDic];
    NSString *attitudeGood = [tabMode.attitudeGood stringValue];
    NSString *manipulationProfession = [tabMode.manipulationProfession stringValue];
    NSString *effectGood = [tabMode.effectGood stringValue];
    NSString *goodLooking = [tabMode.goodLooking stringValue];
    NSString *politeness = [tabMode.politeness stringValue];
    NSString *patience = [tabMode.patience stringValue];
    
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

- (void)configAllEvaluateCell:(AllEvaluateCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    //头像
    NSString *iconStr = dic[@"icon"];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:placeh_userAvatar];
//    cell.iconImageView.image = placeh_userAvatar;
    //点赞数
    NSString *thumbUp = dic[@"thumbUp"];
    [cell.thumbUpBtn setTitle:thumbUp forState:(UIControlStateNormal)];
    //姓名
    cell.nameAndTimeLabel.text = [NSString stringWithFormat:@"%@ (%@)",dic[@"name"],dic[@"createTime"]];
    //评论
    cell.evaluateLabel.text = dic[@"evaluate"];
    //回复
    cell.replyLabel.text = dic[@"reply"];
}

#pragma mark AllEvaluateCellDelegate
- (void)thumbUpAtCell:(AllEvaluateCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    cell.thumbUpBtn.userInteractionEnabled = NO;
    [cell.thumbUpBtn setImage:PNGIMAGE(@"after_thumbup") forState:(UIControlStateNormal)];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    NSInteger thumbUp = [dic[@"thumbUp"] integerValue] + 1;
    [cell.thumbUpBtn setTitle:[NSString stringWithFormat:@"%ld",thumbUp] forState:(UIControlStateNormal)];
    cell.thumbUpBtn.userInteractionEnabled = NO;
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

- (NSMutableArray *)dataArray{
    [_dataArray removeAllObjects];
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    if (!isNullArray(self.myEvaluate.appraiseDetailArr)) {
        for (NSDictionary *dic in self.myEvaluate.appraiseDetailArr) {
            SYAppraiseDetialsMode *detailMode = [SYAppraiseDetialsMode fromJSONDictionary:dic];
            SYAppraiseMode *appraiseMode = [SYAppraiseMode fromJSONDictionary:detailMode.appraiseDic];
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
            //头像
            NSString *iconStr = [NSString stringWithFormat:@"%@",detailMode.userphotobaby[@"imageurl"]];
                [mutDic setObject:isNull(iconStr) == YES ? @"":iconStr forKey:@"icon"];
            //姓名
            NSString *nameStr = detailMode.devuserinfobaby[@"username"];
                [mutDic setObject:isNull(nameStr) == YES ? @"":nameStr forKey:@"name"];
            //评论内容
            NSString *appraiseStr = appraiseMode.content;
            [mutDic setObject:isNull(appraiseStr) == YES ? @"":appraiseStr forKey:@"evaluate"];
            //客服回复
            SYAppraiseReplyMode *replyMode = [SYAppraiseReplyMode fromJSONDictionary:detailMode.appraiseReplyDic];
            NSString *replyStr = replyMode.content;
            [mutDic setObject:isNull(replyStr) == YES ? @"":[NSString stringWithFormat:@"【客服回复】%@",replyStr] forKey:@"reply"];
            //点赞数
            NSString *thumUpStr = [appraiseMode.praiseCount stringValue];
            [mutDic setObject:isNull(thumUpStr) == YES ? @"0" :thumUpStr forKey:@"thumbUp"];
            //评论时间
            NSString *creatTime = detailMode.appraiseDic[@"createTime"];
            [mutDic setObject:isNull(creatTime) == YES ? @"":creatTime forKey:@"createTime"];
            
            [_dataArray addObject:mutDic];
        }
    }
    return _dataArray;
}


- (NSMutableArray *)evaluateArray{
    if (!_evaluateArray) {
        _evaluateArray = [NSMutableArray array];
        
    }
    return _evaluateArray;
}

- (NSMutableArray *)appraiseDetials{
    if (!_appraiseDetials) {
        _appraiseDetials = [NSMutableArray array];
    }
    return _appraiseDetials;
}


- (NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [NSMutableArray arrayWithArray:@[
                                                      
                                                      @{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
                                                      ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
                                                      ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"},@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"",@"thumbUp":@"12"}
                                                      ,@{@"icon":@"",@"name":@"yulaner（2016-08-31 10:20)",@"evaluate":@"很好很专业，有效果，现在奶很多了，也没有发炎。",@"reply":@"【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。\n【客服回复】非常感谢您的信任与支持，很抱歉给您带来不好的服务体验，您所反映的问题我们已经在处理，请您耐心等待。",@"thumbUp":@"2"}
                                                      
                                                      ]];
        
    }
    return _testArray;
}


@end
