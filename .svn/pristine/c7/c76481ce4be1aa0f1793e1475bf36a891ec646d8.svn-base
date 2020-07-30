//
//  SYPageContenView.h
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYPageContenView;

@protocol SYPageContenViewDelegate <NSObject>
- (void)pageContenView:(SYPageContenView *)pageContenView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;
@end

@interface SYPageContenView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIViewController *parentVC;
@property (nonatomic,strong) NSMutableArray *childVCs;
@property (nonatomic,assign) CGFloat starOffSet;
@property (nonatomic,assign) BOOL isForbidScrollDelegate;
@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,weak) id<SYPageContenViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSMutableArray *)childVCs parenViewController:(UIViewController *)parentVC;
- (void)setCurrentIndex:(NSInteger)currenIndex;

@end
