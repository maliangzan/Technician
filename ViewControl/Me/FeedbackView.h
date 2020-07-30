//
//  FeedbackView.h
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray  *dataArray;

- (void)configFeedbackViewWithInfoDic:(NSDictionary *)infoDic;
@end
