//
//  OrderViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SetOrderViewController.h"
#import "SYPageTitleView.h"
#import "SYPageContenView.h"
#import "HomeViewController.h"
#import "OrderListBaseViewController.h"

#define TITLE_VIEW_HEIGHT 40 * kHeightFactor
#define MIDLLE_VIEW_HEIGHT 30 * kHeightFactor

@interface SetOrderViewController ()<SYPageTitleViewDelegate,SYPageContenViewDelegate>
@property(nonatomic, strong)UIImageView *imageView;
@property (nonatomic,strong) SYPageTitleView *pageTitleView;
@property (nonatomic,strong) SYPageContenView *pageContenView;
@property (nonatomic,strong) UIButton *serviceTypeBtn;
@property (nonatomic,strong) UIButton *serviceTimeBtn;
@property (nonatomic,assign) BOOL isUp;


@end

@implementation SetOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindData];
}

- (void)bindData{
    self.isUp = YES;
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"我的订单";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.serviceTypeBtn];
    [self.view addSubview:self.serviceTimeBtn];

    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContenView];
}

#pragma mark method
- (void)serviceTypeAction:(UIButton *)btn{
    btn.selected = YES;
    self.isUp = !self.isUp;
    [[NSUserDefaults standardUserDefaults] setBool:self.isUp forKey:isUpForMyOrderList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.serviceTimeBtn.selected = NO;
    [self.serviceTimeBtn setImage:PNGIMAGE(@"orderlist_default") forState:(UIControlStateNormal)];
    [self configButton:btn];

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSetOrderViewControllerClickServiceType object:btn userInfo:nil];
}

- (void)serviceTimeAction:(UIButton *)btn{
    btn.selected = YES;
    self.isUp = !self.isUp;
    [[NSUserDefaults standardUserDefaults] setBool:self.isUp forKey:isUpForMyOrderList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.serviceTypeBtn.selected = NO;
    [self.serviceTypeBtn setImage:PNGIMAGE(@"orderlist_default") forState:(UIControlStateNormal)];
    [self configButton:btn];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSetOrderViewControllerClickServiceTime object:btn userInfo:nil];
}

- (void)configButton:(UIButton *)btn{
    if (self.isUp) {
        [btn setImage:PNGIMAGE(@"orderlist_up") forState:(UIControlStateNormal)];
    } else {
        [btn setImage:PNGIMAGE(@"orderlist_down") forState:(UIControlStateNormal)];
    }
}

#pragma mark SYPageTitleViewDelegate
- (void)pageTitleView:(SYPageTitleView *)pageTitleView selectedIndex:(NSInteger)index{
    [self.pageContenView setCurrentIndex:index];
}

#pragma mark SYPageContenViewDelegate
- (void)pageContenView:(SYPageContenView *)pageContenView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView settitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

#pragma mark 懒加载
- (SYPageTitleView *)pageTitleView{
    if (!_pageTitleView) {
        _pageTitleView = [[SYPageTitleView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, TITLE_VIEW_HEIGHT) titles:[NSMutableArray arrayWithArray:@[@"全部",@"待确认",@"待付款",@"待服务",@"已完成"]]];
        _pageTitleView.backgroundColor = [UIColor whiteColor];
        _pageTitleView.delegate = self;
    }
    return _pageTitleView;
}

- (SYPageContenView *)pageContenView{
    if (!_pageContenView) {
        OrderListBaseViewController *allVC = [[OrderListBaseViewController alloc] initWithOrderStadues:(SYOrderStaduesAll)];
        OrderListBaseViewController *toBeConfirmedVC = [[OrderListBaseViewController alloc] initWithOrderStadues:(SYOrderStaduesToBeConfirmed)];
        OrderListBaseViewController *forThePaymentVC = [[OrderListBaseViewController alloc] initWithOrderStadues:(SYOrderStaduesForThePayment)];
        OrderListBaseViewController *forTheServiceVC = [[OrderListBaseViewController alloc] initWithOrderStadues:(SYOrderStaduesForTheService)];
        OrderListBaseViewController *completeVC = [[OrderListBaseViewController alloc] initWithOrderStadues:(SYOrderStaduesComplete)];
        _pageContenView = [[SYPageContenView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + TITLE_VIEW_HEIGHT + MIDLLE_VIEW_HEIGHT, KscreenWidth, KscreenHeight - kCustomNavHeight - TITLE_VIEW_HEIGHT - MIDLLE_VIEW_HEIGHT) childViewControllers:[NSMutableArray arrayWithArray:@[allVC,toBeConfirmedVC,forThePaymentVC,forTheServiceVC,completeVC]] parenViewController:self];
        _pageContenView.delegate = self;
    }
    return _pageContenView;
}

- (UIButton *)serviceTypeBtn{
    if (!_serviceTypeBtn) {
        CGFloat serviceBtnW = 80 * kWidthFactor;
        CGFloat serviceBtnH = 30 * kWidthFactor;
        CGFloat serviceBtnX = KscreenWidth / 2 - serviceBtnW - 10 * kWidthFactor;
        CGFloat serviceBtnY = kCustomNavHeight + TITLE_VIEW_HEIGHT + MIDLLE_VIEW_HEIGHT / 2 - serviceBtnH / 2;
        _serviceTypeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _serviceTypeBtn.frame = CGRectMake(serviceBtnX, serviceBtnY, serviceBtnW, serviceBtnH);
        [_serviceTypeBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, serviceBtnW - 5, 0,0 ))];
        [_serviceTypeBtn setImage:PNGIMAGE(@"orderlist_default") forState:(UIControlStateNormal)];//cbb_service-type
        _serviceTypeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_serviceTypeBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];
        [_serviceTypeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateSelected)];
        [_serviceTypeBtn setTitle:Localized(@"服务类型") forState:(UIControlStateNormal)];
        [_serviceTypeBtn addTarget:self action:@selector(serviceTypeAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        _serviceTypeBtn.selected = YES;
        
    }
    return _serviceTypeBtn;
}

- (UIButton *)serviceTimeBtn{
    if (!_serviceTimeBtn) {
        CGFloat serviceBtnW = 80 * kWidthFactor;
        CGFloat serviceBtnH = 30 * kWidthFactor;
        CGFloat serviceBtnX = KscreenWidth / 2;
        CGFloat serviceBtnY = kCustomNavHeight + TITLE_VIEW_HEIGHT + MIDLLE_VIEW_HEIGHT / 2 - serviceBtnH / 2;
        _serviceTimeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _serviceTimeBtn.frame = CGRectMake(serviceBtnX, serviceBtnY, serviceBtnW, serviceBtnH);
        [_serviceTimeBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, serviceBtnW - 5, 0,0 ))];
        [_serviceTimeBtn setImage:PNGIMAGE(@"orderlist_up") forState:(UIControlStateNormal)];
        _serviceTimeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_serviceTimeBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];
        [_serviceTimeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateSelected)];
        [_serviceTimeBtn setTitle:Localized(@"服务时间") forState:(UIControlStateNormal)];
        [_serviceTimeBtn addTarget:self action:@selector(serviceTimeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _serviceTimeBtn.selected = YES;
        
    }
    return _serviceTimeBtn;
}


@end
