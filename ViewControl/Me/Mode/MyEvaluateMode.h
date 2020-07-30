//
//  MyEvaluateMode.h
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface MyEvaluateMode : SYMode
@property (nonatomic,strong) NSNumber *num;//全部评论
@property (nonatomic,strong) NSNumber *serNum;//服务次数
@property (nonatomic,strong) NSArray *appraiseDetailArr;//评价详述
@property (nonatomic,strong) NSDictionary *homePageProfessAndAttitudeDic;//首页专业评级、态度评级
@property (nonatomic,strong) NSNumber *homePageTid;//技师编号
@property (nonatomic,strong) NSDictionary *starLevelDic;//星级
@property (nonatomic,strong) NSDictionary *tabDic;//标签
@property (nonatomic,copy) NSString *techCollScore;//评分
@end
