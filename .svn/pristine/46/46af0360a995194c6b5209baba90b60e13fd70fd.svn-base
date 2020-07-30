//
//  EvaluateHeadView.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EvaluateHeadView.h"
#import "EvaluateCollectionCell.h"

static NSString *evaluateCellID = @"EvaluateCollectionCell";
@implementation EvaluateHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.myCollectionView.backgroundColor = [UIColor whiteColor];

    self.myCollectionView.scrollEnabled = NO;
    self.myCollectionView.scrollsToTop = NO;
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    self.myCollectionView.showsHorizontalScrollIndicator = NO;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:evaluateCellID bundle:nil] forCellWithReuseIdentifier:evaluateCellID];
}

#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EvaluateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:evaluateCellID forIndexPath:indexPath];
    NSString *numStr = @"1";
    NSString *str = [self.dataArray objectAtIndex:indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@%@",str,numStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(string.length - numStr.length, numStr.length)];
    cell.titleLabel.attributedText = attrStr;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.myCollectionView.frame.size.width / 3, self.myCollectionView.frame.size.height / 2 - 10 * kHeightFactor);
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"态度很好",@"手法专业",@"效果不错",@"颜值爆表",@"非常礼貌",@"很有耐心"]];
        
    }
    return _dataArray;
}


@end
