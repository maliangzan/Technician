//
//  OrdersBtnCell.h
//  Technician
//
//  Created by 马良赞 on 17/1/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrdersBtnCellDelegate <NSObject>

- (void)acceptOrder;

@end

@interface OrdersBtnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *occeptOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (nonatomic,weak) id<OrdersBtnCellDelegate> delegate;

@end
