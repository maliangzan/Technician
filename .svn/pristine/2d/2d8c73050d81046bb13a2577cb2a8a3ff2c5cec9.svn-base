//
//  IncomeDetailsBackView.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "IncomeDetailsBackView.h"

static NSString *incomeDetailCellID = @"IncomeDetailCell";
@implementation IncomeDetailsBackView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self configTitleLabel];
    [self configTimeButton:self.beginBtn];
    [self configTimeButton:self.endBtn];
    [self configSelecteButton:self.allBtn];
    
    for (UIButton *btn in self.btnArray) {
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:incomeDetailCellID bundle:nil] forCellWithReuseIdentifier:incomeDetailCellID];
}

#pragma mark Method
- (void)clickBtnAction:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
    
    for (UIButton *button in self.btnArray) {
        if (btn.tag == button.tag) {
            [self configSelecteButton:button];
        }else{
            [self configUnselectedButton:button];
        }
    }
}

- (void)configSelecteButton:(UIButton *)btn{
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = kAppColorAuxiliaryGreen.CGColor;
    [btn setTitleColor:kAppColorAuxiliaryGreen forState:(UIControlStateNormal)];
}

- (void)configUnselectedButton:(UIButton *)btn{
    btn.layer.cornerRadius = 0;
    btn.layer.borderWidth = 0;
    [btn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
}

- (void)configTimeButton:(UIButton *)btn{
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = kAppColorLineBorder.CGColor;
}

- (void)configTitleLabel{
    NSString *allNum = @"669";
    NSString *orderNum = @"238";
    NSString *assignedNum = @"431";
    NSInteger emptyNum = 4;
    NSString * str= [NSString stringWithFormat:@"总订单数%@    抢接%@    指派%@",allNum,orderNum,assignedNum];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorTextMiddleBlack range:NSMakeRange(0, str.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4, allNum.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4 + allNum.length + emptyNum + 2, orderNum.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(str.length - assignedNum.length, assignedNum.length)];
    self.titleLabel.attributedText = attrStr;
}

- (IBAction)selectBeginTime:(UIButton *)sender {
    [self.delegate selectBeginTime];
}

- (IBAction)selectEndTime:(UIButton *)sender {
    [self.delegate selectEndTime];
}

#pragma mark IncomeDetailCellDelegate
- (void)showDetailAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate showDetailForOrderNum:indexPath.row];
}

#pragma mark <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.btnArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IncomeDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:incomeDetailCellID forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offSet = self.collectionView.contentOffset;
    CGFloat offX = offSet.x;
    NSInteger index = offX / self.collectionView.frame.size.width;
    for (UIButton *button in self.btnArray) {
        if (button.tag - 100 == index) {
            [self configSelecteButton:button];
        }else{
            [self configUnselectedButton:button];
        }
    }
}

#pragma mark 懒加载
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray arrayWithArray:@[self.allBtn,self.oneMouthBtn,self.threeMouthBtn,self.halfYearBtn,self.aYearBtn]];
    }
    return _btnArray;
}

@end
