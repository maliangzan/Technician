//
//  MyEvaluateMode.m
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "MyEvaluateMode.h"

@implementation MyEvaluateMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"num" : @"num",
             @"appraiseDetailArr":@"appraiseDetials",
             @"homePageProfessAndAttitudeDic":@"homePageProfessAndAttitude",
             @"homePageTid" : @"homePageTid",
             @"starLevelDic":@"starLevel",
             @"tabDic" : @"tab",
             @"serNum":@"serNum",
             @"techCollScore":@"techCollScore",

             };
}

@end
