//
//  OrdersCell.h
//  Technician
//
//  Created by 马良赞 on 16/12/29.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYNearbyOrderMode.h"
#import "OrderCellBottomView.h"
#import "SYNearbyOrderMode.h"

@class OrdersCell;
@protocol OrdersCellDelegate <NSObject>

- (void)orderBtnClickAt:(OrdersCell *)cell;//接单
- (void)cliackStartBtnDQRAt:(OrdersCell *)cell;
- (void)cliackStartBtnDFKAt:(OrdersCell *)cell;
- (void)cliackStartBtnDFWAt:(OrdersCell *)cell;
- (void)cliackStartBtnFWZAt:(OrdersCell *)cell;
- (void)cliackStartBtnYWCAt:(OrdersCell *)cell;

@end

@interface OrdersCell : UITableViewCell<OrderCellBottomViewDelegate>
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UILabel *serviceTime;
@property (nonatomic, strong) UILabel *servicePlace;
@property (nonatomic, strong) UILabel *servicePlaceTitleLabel;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic,strong) UIButton *sexBtn;
@property (nonatomic,strong) UIButton *sourceOfOrderBtn;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) OrderCellBottomView *bottomView;
@property (nonatomic,strong) SYOrderMode *orderMode;

@property (nonatomic,weak) id<OrdersCellDelegate> delegate;

- (void)configCellWithNearbyOrderMode:(SYNearbyOrderMode *)mode source:(int)source;
//- (void)configCellWithMyOrderListMode:(SYNearbyOrderMode *)mode;
- (void)buildUI;

@end
