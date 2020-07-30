//
//  LabelButtonCell.h
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LabelButtonCell;
@protocol LabelButtonCellDelegate <NSObject>

- (void)rightBtnClickAtCell:(LabelButtonCell *)cell clickButton:(UIButton *)btn;

@end

@interface LabelButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic,weak) id<LabelButtonCellDelegate> delegate;

@end
