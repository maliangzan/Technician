//
//  MoreServiceView.m
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "MoreServiceView.h"
#import "SYOnlyLabelCell.h"
#import "SYNearbyServiceMode.h"

static NSString *cellID = @"SYOnlyLabelCell";
@implementation MoreServiceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 30)];
    label.textColor = kAppColorTextLightBlack;
    label.font = [UIFont systemFontOfSize:13];
    label.text = Localized(@"      全部服务");
    [self addSubview:label];
    
    
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    closeBtn.frame = CGRectMake(KscreenWidth - 60, 0, 60, 30);
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [closeBtn setImage:PNGIMAGE(@"btn_close") forState:(UIControlStateNormal)];
    [self addSubview:closeBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, KscreenWidth, self.frame.size.height - 30) collectionViewLayout:flowLayout];
    //背景颜色
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    //自适应大小
    self.myCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    self.myCollectionView.showsHorizontalScrollIndicator = NO;
    self.myCollectionView.bounces = NO;
    self.myCollectionView.scrollEnabled = NO;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    [self addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(label.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYOnlyLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    SYNearbyServiceMode *serviceMode = [self.dataArray objectAtIndex:indexPath.row];
    [cell.contentBtn setTitle:serviceMode.name forState:(UIControlStateNormal)];
    [cell.contentBtn setTitle:serviceMode.name forState:(UIControlStateSelected)];
    cell.contentBtn.selected = serviceMode.isSelected;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.myCollectionView.frame.size.width / 4, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYOnlyLabelCell *cell = (SYOnlyLabelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentBtn.selected = !cell.contentBtn.selected;
    [self.delegate selectServiceAtIndexPath:indexPath];
}

#pragma mark method
- (void)closeBtnAction{
    [self.delegate closeMoreServiceView];
}


@end
