//
//  ImageShowCell.m
//  Technician
//
//  Created by TianQian on 2017/6/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ImageShowCell.h"
#import "JYSmileImagePickerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ImageShowCell

static NSString *cellId = @"JYSmileImagePickerCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)drawRect:(CGRect)rect{
    self.collectionView.frame = CGRectMake(0, 0, KscreenWidth, 110);
    [self.bgView addSubview:self.collectionView];
}

#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = 0;
    for (NSDictionary *dic in self.images) {
        if (!isNull(dic[@"photo"])) {
            num += 1;
        }
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYSmileImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.deleteButton.hidden = YES;
    NSDictionary *dic = [self.images objectAtIndex:indexPath.row];
    NSString *imgURL = dic[@"photo"];
    if (!isNull(imgURL)) {
        imgURL = [NSString stringWithFormat:@"%@%@",@"/",imgURL];
        NSLog(@"imgURL = %@",[NSString gettingImageURLStringWithCustomURLString:imgURL]);
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString gettingImageURLStringWithCustomURLString:imgURL]] placeholderImage:placeh_image];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark get
- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((KscreenWidth - 50) / 3 , 110);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bgView.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}

@end
