//
//  SYListContenView.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYListContenViewDelegate <NSObject>

- (void)closeTips;
- (void)selectedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SYListContenView : UIView<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) id<SYListContenViewDelegate> delegate;
- (void)show;
@end
