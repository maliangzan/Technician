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
        [_iconImg setBackgroundColor:[UIColor redColor]];
    }
    return _iconImg;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setBackgroundColor:[UIColor redColor]];
    }
    return _titleLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setBackgroundColor:[UIColor redColor]];
    }
    return _nameLabel;
}
-(UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        [_remarkLabel setBackgroundColor:[UIColor redColor]];
    }
    return _remarkLabel;
}
-(UILabel *)serviceTime{
    if (!_serviceTime) {
        _serviceTime = [[UILabel alloc]init];
        [_serviceTime setBackgroundColor:[UIColor redColor]];
    }
    return _serviceTime;
}
-(UILabel *)servicePlace{
    if (!_servicePlace) {
        _servicePlace = [[UILabel alloc]init];
        [_servicePlace setBackgroundColor:[UIColor redColor]];
    }
    return _servicePlace;
}
-(UILabel *)moneyRange{
    if (!_moneyRange) {
        _moneyRange = [[UILabel alloc]init];
        [_moneyRange setBackgroundColor:[UIColor redColor]];
    }
    return _moneyRange;
}
-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundColor:[UIColor redColor]];
    }
    return _startBtn;
}
-(UIButton *)ordersBtn{
    if (!_ordersBtn) {
        _ordersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ordersBtn setBackgroundColor:[UIColor redColor]];
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
//    [self.contentView addSubview:self.startBtn];
//    [self.contentView addSubview:self.ordersBtn];
    
    [self.moneyRange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
        make.top.equalTo(self.contentView).offset(10*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 20*kHeightFactor));
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
        make.top.equalTo(self.moneyRange.mas_top).offset(30*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(5*kWidthFactor);
        make.top.equalTo(self.moneyRange.mas_top).offset(30*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(200*kWidthFactor, 20*kHeightFactor));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(5*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(200*kWidthFactor, 20*kHeightFactor));
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
        make.right.equalTo(self.contentView).offset(-10*kWidthFactor);
        make.top.equalTo(self.iconImg.mas_bottom).offset(2*kWidthFactor);
        make.height.mas_offset(20*kHeightFactor);
    }];
    [self.serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
        make.right.equalTo(self.contentView).offset(-10*kWidthFactor);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(2*kWidthFactor);
        make.height.mas_offset(20*kHeightFactor);
    }];
    [self.servicePlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
        make.right.equalTo(self.contentView).offset(-10*kWidthFactor);
        make.top.equalTo(self.serviceTime.mas_bottom).offset(2*kWidthFactor);
        make.height.mas_offset(20*kHeightFactor);
    }];
//    [self.moneyRange mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.top.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
//    }];
//    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.top.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
//    }];
//    [self.ordersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.top.equalTo(self.contentView).offset(10*kWidthFactor);
//        make.size.mas_equalTo(CGSizeMake(55*kWidthFactor, 55*kHeightFactor));
//    }];
    
    
}
- (void)layoutSubviews{
//    [self.moneyRange mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(-20*kWidthFactor);
//    }];

}
@end
