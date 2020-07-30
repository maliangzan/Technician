//
//  SYPageContenView.m
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYPageContenView.h"

static NSString *contenCellID = @"cell";
@implementation SYPageContenView

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSMutableArray *)childVCs parenViewController:(UIViewController *)parentVC{
    if ([super initWithFrame:frame]) {
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        
        [self setupUI];
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currenIndex{
    //1.记录需要禁止的执行代理方法
    self.isForbidScrollDelegate = YES;
    CGFloat offSetX = (CGFloat)currenIndex * self.collectionView.frame.size.width;
    //2.滚动到正确的位置
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currenIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
//    [self.collectionView setContentOffset:CGPointMake(offSetX, 0) animated:NO];
}

#pragma mark  method
- (void)setupUI{
    for (UIViewController *childVC in self.childVCs) {
        [self.parentVC addChildViewController:childVC];
    }
    
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
}

#pragma mark <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contenCellID forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIViewController *vc = [self.childVCs objectAtIndex:indexPath.row];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isForbidScrollDelegate = NO;
    self.starOffSet = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //0.判断是否是点击事件
    if (_isForbidScrollDelegate) {
        return;
    }
    //1.定义需要的数据
    CGFloat progress = 0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    //2.判断是左滑还是右滑
    CGFloat currentOffSetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.frame.size.width;
    if (currentOffSetX > self.starOffSet) {//左滑
        //1.计算progress
        progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW);
        //2.计算sourceIndex
        sourceIndex = (NSInteger)(currentOffSetX / scrollViewW);
        //3.计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVCs.count) {
            targetIndex = self.childVCs.count - 1;
            
        }
        
        //4.如果完全滑过
        if (currentOffSetX - self.starOffSet == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
        }
    }else{//右滑
        //1.计算progress
        progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW));
        //2.计算sourceIndex
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.childVCs.count) {
            sourceIndex = self.childVCs.count - 1;
        }
        //3.计算targetIndex
        targetIndex = (NSInteger)(currentOffSetX / scrollViewW);
    }
        //3.传值
    [self.delegate pageContenView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

#pragma mark 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:contenCellID];
    }
    return _collectionView;
}

@end
