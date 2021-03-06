//
//  OrdersCell.h
//  Technician
//
//  Created by 马良赞 on 16/12/29.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrdersCell;
@protocol OrdersCellDelegate <NSObject>

- (void)startBtnClickAt:(OrdersCell *)cell;
- (void)orderBtnClickAt:(OrdersCell *)cell;

@end

@interface OrdersCell : UITableViewCell
@property (nonatomic, strong) UILabel *moneyRange;

@property (nonatomic,weak) id<OrdersCellDelegate> delegate;

@end
