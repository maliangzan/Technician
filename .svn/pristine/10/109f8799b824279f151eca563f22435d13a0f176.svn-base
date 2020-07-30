//
//  BaseNavigationController.m
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
{
    IQKeyboardReturnKeyHandler *_returnKeyHandler;
}
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
        [_backBtn setBackgroundImage:PNGIMAGE(@"back_btn") forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _backBtn;
}

-(UIButton *)leftTextBtn{
    if (!_leftTextBtn) {
        _leftTextBtn = [[UIButton alloc]init];
        [_leftTextBtn setBackgroundColor:[UIColor clearColor]];
        [_leftTextBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];

    }
    return _leftTextBtn;
}

- (UIButton *)bigBackButton{
    if (!_bigBackButton) {
        _bigBackButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_bigBackButton addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
        [_bigBackButton setBackgroundColor:[UIColor clearColor]];
    }
    return _bigBackButton;
}

- (UIButton *)bigRightButton{
    if (!_bigRightButton) {
        _bigRightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_bigRightButton addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [_bigRightButton setBackgroundColor:[UIColor clearColor]];
    }
    return _bigRightButton;
}

-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]init];
        _moreBtn.hidden = YES;
        [_moreBtn setTitleColor:kAppColorTextLightBlack forState:UIControlStateNormal];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _moreBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:19*kWidthFactor];
        _titleLabel.textColor = kAppColorAuxiliaryGreen;
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _titleLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickMoreBtn{
    if (self.rightBtn) {
        self.rightBtn();
    }
}
-(void)clickBackBtn{
    if (self.leftBtn) {
        self.leftBtn();
    }
}
-(void)buildUI{
    [super buildUI];
    [self.view addSubview:self.navImg];
    self.navImg.userInteractionEnabled = YES;
    [self.navImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_offset(65*kHeightFactor);
    }];
    
    [self.navImg addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navImg).offset(15*kWidthFactor);
        make.top.equalTo(self.navImg).offset(30*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(12*kWidthFactor, 18*kHeightFactor));

    }];
    
    [self.navImg addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navImg.mas_centerX);
        make.top.equalTo(self.navImg).offset(30*kHeightFactor);
    }];
    
    [self.navImg addSubview:self.leftTextBtn];
    [self.leftTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navImg).offset(15*kWidthFactor);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(50*kWidthFactor, 18*kHeightFactor));
    }];
    self.leftTextBtn.hidden = YES;
    
    [self.navImg addSubview:self.bigBackButton];
    [self.bigBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navImg);
        make.top.equalTo(self.navImg);
        make.size.mas_equalTo(CGSizeMake(60*kWidthFactor, 64*kHeightFactor));
        
    }];
    
    [self.navImg addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navImg).offset(-10*kWidthFactor);
        make.centerY.equalTo(self.backBtn);
    }];
    
    [self.navImg addSubview:self.bigRightButton];
    [self.bigRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navImg);
        make.top.equalTo(self.navImg);
        make.size.mas_equalTo(CGSizeMake(60*kWidthFactor, 64*kHeightFactor));
    }];
    
}

#pragma mark - Keyboard
- (void)setKeyboardReturnKeyDone {
    _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [_returnKeyHandler setLastTextFieldReturnKeyType:UIReturnKeyDone];
}

@end
