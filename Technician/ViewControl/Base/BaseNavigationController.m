//
//  BaseNavigationController.m
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UIImageView *)navImg{
    if (!_navImg) {
        _navImg = [[UIImageView alloc]init];
        [_navImg setBackgroundColor:[UIColor whiteColor]];
    }
    return _navImg;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setBackgroundImage:PNGIMAGE(@"back_btn") forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _backBtn;
}
-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]init];
        [_moreBtn setTitle:@"More" forState:UIControlStateNormal];
        _moreBtn.titleLabel.textColor = [UIColor blackColor];
        [_moreBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _moreBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"服务接单";
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _titleLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickBackBtn{
    self.blackBtn();
}
-(void)buildUI{
    [super buildUI];
    [self.view addSubview:self.navImg];
    [self.navImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_offset(65*kHeightFactor);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.top.equalTo(self.view).offset(30*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(12*kWidthFactor, 18*kHeightFactor));
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(30*kHeightFactor);
    }];
    
    [self.view addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10*kWidthFactor);
        make.top.equalTo(self.view).offset(30*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(50*kWidthFactor, 20*kHeightFactor));
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
