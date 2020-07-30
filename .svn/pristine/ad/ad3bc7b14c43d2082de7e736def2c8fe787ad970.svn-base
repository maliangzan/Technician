//
//  ServiceTimeBackView.h
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServiceTimeBackViewDelegate <NSObject>

- (void)overTheTime;

@end

@interface ServiceTimeBackView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *overBtn;

@property (nonatomic,weak) id<ServiceTimeBackViewDelegate> delegate;

@end
