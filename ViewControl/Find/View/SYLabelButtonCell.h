//
//  SYLabelButtonCell.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYLabelButtonCellDelegate <NSObject>

- (void)commitAddDevice;

@end

@interface SYLabelButtonCell : UITableViewCell
@property (nonatomic,weak) id<SYLabelButtonCellDelegate> delegate;


@end
