//
//  OrdersCell.m
//  Technician
//
//  Created by 马良赞 on 16/12/29.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "OrdersCell.h"
@interface OrdersCell ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UILabel *serviceTime;
@property (nonatomic, strong) UILabel *servicePlace;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *ordersBtn;
@end
@implementation OrdersCell

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
        [_titleLabel setTextColor:getColor(@"333333")];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _titleLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_nameLabel setTextColor:getColor(@"666666")];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _nameLabel;
}
-(UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.font = [UIFont systemFontOfSize:10*kWidthFactor];
        [_remarkLabel setTextColor:getColor(@"999999")];
        [_remarkLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _remarkLabel;
}
-(UILabel *)serviceTime{
    if (!_serviceTime) {
        _serviceTime = [[UILabel alloc]init];
        _serviceTime.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_serviceTime setTextColor:getColor(@"666666")];
        [_serviceTime setBackgroundColor:[UIColor clearColor]];
    }
    return _serviceTime;
}
-(UILabel *)servicePlace{
    if (!_servicePlace) {
        _servicePlace = [[UILabel alloc]init];
        _servicePlace.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_servicePlace setTextColor:getColor(@"666666")];
        [_servicePlace setBackgroundColor:[UIColor clearColor]];
    }
    return _servicePlace;
}
-(UILabel *)moneyRange{
    if (!_moneyRange) {
        _moneyRange = [[UILabel alloc]init];
        _moneyRange.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_moneyRange setTextColor:[UIColor orangeColor]];
        [_moneyRange setBackgroundColor:[UIColor clearColor]];
    }
    return _moneyRange;
}
-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:12*kWidthFactor];
        [_startBtn setBackgroundImage:PNGIMAGE(@"home_Start_Btn") forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _startBtn;
}
-(UIButton *)ordersBtn{
    if (!_ordersBtn) {
        _ordersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ordersBtn setBackgroundImage:PNGIMAGE(@"home_orders_btn") forState:UIControlStateNormal];
        [_ordersBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _ordersBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.remarkLabel];
    [self.contentView addSubview:self.serviceTime];
    [self.contentView addSubview:self.servicePlace];
    [self.contentView addSubview:self.moneyRange];
    [self.contentView addSubview:self.startBtn];
    [self.contentView addSubview:self.ordersBtn];
    
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20*kWidthFactor);
        make.top.equalTo(self.contentView).offset(15*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(5*kWidthFactor);
        make.top.equalTo(self.iconImg.mas_top).offset(8*kWidthFactor);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.iconImg.mas_bottom).offset(7*kWidthFactor);
    }];
    [self.serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(7*kWidthFactor);
    }];
    [self.servicePlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.serviceTime.mas_bottom).offset(7*kWidthFactor);
    }];
    [self.moneyRange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.servicePlace.mas_bottom).offset(14*kWidthFactor);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(57*kWidthFactor, 18*kHeightFactor));
    }];
    [self.ordersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10*kWidthFactor);
        make.top.equalTo(self.servicePlace.mas_bottom).offset(7*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(38*kWidthFactor, 38*kHeightFactor));
    }];
    
    
}
- (void)layoutSubviews{
    self.titleLabel.text = @"催乳开奶   (90分钟)";
    self.nameLabel.text = @"张三";
    self.iconImg.image = PNGIMAGE(@"pic_home_Portrait");
    self.remarkLabel.text = @"备注：要求要5年以上经验，懂病理知识";
    self.serviceTime.text = @"服务时间：今天（周六）9:00";
    self.servicePlace.text = @"服务地点：南山区前海路雷圳0755碧榕湾C－601";
    self.moneyRange.text = @"¥568.0                    1.9Km";
}
@end
