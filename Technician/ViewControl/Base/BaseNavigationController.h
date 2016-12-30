//
//  BaseNavigationController.h
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BackGroundViewController.h"
typedef void(^clickBlackBtn)();
@interface BaseNavigationController : BackGroundViewController
@property(nonatomic ,strong)UIImageView *navImg;
@property(nonatomic ,strong)UIButton *backBtn;
@property(nonatomic ,strong)UILabel *titleLabel;
@property(nonatomic ,strong)UIButton *moreBtn;
@property (nonatomic, copy) clickBlackBtn blackBtn;
@end
