//
//  OrderListBaseCell.h
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderListBaseCell;

@protocol OrderListBaseCellDelegate <NSObject>

- (void)clickStaduesBtnAtCell:(OrderListBaseCell *)cell;

@end

@interface OrderListBaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *methodBtn;
@property (weak, nonatomic) IBOutlet UIButton *staduesBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceAddressLabel;

@property (nonatomic,weak) id<OrderListBaseCellDelegate> delegate;


@end
