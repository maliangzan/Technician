//
//  SYAddressSelectCell.h
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAddressSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (void)configCellWithDictionay:(NSDictionary *)dic;
@end
