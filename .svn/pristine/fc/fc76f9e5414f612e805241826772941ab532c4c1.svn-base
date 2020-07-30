//
//  SYDayTimePikerView.m
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYDayTimePikerView.h"

@implementation SYDayTimePikerView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width / 3 + 40;
    CGFloat titleH = self.frame.size.height;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    self.titleLabel.textColor = kAppColorTextMiddleBlack;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:self.titleLabel];
    
    CGFloat pickerViewX = titleW;
    CGFloat pickerViewY = titleY;
    CGFloat pickerViewW = self.frame.size.width - titleW;
    CGFloat pickerViewH = titleH;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(pickerViewX, pickerViewY, pickerViewW, pickerViewH)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
}


#pragma mark <UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            return self.beginTimeArray.count;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return self.endTimeArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    switch (component) {
//        case 0:
//        {
//            return [self.beginTimeArray objectAtIndex:row];
//        }
//            break;
//        case 1:
//        {
//            return Localized(@"至");
//        }
//            break;
//        case 2:
//        {
//            return [self.endTimeArray objectAtIndex:row];
//        }
//            break;
//            
//        default:
//            return 0;
//            break;
//    }
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kAppColorTextMiddleBlack;
    label.font = [UIFont systemFontOfSize:13];
 
    switch (component) {
        case 0:
        {
            label.text = [self.beginTimeArray objectAtIndex:row];
        }
            break;
        case 1:
        {
            label.text = Localized(@"至");
            label.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 2:
        {
            label.text = [self.endTimeArray objectAtIndex:row];
        }
            break;
            
        default:
            return 0;
            break;
    }
    
    return label;
}

@end
