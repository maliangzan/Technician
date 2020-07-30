//
//  SYPageTitleView.m
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYPageTitleView.h"

static CGFloat kScrollViewLineH = 2;
@implementation SYPageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles{
    if ([super initWithFrame:frame]) {
        self.titles = titles;
        [self setupUI];
    }
    return self;
}

- (void)settitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{
    //1.取出sourceLabel和targetLabel
    UILabel *sourceLabel = [self.titleLabels objectAtIndex:sourceIndex];
    UILabel *targetLabel = [self.titleLabels objectAtIndex:targetIndex];
    
    //2.处理滑块的逻辑
    CGFloat scrollLineX = targetLabel.frame.origin.x;
    CGFloat scrollLineY = self.scrollLine.frame.origin.y;
    CGFloat scrollLineW = self.scrollLine.frame.size.width;
    CGFloat scrollLineH = self.scrollLine.frame.size.height;
    self.scrollLine.frame = CGRectMake(scrollLineX, scrollLineY, scrollLineW, scrollLineH);

    //有时间再优化滑动效果
//    CGFloat moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
//    CGFloat moveX = moveTotalX * progress;
//    CGFloat scrollLineX = sourceLabel.frame.origin.x + moveX;
//    CGFloat scrollLineY = self.scrollLine.frame.origin.y;
//    CGFloat scrollLineW = self.scrollLine.frame.size.width;
//    CGFloat scrollLineH = self.scrollLine.frame.size.height;
//    self.scrollLine.frame = CGRectMake(scrollLineX, scrollLineY, scrollLineW, scrollLineH);
    
    //3.颜色的渐变（复杂）
    //3.1取出变化的范围
    //155 155 155 灰色 始
    //28 198 162  绿色 终
    //颜色渐变效果，需要调一下
//    CGFloat colorDeltaR = 28 - 155;
//    CGFloat colorDeltaG = 198 - 155;
//    CGFloat colorDeltaB = 162 - 155;
//    
//    sourceLabel.textColor = [UIColor colorWithRed:(28 - colorDeltaR * progress)/255.0 green:(198 - colorDeltaG * progress)/255.0 blue:(162 - colorDeltaB * progress)/255.0 alpha:1];
//    targetLabel.textColor = [UIColor colorWithRed:(28 + colorDeltaR * progress)/255.0 green:(198 + colorDeltaR * progress)/255.0 blue:(162 + colorDeltaR * progress)/255.0 alpha:1];

    for (UILabel *label in self.titleLabels) {
        if (label.tag - 100 == targetIndex) {
            label.textColor = kAppColorAuxiliaryGreen;
        }else{
            label.textColor = kAppColorTextLightBlack;
        }
    }
    
    //4.记录最新的index
    self.currentIndex = targetIndex;
}

#pragma mark method
- (void)setupUI{
    //1.添加UIScrollView
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    
    //2.添加title对应的label
    [self addTitleLabels];
    
    //3.设置底线和滚动的滑块
    [self addBottomMenuAndScrollLine];
}

- (void)addTitleLabels{
    CGFloat labelW = self.frame.size.width / (CGFloat)self.titles.count;
    CGFloat labelH = self.frame.size.height - kScrollViewLineH;
    CGFloat labelY = 0;
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [self.titles objectAtIndex:i];
        label.tag = 100 + i;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = kAppColorTextMiddleBlack;
        label.textAlignment = NSTextAlignmentCenter;
        CGFloat labelX = labelW * (CGFloat)i;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [self.scrollView addSubview:label];
        [self.titleLabels addObject:label];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
    }

}

- (void)titleLabelClick:(UITapGestureRecognizer *)tap{
    //1.获取当前label的下标值
    UILabel *currentLabel = (UILabel *)tap.view;
    
    //2.获取之前的label
    UILabel *oldLabel = [self.titleLabels objectAtIndex:self.currentIndex];
    
    //3.切换文字的颜色
    currentLabel.textColor = kAppColorAuxiliaryGreen;
    oldLabel.textColor = kAppColorTextMiddleBlack;
    
    //4.滚动条位置发生改变
    CGFloat scrollLineX = (CGFloat)(currentLabel.tag - 100) * self.scrollLine.frame.size.width;
    CGFloat scrollLineY = self.scrollLine.frame.origin.y;
    CGFloat scrollLineW = self.scrollLine.frame.size.width;
    CGFloat scrollLineH = self.scrollLine.frame.size.height;
    WeakSelf;
    [UIView animateWithDuration:0.15 animations:^{
        weakself.scrollLine.frame = CGRectMake(scrollLineX, scrollLineY, scrollLineW, scrollLineH);
    }];
    
    //5.保存最新label的下标值
    self.currentIndex = currentLabel.tag - 100;
    
    //6.通知代理
    [self.delegate pageTitleView:self selectedIndex:self.currentIndex];
}

- (void)addBottomMenuAndScrollLine{
    //1.添加底线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kAppColorLine;
    CGFloat lineHeigt = 0.5;
    bottomLine.frame = CGRectMake(0, self.frame.size.height - lineHeigt, self.frame.size.width, lineHeigt);
    [self addSubview:bottomLine];
    
    //2.添加scrollLine
    //2.1获取第一个label
    UILabel *firstLabel = [self.titleLabels firstObject];
    firstLabel.textColor = kAppColorAuxiliaryGreen;
    
    //2.2设置scrollView的属性
    [self.scrollView addSubview:self.scrollLine];
    self.scrollLine.frame = CGRectMake(firstLabel.frame.origin.x, self.frame.size.height - kScrollViewLineH, firstLabel.frame.size.width, kScrollViewLineH);
}

#pragma mark 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)scrollLine{
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = kAppColorAuxiliaryGreen;
    }
    return _scrollLine;
}

- (NSMutableArray *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

@end
