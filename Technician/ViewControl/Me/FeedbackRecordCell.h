//
//  FeedbackRecordCell.h
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeedbackRecordCell;
@protocol FeedbackRecordCellDelegate <NSObject>

- (void)showFeedBackDetailAtCell:(FeedbackRecordCell *)cell;

@end

@interface FeedbackRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *resonLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *staduesLabel;
@property (nonatomic,weak) id<FeedbackRecordCellDelegate> delegate;

@end
