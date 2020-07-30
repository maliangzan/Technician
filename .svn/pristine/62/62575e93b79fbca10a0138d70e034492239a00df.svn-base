//
//  BaseEditDataViewController.h
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"
#import "EditDataHeadView.h"

typedef void(^NextStepAction)();

@interface BaseEditDataViewController : BaseNavigationController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton *nextActionBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EditDataHeadView *headView;
@property (nonatomic,copy)NextStepAction nextStep;

- (void)congigHeadView;
- (void)registerCell;
@end
