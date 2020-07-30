//
//  OrderListBaseViewController.h
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderListBaseViewController : BaseViewController
@property (nonatomic,assign) SYOrderStadues orderStadues;

- (instancetype)initWithOrderStadues:(SYOrderStadues)orderStadues;
@end
