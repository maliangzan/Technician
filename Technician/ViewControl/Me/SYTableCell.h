//
//  SYTableCell.h
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYTableCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end
