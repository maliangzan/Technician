//
//  SYAddressSelectCell.m
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYAddressSelectCell.h"

@implementation SYAddressSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithDictionay:(NSDictionary *)dic{
//@{@"title":@"荔枝公园",@"subtitle":@"沿湖路45号"}
    if (!isNullDictionary(dic)) {
        self.titleLabel.text = dic[@"title"];
        self.subtitleLabel.text = dic[@"subtitle"];

    }
}

@end
