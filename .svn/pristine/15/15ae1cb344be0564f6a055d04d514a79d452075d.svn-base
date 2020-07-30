//
//  SYPageTitleView.h
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYPageTitleView;
@protocol SYPageTitleViewDelegate <NSObject>

- (void)pageTitleView:(SYPageTitleView *)pageTitleView selectedIndex:(NSInteger)index;

@end

@interface SYPageTitleView : UIView
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *titleLabels;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *scrollLine;

@property (nonatomic,weak) id<SYPageTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;
- (void)settitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end
