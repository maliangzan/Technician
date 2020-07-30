//
//  FindViewCollectionCell.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindViewCollectionCell;

@protocol FindViewCollectionCellDelegate <NSObject>

- (void)fireDeviceAtCell:(FindViewCollectionCell *)cell;

@end

@interface FindViewCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic,weak) id<FindViewCollectionCellDelegate> delegate;


@end
