//
//  ServiceAddressCell.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceAddressCell.h"

@implementation ServiceAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configServiceAddressCellWithDictionary:(NSDictionary *)dic{
    if (!isNullDictionary(dic)) {
        self.addressLabel.text = dic[@"address"];
        if ([dic[@"sex"] isEqualToString:@"0"]) {
            [self.sexBtn setImage:PNGIMAGE(@"man") forState:(UIControlStateNormal)];
        } else {
            [self.sexBtn setImage:PNGIMAGE(@"woman") forState:(UIControlStateNormal)];
        }
        self.nameLabel.text = dic[@"content"];
        [self.distanceBtn setTitle:dic[@"distanceStr"] forState:(UIControlStateNormal)];
    }
    
}

- (IBAction)contactUserAction:(UIButton *)sender {
    [self.delegate contactUserAtCell:self];
}

- (IBAction)locationAction:(UIButton *)sender {
    [self.delegate locationTheAddressAtCell:self];
}

@end
