//
//  SYServiceAddressMapBackView.h
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYServiceAddressMapBackViewDelegate <NSObject>

- (void)selectedAddressAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SYServiceAddressMapBackView : UIView<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextFeild;
@property (weak, nonatomic) IBOutlet UIView *mapBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,weak) id<SYServiceAddressMapBackViewDelegate> delegate;

@end
