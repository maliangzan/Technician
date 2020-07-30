//
//  SYImageLabelCell.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYImageLabelCellDelegate <NSObject>

- (void)usedToGuid;

@end

@interface SYImageLabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deviceNameLabelHeight;
@property (weak, nonatomic) IBOutlet UIButton *guidBtn;
@property (nonatomic,weak) id<SYImageLabelCellDelegate> delegate;


@end
