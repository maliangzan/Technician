//
//  WalletStatementCell.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WalletStatementCell;
@protocol WalletStatementCellDelegate <NSObject>
- (void)showDetailAtCell:(WalletStatementCell *)cell;
@end

@interface WalletStatementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
//default width = 36
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailBtnWidth;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (nonatomic,weak) id<WalletStatementCellDelegate> delegate;

@end
