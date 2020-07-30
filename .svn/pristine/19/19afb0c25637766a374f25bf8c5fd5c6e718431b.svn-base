//
//  SYWeekWorkingTimeSheet.m
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYWeekWorkingTimeSheet.h"
#import "SYDayTimePikerView.h"
#import "SYTimeHelper.h"

#define TITLELABELHEIGHT 60

@interface SYWeekWorkingTimeSheet()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *dateArray;
@property (nonatomic,strong) NSMutableArray *weekArray;
@property (nonatomic,strong) NSMutableArray *mmddArray;
@property (nonatomic,strong) NSMutableArray *timeArray;
@property (nonatomic,strong) NSMutableArray *firstTimeArray;

@end
@implementation SYWeekWorkingTimeSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    
    CGFloat containerViewX = 20 * kWidthFactor;
    CGFloat containerViewY = 150 * kHeightFactor;
    CGFloat containerViewW = KscreenWidth - containerViewX * 2;
    CGFloat containerViewH = KscreenHeight / 2;

    _containerView = [[UIView alloc] initWithFrame:CGRectMake(containerViewX,containerViewY, containerViewW, containerViewH)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 5;
    _containerView.layer.masksToBounds = YES;
    [_containerView addSubview:self.titleLabel];
    
    CGFloat btnCancelW = containerViewW / 2;
    CGFloat btnCancelH = 40;
    CGFloat btnCancelX = 0;
    CGFloat btnCancelY = containerViewH  - btnCancelH;
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame = CGRectMake(btnCancelX, btnCancelY, btnCancelW, btnCancelH);
    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnCancel.layer.borderWidth = 0.3;
    _btnCancel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_containerView addSubview:_btnCancel];
    
    CGFloat btnDoneX = btnCancelW;
    CGFloat btnDoneY = btnCancelY;
    CGFloat btnDoneW = btnCancelW;
    CGFloat btnDoneH = btnCancelH;
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(btnDoneX,  btnDoneY, btnDoneW, btnDoneH);
    [_btnDone setTitleColor:kAppColorAuxiliaryGreen forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnDone.layer.borderWidth = 0.3;
    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_containerView addSubview:_btnDone];
    
    [self addSubview:_containerView];
    
    [self dayPickerView];
}

- (void)dayPickerView{
    NSInteger count = self.weekArray.count;
    for (int i = 0; i < count; i ++) {
        CGFloat viewW = _containerView.frame.size.width - 20;
        CGFloat viewH = (_containerView.frame.size.height - TITLELABELHEIGHT - 40) / count - 5;
        CGFloat viewX = 10;
        CGFloat ViewY = TITLELABELHEIGHT + (viewH + 5) * i;
        SYDayTimePikerView *timePickView = [[SYDayTimePikerView alloc] initWithFrame:CGRectMake(viewX, ViewY, viewW, viewH)];
        timePickView.layer.cornerRadius = 3;
        timePickView.layer.masksToBounds = YES;
        timePickView.layer.borderWidth = 1;
        timePickView.layer.borderColor = kAppColorBackground.CGColor;
        timePickView.titleLabel.text = [NSString stringWithFormat:@"%@ %@",[self.mmddArray objectAtIndex:i],[self.weekArray objectAtIndex:i]];
        
        if (i == 0) {
            timePickView.beginTimeArray = self.firstTimeArray;
        } else {
            timePickView.beginTimeArray = self.timeArray;
        }
        timePickView.endTimeArray = self.timeArray;

        [_containerView addSubview:timePickView];
    }
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.pickerDone) {
        NSString *string = [NSMutableString string];
        self.pickerDone(string);
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)dateChange:(id)datePicker {
    
}

#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    //    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}


#pragma mark 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _containerView.frame.size.width, TITLELABELHEIGHT)];
        _titleLabel.text = Localized(@"一周工作时间");
        _titleLabel.textColor = kAppColorAuxiliaryGreen;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
        NSTimeInterval oneday = 24 * 60 * 60;
        for (int i = 0; i < 7; i ++) {
            //currentTime @"2017-03-26"
            NSString *theDay = [[SYTimeHelper YYYY_MM_DD_HH_MM_SS] stringFromDate:[[NSDate date] dateByAddingTimeInterval:oneday * i]];
            [_dateArray addObject:theDay];
        }
        
    }
    return _dateArray;
}

- (NSMutableArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSMutableArray arrayWithArray:@[@"8:00",@"8:30",@"9:00",@"9:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",]];
    }
    return _timeArray;
}

- (NSMutableArray *)firstTimeArray{
    if (!_firstTimeArray) {
        _firstTimeArray = [NSMutableArray arrayWithArray:self.timeArray];
        
//        NSTimeInterval oneday = 24 * 60 * 60;
//        NSString * = [[SYTimeHelper YYYY_MM_DD_HH_MM_SS] stringFromDate:[[NSDate date] dateByAddingTimeInterval:-oneday * (DEFUALT_COUNT - i)]];
        NSString *today = [SYTimeHelper niceDateFrom_HH_mm:[NSDate date]];
        NSString *hhStr = [today substringToIndex:2];
        NSString *mmStr = [today substringFromIndex:3];
        CGFloat hh = [hhStr integerValue];
        CGFloat mm =  [mmStr integerValue];
        if (mm >= 30) {
            hh = hh + 1;
            mm = 00;
        }else{
            mm = 30;
        }
//        NSString *beginTimeStr = [NSString stringWithFormat:@"%.0f:%.0f",hh,mm];
        NSMutableArray *removeArray = [NSMutableArray array];
        for (NSString *timeStr in self.timeArray) {
            [removeArray addObject:timeStr];
            CGFloat time = [timeStr floatValue];
            if (time == hh && mm == 00) {
                [removeArray removeObject:timeStr];
                break;
            }else if (time == hh && mm == 30){
                break;
            }
        }
        [_firstTimeArray removeObjectsInArray:removeArray];
        
    }
    return _firstTimeArray;
}

- (NSMutableArray *)mmddArray{
    if (!_mmddArray) {
        _mmddArray = [NSMutableArray array];
        for (NSString *timeStr in self.dateArray) {
            NSString *mmddStr = [timeStr substringWithRange:NSMakeRange(5, 5)];
            mmddStr = [mmddStr stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            [_mmddArray addObject:[NSString stringWithFormat:@"%@%@",mmddStr,@"日"]];
        }
        [_mmddArray replaceObjectAtIndex:0 withObject:@"今天"];
        [_mmddArray replaceObjectAtIndex:1 withObject:@"明天"];
        [_mmddArray replaceObjectAtIndex:2 withObject:@"后天"];
    }
    return _mmddArray;
}

- (NSMutableArray *)weekArray{
    if (!_weekArray) {
        _weekArray = [NSMutableArray array];
        for (NSString *timeStr in self.dateArray) {
            NSString *subStr = [timeStr substringToIndex:10];
            NSString *weekStr = [self getTheDayOfTheWeekByDateString:subStr];
            weekStr = [weekStr stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
            [_weekArray addObject:weekStr];
        }
        [_weekArray replaceObjectAtIndex:0 withObject:@""];
        [_weekArray replaceObjectAtIndex:1 withObject:@""];
        [_weekArray replaceObjectAtIndex:2 withObject:@""];
    }
    return _weekArray;
}

-(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString{
    
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *formatterDate=[inputFormatter dateFromString:dateString];
    
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    
    [outputFormatter setDateFormat:@"EEEE-MMMM-d"];
    
    NSString *outputDateStr=[outputFormatter stringFromDate:formatterDate];
    
    NSArray *weekArray=[outputDateStr componentsSeparatedByString:@"-"];
    
    return [weekArray objectAtIndex:0];
}

@end
