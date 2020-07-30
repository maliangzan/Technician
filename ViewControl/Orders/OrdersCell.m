//
//  OrdersCell.m
//  Technician
//
//  Created by 马良赞 on 16/12/29.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "OrdersCell.h"
#import "SYCustomMode.h"
#import "SYOrderMode.h"
#import "SYLocationMode.h"
#import "SYServiceInfoMode.h"
#import "JYUserMode.h"
#import "SYTimeHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrdersCell ()

@end
@implementation OrdersCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithNearbyOrderMode:(SYNearbyOrderMode *)mode source:(int)source{
    //**********************************************************//
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:mode.order];
    self.orderMode = orderMode;
    SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:mode.serviceInfo];
    SYCustomMode *customMode = [SYCustomMode fromJSONDictionary:mode.customer];
    SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:mode.sLocation];
    JYUserMode *user = [JYUserMode fromJSONDictionary:mode.user];
    NSString *titleStr = [NSString stringWithFormat:@"%@   (%@分钟)",isNull(serviceInfoMode.name) == YES ? @"":serviceInfoMode.name,isNull([serviceInfoMode.serviceTotalTime stringValue]) == YES ? @"0":serviceInfoMode.serviceTotalTime];
    self.titleLabel.text = titleStr;
    
    self.nameLabel.text = user.name;
    
    if ([user.sex integerValue] == 0) {
        [self.sexBtn setImage:PNGIMAGE(@"man") forState:(UIControlStateNormal)];
    }else{
        [self.sexBtn setImage:PNGIMAGE(@"woman") forState:(UIControlStateNormal)];
    }
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:serviceInfoMode.img] placeholderImage:PNGIMAGE(@"pic_home_Portrait")];
    
    //抢接或指派
    if ([orderMode.type isEqualToString:@"qd"]) {
        [self.sourceOfOrderBtn setImage:PNGIMAGE(@"img_rob") forState:(UIControlStateNormal)];
    } else {
        [self.sourceOfOrderBtn setImage:PNGIMAGE(@"img_assigned") forState:(UIControlStateNormal)];
    }
    NSString *markStr = [NSString stringWithFormat:@"备注：%@",orderMode.otherRequirement];
    self.remarkLabel.text = markStr;
    
    NSString *serviceTimeStr = [NSString stringWithFormat:@"服务时间：%@",isNull(orderMode.appointServiceTime) == YES ? @"" : orderMode.appointServiceTime];
    self.serviceTime.text = serviceTimeStr;
    
    NSString *serviceAddressStr = [NSString stringWithFormat:@"%@",isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress];
    self.servicePlace.text = serviceAddressStr;
    
    NSString *priceStr = [NSString stringWithFormat:@"¥%.2f",[serviceInfoMode.price floatValue] / 100];
    self.bottomView.priceLabel.text = priceStr;
    
    NSString *distanceStr = [NSString stringWithFormat:@"%.2fKm",[mode.distance floatValue]];
    self.bottomView.distanceLabel.text = distanceStr;
    
    //home_orders_btn接单
    //home_un_orders_btn接单灰
    //has_order已接
    if ([orderMode.state isEqualToString:@"dqr"]) {
        [self configButton:self.startBtn withTitle:@"待确认" backgroungImage:@"btn_gray_d" action:@selector(clickActionWithStateDQR) titleColor:[UIColor whiteColor]];
        if ([[SYAppConfig shared].me.state isEqualToString:@"jdz"]) {
            
            [self.bottomView.orderBtn setImage:PNGIMAGE(@"home_orders_btn") forState:(UIControlStateNormal)];
            
        } else {
            [self.bottomView.orderBtn setImage:PNGIMAGE(@"home_un_orders_btn") forState:(UIControlStateNormal)];
        }
        
        self.bottomView.orderBtn.userInteractionEnabled = YES;
    }else if ([orderMode.state isEqualToString:@"dfk"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
    }else if ([orderMode.state isEqualToString:@"dfw"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
        
    }else if ([orderMode.state isEqualToString:@"fwz"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
        
    }else if ([orderMode.state isEqualToString:@"ywc"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
        
    }else if ([orderMode.state isEqualToString:@"tkz"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
        
    }else if ([orderMode.state isEqualToString:@"dtk"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
        
    }else if ([orderMode.state isEqualToString:@"ygb"]){
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
    }else{
        [self.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
        self.bottomView.orderBtn.userInteractionEnabled = NO;
    }
    
    if (source == 0) {
        //我的订单
        if ([orderMode.state isEqualToString:@"dqr"]) {
            [self configButton:self.startBtn withTitle:@"待确认" backgroungImage:@"btn_gray_d" action:@selector(clickActionWithStateDQR) titleColor:[UIColor whiteColor]];
        }else if ([orderMode.state isEqualToString:@"dfk"]){
            [self configButton:self.startBtn withTitle:@"待付款" backgroungImage:@"btn_gray_d" action:@selector(clickActionWithStateDFK) titleColor:kAppColorTextMiddleBlack];
        }else if ([orderMode.state isEqualToString:@"dfw"]){
            [self configButton:self.startBtn withTitle:@"开始" backgroungImage:@"btn_orange_n" action:@selector(clickActionWithStateDFW) titleColor:[UIColor whiteColor]];
        }else if ([orderMode.state isEqualToString:@"fwz"]){
            [self configButton:self.startBtn withTitle:@"服务中" backgroungImage:@"btn_orange_n" action:@selector(clickActionWithStateFWZ) titleColor:[UIColor whiteColor]];
        }else if ([orderMode.state isEqualToString:@"ywc"]){
            NSString *titleString = Localized(@"待评价");
            if (orderMode.isAppraise) {
                titleString = Localized(@"已评价");
            }
            [self configButton:self.startBtn withTitle:titleString backgroungImage:@"btn_gray_d" action:@selector(clickActionWithStateYWC) titleColor:kAppColorTextMiddleBlack];
        }else if ([orderMode.state isEqualToString:@"tkz"]){
            [self configButton:self.startBtn withTitle:@"退款中" backgroungImage:@"btn_gray_d" action:nil titleColor:kAppColorTextMiddleBlack];
        }else if ([orderMode.state isEqualToString:@"dtk"]){
            [self configButton:self.startBtn withTitle:@"待退款" backgroungImage:@"btn_gray_d" action:nil titleColor:kAppColorTextMiddleBlack];
        }else if ([orderMode.state isEqualToString:@"ygb"]){
            [self configButton:self.startBtn withTitle:@"已关闭" backgroungImage:@"btn_gray_d" action:nil titleColor:kAppColorTextMiddleBlack];
        }else{
            [self configButton:self.startBtn withTitle:@"其他状态" backgroungImage:@"btn_gray_d" action:@selector(clickActionWithStateNone) titleColor:kAppColorTextMiddleBlack];
        }
    }else{
        NSString *timesString = [NSString stringWithFormat:@"%@分钟前",mode.timeCount];
        if ([mode.timeCount integerValue] >= 60) {
            timesString = Localized(@"1小时前");
        }
        [self.startBtn setTitle:timesString forState:(UIControlStateNormal)];
        [self.startBtn setBackgroundImage:PNGIMAGE(@"selected") forState:(UIControlStateNormal)];
        [self.startBtn setTitleColor:kAppColorAuxiliaryGreen forState:(UIControlStateNormal)];
    }

}

#pragma mark method
- (void)configButton:(UIButton *)btn withTitle:(NSString *)title backgroungImage:(NSString *)imageName action:(SEL)selector titleColor:(UIColor *)titleColr{
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:titleColr forState:(UIControlStateNormal)];
    [btn setBackgroundImage:PNGIMAGE(imageName) forState:(UIControlStateNormal)];
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)buildUI{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.sexBtn];
    [self.contentView addSubview:self.sourceOfOrderBtn];
    [self.contentView addSubview:self.remarkLabel];
    [self.contentView addSubview:self.serviceTime];
    [self.contentView addSubview:self.servicePlaceTitleLabel];
    [self.contentView addSubview:self.servicePlace];
    [self.contentView addSubview:self.startBtn];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.lineView];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20*kWidthFactor);
        make.top.equalTo(self.contentView).offset(15*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
        
    }];
    self.iconImg.layer.cornerRadius = 55*kWidthFactor / 2;
    self.iconImg.layer.masksToBounds = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(5*kWidthFactor);
        make.right.equalTo(self.mas_right).offset(-65*kWidthFactor);
        make.top.equalTo(self.iconImg.mas_top).offset(8*kWidthFactor);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
    }];
    [self.sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(12*kWidthFactor, 13*kHeightFactor));
    }];
    [self.sourceOfOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sexBtn.mas_right).offset(8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(20*kWidthFactor, 13*kHeightFactor));
    }];
    
//    [self.remarkLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel);
//        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
//        
//    }];
//    
//    [self.serviceTime mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.iconImg);
//        make.top.equalTo(self.remarkLabel.mas_bottom).offset(8*kWidthFactor);
//    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7*kWidthFactor);
    }];
    [self.serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(7*kWidthFactor);
    }];
    
    CGFloat servicePlaceTileLabelWidth = [NSString widthForString:@"服务地点：" labelHeight:15*kHeightFactor fontOfSize:12*kWidthFactor] + 3;
    [self.servicePlaceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.serviceTime.mas_bottom).offset(7*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(servicePlaceTileLabelWidth, 15));
    }];
    
    [self.servicePlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.servicePlaceTitleLabel.mas_right);
        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
        make.top.equalTo(self.serviceTime.mas_bottom).offset(7*kWidthFactor);
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(57*kWidthFactor, 25));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.servicePlace.mas_bottom);//.offset(14*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 20*kWidthFactor, 40*kHeightFactor));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);//.offset(14*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, 1));
    }];
 //20*kWidthFactor + 8*kWidthFactor
}

#pragma mark OrderCellBottomViewDelegate
//接单
- (void)order{
    [self.delegate orderBtnClickAt:self];
}

#pragma mark method

//待确认
- (void)clickActionWithStateDQR{
    if ([self.orderMode.state isEqualToString:@"dqr"]) {
        [self.delegate cliackStartBtnDQRAt:self];
    }
}
//待付款
- (void)clickActionWithStateDFK{
    if ([self.orderMode.state isEqualToString:@"dfk"]) {
        [self.delegate cliackStartBtnDFKAt:self];
    }
    
}

//待服务
- (void)clickActionWithStateDFW{
    if ([self.orderMode.state isEqualToString:@"dfw"]) {
        [self.delegate cliackStartBtnDFWAt:self];
    }
    
}

//服务中
- (void)clickActionWithStateFWZ{
    if ([self.orderMode.state isEqualToString:@"fwz"]) {
        [self.delegate cliackStartBtnFWZAt:self];
    }
    
}

//已完成
- (void)clickActionWithStateYWC{
    if ([self.orderMode.state isEqualToString:@"ywc"]) {
        [self.delegate cliackStartBtnYWCAt:self];
    }
    
}

//已取消
- (void)clickActionWithStateYQX{
    if ([self.orderMode.state isEqualToString:@"dqr"]) {
        
    }
}

- (void)clickActionWithStateNone{
    if ([self.orderMode.state isEqualToString:@"dqr"]) {
        
    }
//    [self showHUDForError:@"其他状态"];
}

#pragma mark get
-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        [_iconImg setBackgroundColor:[UIColor clearColor]];
        
    }
    return _iconImg;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14*kWidthFactor];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setTextColor:kAppColorTextMiddleBlack];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _titleLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_nameLabel setTextColor:kAppColorTextLightBlack];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _nameLabel;
}

- (UIButton *)sexBtn{
    if (!_sexBtn) {
        _sexBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sexBtn setImage:PNGIMAGE(@"woman") forState:(UIControlStateNormal)];
    }
    return _sexBtn;
}
- (UIButton *)sourceOfOrderBtn{
    if (!_sourceOfOrderBtn) {
        _sourceOfOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sourceOfOrderBtn setImage:PNGIMAGE(@"img_rob") forState:(UIControlStateNormal)];
    }
    return _sourceOfOrderBtn;
}
-(UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.font = [UIFont systemFontOfSize:10*kWidthFactor];
        [_remarkLabel setTextColor:kAppColorTextLightGray];
        [_remarkLabel setBackgroundColor:[UIColor clearColor]];
        _remarkLabel.numberOfLines = 0;
    }
    return _remarkLabel;
}
-(UILabel *)serviceTime{
    if (!_serviceTime) {
        _serviceTime = [[UILabel alloc]init];
        _serviceTime.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_serviceTime setTextColor:kAppColorTextLightBlack];
        [_serviceTime setBackgroundColor:[UIColor clearColor]];
    }
    return _serviceTime;
}
-(UILabel *)servicePlace{
    if (!_servicePlace) {
        _servicePlace = [[UILabel alloc]init];
        _servicePlace.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_servicePlace setTextColor:kAppColorTextLightBlack];
        [_servicePlace setBackgroundColor:[UIColor clearColor]];
        _servicePlace.numberOfLines = 0;
    }
    return _servicePlace;
}

-(UILabel *)servicePlaceTitleLabel{
    if (!_servicePlaceTitleLabel) {
        _servicePlaceTitleLabel = [[UILabel alloc]init];
        _servicePlaceTitleLabel.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_servicePlaceTitleLabel setTextColor:kAppColorTextLightBlack];
        [_servicePlaceTitleLabel setBackgroundColor:[UIColor clearColor]];
        _servicePlaceTitleLabel.text = @"服务地点：";
    }
    return _servicePlaceTitleLabel;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_startBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];
        [_startBtn setBackgroundImage:PNGIMAGE(@"home_Start_Btn") forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _startBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kAppColorBackground;
    }
    return _lineView;
}

- (OrderCellBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"OrderCellBottomView" owner:nil options:nil] objectAtIndex:0];
        _bottomView.delegate = self;
    }
    return _bottomView;
}



@end
