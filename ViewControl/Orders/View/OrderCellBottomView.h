//
//  OrderCellBottomView.h
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCellBottomViewDelegate <NSObject>

- (void)order;

@end

@interface OrderCellBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (nonatomic,weak) id<OrderCellBottomViewDelegate> delegate;


@end
