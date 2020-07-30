//
//  AllEvaluateCell.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllEvaluateCell;
@protocol AllEvaluateCellDelegate <NSObject>
- (void)thumbUpAtCell:(AllEvaluateCell *)cell;
@end

@interface AllEvaluateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *thumbUpBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (nonatomic,weak) id<AllEvaluateCellDelegate> delegate;


@end
