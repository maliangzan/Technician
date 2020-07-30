//
//  MoreServiceView.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYOnlyLabelCell;

@protocol MoreServiceViewDelegate <NSObject>

- (void)closeMoreServiceView;
- (void)selectServiceAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MoreServiceView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic,weak) id<MoreServiceViewDelegate> delegate;


@end
