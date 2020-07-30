//
//  JSDatePickerView.h
//  Printer
//
//  Created by 王俊杰 on 15/9/23.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  工厂也有使用，修改时注意
 */

//改成JY打头
@interface SYDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (copy, nonatomic) void(^datePicked)(NSDate *date);

- (void)show;

@end
