//
//  IncomeDetailCell.h
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletStatementCell.h"

@protocol IncomeDetailCellDelegate <NSObject>

- (void)showDetailAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IncomeDetailCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource,WalletStatementCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) id<IncomeDetailCellDelegate> delegate;

@end
