//
//  OrderHeadView.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation OrderHeadView

- (void)configHeadViewWith:(SYNearbyOrderMode *)nearbyMode{
    SYServiceInfoMode *serviceMode = [SYServiceInfoMode fromJSONDictionary:nearbyMode.serviceInfo];
    NSString *iconUrl = nearbyMode.serviceInfo[@"img"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:placeh_userAvatar];

    NSString *name = isNull(serviceMode.name) == YES ? @"":serviceMode.name;
    self.titleLabel.text = name;
    
    NSString *method = isNull(serviceMode.posture) == YES ? @"":serviceMode.posture;
    self.methodLabel.text = method;
    
    NSString *discreptionStr = isNull(serviceMode.SerciceDescription) == YES ? @"":serviceMode.SerciceDescription;
    self.discreptionLabel.text = discreptionStr;
    
    NSString *serviceTime = isNull([serviceMode.serviceTotalTime stringValue]) == YES ? @"0":[serviceMode.serviceTotalTime stringValue];
    [self.timeBtn setTitle:[NSString stringWithFormat:@"%@分钟",serviceTime] forState:(UIControlStateNormal)];
    
    NSString *price = isNull([serviceMode.price stringValue]) == YES? @"0":[serviceMode.price stringValue];
    CGFloat showPrice = [price floatValue] / 100;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",showPrice];
    
    SYOrderMode *order = [SYOrderMode fromJSONDictionary:nearbyMode.order];
    [self configProgressWith:order];
    
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:nearbyMode.order];
    if ([orderMode.type isEqualToString:@"qd"]) {
        [self.staduesBtn setImage:PNGIMAGE(@"img_rob") forState:(UIControlStateNormal)];
    } else {
        [self.staduesBtn setImage:PNGIMAGE(@"img_assigned") forState:(UIControlStateNormal)];
    }
}

- (void)configProgressWith:(SYOrderMode *)orderMode{
    
    if ([orderMode.state isEqualToString:@"dqr"]) {
        [self configHeadViewWithToBeConfirmedBtnImage:@"101ing"
                                forThePaymentBtnImage:@"102un_ing"
                                forTheServiceBtnImage:@"103un_ing"
                                     completeBtnImage:@"104un_ing"];
    } else if([orderMode.state isEqualToString:@"dfk"]) {
        [self configHeadViewWithToBeConfirmedBtnImage:@"100ing"
                                forThePaymentBtnImage:@"102ing"
                                forTheServiceBtnImage:@"103un_ing"
                                     completeBtnImage:@"104un_ing"];
    }else if([orderMode.state isEqualToString:@"dfw"]) {
        [self configHeadViewWithToBeConfirmedBtnImage:@"100ing"
                                forThePaymentBtnImage:@"100ing"
                                forTheServiceBtnImage:@"103ing"
                                     completeBtnImage:@"104un_ing"];
    }else if([orderMode.state isEqualToString:@"fwz"]) {
        [self configHeadViewWithToBeConfirmedBtnImage:@"100ing"
                                forThePaymentBtnImage:@"100ing"
                                forTheServiceBtnImage:@"103ing"
                                     completeBtnImage:@"104un_ing"];
    }else if([orderMode.state isEqualToString:@"ywc"]) {
        [self configHeadViewWithToBeConfirmedBtnImage:@"100ing"
                                forThePaymentBtnImage:@"100ing"
                                forTheServiceBtnImage:@"100ing"
                                     completeBtnImage:@"104ing"];
    }
}
- (void)configHeadViewWithToBeConfirmedBtnImage:(NSString *)toBeConfirmedImage forThePaymentBtnImage:(NSString *)forThePaymentImage forTheServiceBtnImage:(NSString *)forTheServiceImage completeBtnImage:(NSString *)completeImage{
    [self.toBeConfirmedBtn setImage:PNGIMAGE(toBeConfirmedImage) forState:(UIControlStateNormal)];
    [self.forThePaymentBtn setImage:PNGIMAGE(forThePaymentImage) forState:(UIControlStateNormal)];
    [self.forTheServiceBtn setImage:PNGIMAGE(forTheServiceImage) forState:(UIControlStateNormal)];
    [self.completeBtn setImage:PNGIMAGE(completeImage) forState:(UIControlStateNormal)];
}

@end
