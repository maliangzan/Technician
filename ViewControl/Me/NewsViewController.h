//
//  NewsViewController.h
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"

@interface NewsViewController : BaseNavigationController
@property (nonatomic,strong) NSMutableArray *dataArray;

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo isNoticeMessage:(BOOL)isNotice;

@end
