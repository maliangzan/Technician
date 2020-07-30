//
//  SYWeekWorkingTimeSheet.h
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYWeekWorkingTimeSheet : UIActionSheet
@property(copy, nonatomic) void (^pickerDone)(NSString *selectedStr);
@property (nonatomic, strong) NSString * selectDate;

@end
