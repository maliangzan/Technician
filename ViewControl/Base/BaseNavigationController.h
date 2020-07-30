//
//  BaseNavigationController.h
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BackGroundViewController.h"
typedef void(^clickBackBtn)();
typedef void(^clickMoreBtn)();
@interface BaseNavigationController : BackGroundViewController
@property(nonatomic ,strong)UIImageView *navImg;
@property(nonatomic ,strong)UIButton *backBtn;
//backBtn覆盖一个大的button 方便点击返回按钮
@property (nonatomic,strong) UIButton *bigBackButton;
//right覆盖一个大的button 方便点击
@property (nonatomic,strong) UIButton *bigRightButton;
@property(nonatomic ,strong)UILabel *titleLabel;
@property(nonatomic ,strong)UIButton *moreBtn;
@property (nonatomic,strong) UIButton *leftTextBtn;
@property (nonatomic, copy) clickBackBtn leftBtn;
@property (nonatomic, copy) clickMoreBtn rightBtn;

- (void)setKeyboardReturnKeyDone;

@end