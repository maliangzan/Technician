//
//  JYSmileImagePickerCell.h
//  Printer
//
//  Created by Jim on 16/8/15.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmileImagePickerCellDelegate <NSObject>

- (void)deleteImageAtCell:(UICollectionViewCell *)cell;

@end

@interface JYSmileImagePickerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic, assign) id<SmileImagePickerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myImageViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *uploadTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
