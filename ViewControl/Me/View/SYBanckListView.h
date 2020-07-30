//
//  SYBanckListView.h
//  Technician
//
//  Created by TianQian on 2017/5/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYBanckListViewDelegate <NSObject>

- (void)cancelBank;
- (void)sureBankAtIndex:(NSInteger)index;

@end

@interface SYBanckListView : UIView<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,weak) id<SYBanckListViewDelegate> delegate;

@end
