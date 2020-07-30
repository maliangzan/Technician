//
//  IncomeDetailsBackView.h
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDetailCell.h"
#import "SYIncomeDetailsMode.h"

@protocol IncomeDetailsBackViewDelegate <NSObject>

- (void)selectBeginTime;
- (void)selectEndTime;
- (void)showDetailWithMode:(SYIncomeEarningMode *)mode;
- (void)selectMouthButtonAtIndex:(NSInteger)index;

@end

@interface IncomeDetailsBackView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,IncomeDetailCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneMouthBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeMouthBtn;
@property (weak, nonatomic) IBOutlet UIButton *halfYearBtn;
@property (weak, nonatomic) IBOutlet UIButton *aYearBtn;
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,weak) id<IncomeDetailsBackViewDelegate> delegate;

- (void)configTitleLabelWithMode:(SYIncomeDetailsMode *)incomeDetailMode;
@end
