//
//  LabelSwitchCell.h
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LabelSwitchCell;
@protocol LabelSwitchCellDelegate <NSObject>

- (void)swichChangeAtCell:(LabelSwitchCell *)cell forSwitch:(UISwitch *)sender;

@end

@interface LabelSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (nonatomic,weak) id<LabelSwitchCellDelegate> delegate;

@end
