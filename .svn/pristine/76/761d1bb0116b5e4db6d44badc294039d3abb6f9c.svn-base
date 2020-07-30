//
//  SYItemSheet.m
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYItemSheet.h"
#import "SYDayTimePikerView.h"
#import "SYTimeHelper.h"
#import "ServiceItemCell.h"

#define TITLELABELHEIGHT 60

static NSString *serviceCellID = @"ServiceItemCell";
@interface SYItemSheet()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) UIPickerView *profisionalLevelPicker;
@property (nonatomic,strong) NSMutableArray *dateArray;
@property (nonatomic,strong) NSMutableArray *weekArray;
@property (nonatomic,strong) NSMutableArray *mmddArray;
@property (nonatomic,strong) NSMutableArray *timeArray;
@property (nonatomic,strong) NSMutableArray *firstTimeArray;
@property (nonatomic,strong) NSMutableArray *timePickViewArray;
@property (nonatomic,strong) NSMutableArray *selectedServiceArray;

@end
@implementation SYItemSheet

- (instancetype)initWithFrame:(CGRect)frame actionType:(ItemActionType)actionType title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.itemActionType = actionType;
        self.titleStr = title;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        //        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    [self baseUI];
    
    if (_itemActionType == ItemActionTypeSelectWeekTime) {
//        [self dayPickerView];
    }else if(_itemActionType == ItemActionTypeSelectServiceType){
        [_containerView addSubview:self.myTableView];
    }else if(_itemActionType == ItemActionTypeSelectProfessionalLevel){
        [_containerView addSubview:self.profisionalLevelPicker];
    }
}

- (void)baseUI{
    CGFloat containerViewX = 20 * kWidthFactor;
    CGFloat containerViewY = 150 * kHeightFactor;
    CGFloat containerViewW = KscreenWidth - containerViewX * 2;
    CGFloat containerViewH = KscreenHeight / 2;
    if (_itemActionType == ItemActionTypeSelectWeekTime) {
        containerViewY = 80 * kHeightFactor;
        containerViewH = KscreenHeight / 2 + 100;
    }else if(_itemActionType == ItemActionTypeSelectServiceType){
        containerViewH = KscreenHeight / 2;
    }else if(_itemActionType == ItemActionTypeSelectProfessionalLevel){
        containerViewY = 150 * kHeightFactor * 2;
        containerViewH = KscreenHeight / 4 + 20;
    }
    
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
}

- (void)dayPickerView{
    NSInteger count = self.weekArray.count;
    for (int i = 0; i < count; i ++) {
        CGFloat viewW = _containerView.frame.size.width - 20;
        CGFloat viewH = (_containerView.frame.size.height - TITLELABELHEIGHT - 40) / count - 5;
        CGFloat viewX = 10;
        CGFloat ViewY = TITLELABELHEIGHT + (viewH + 5) * i;
        
        
        NSInteger beginIndex = 0;
        NSInteger endIndex = self.timeArray.count - 1;
        
        //获取上次选择服务时间
        if (self.serviceStarTimeArray.count >= 7) {
            NSMutableString *beginTime = [NSMutableString stringWithString:self.serviceStarTimeArray[i]];
            NSString *beginTimeString = @"";
            if ([beginTime hasPrefix:@"0"]) {
                beginTimeString = [beginTime substringWithRange:NSMakeRange(1, beginTime.length - 4)];
            }else{
                beginTimeString = [beginTime substringWithRange:NSMakeRange(0, beginTime.length - 3)];
            }
            
//            if (i == 0) {
//                for (int j = 0 ; j < self.firstTimeArray.count; j++) {
//                    NSString *timeString = self.firstTimeArray[j];
//                    
//                    if ([beginTimeString isEqualToString:timeString]) {
//                        beginIndex = j;
//                        break;
//                    }
//                }
//            } else {
                for (int j = 0 ; j < self.timeArray.count; j++) {
                    NSString *timeString = self.timeArray[j];
                    if ([beginTimeString isEqualToString:timeString]) {
                        beginIndex = j;
                        break;
                    }
                }
            //}
        }
        
        if (self.serviceEndTimeArray.count >= 7) {
            NSMutableString *endTime = [NSMutableString stringWithString:self.serviceEndTimeArray[i]];
            NSString *endTimeString = @"";
            if ([endTime hasPrefix:@"0"]) {
                endTimeString = [endTime substringWithRange:NSMakeRange(1, endTime.length - 4)];
            }else{
                endTimeString = [endTime substringWithRange:NSMakeRange(0, endTime.length - 3)];
            }
            for (int j = 0 ; j < self.timeArray.count; j++) {
                NSString *timeString = self.timeArray[j];
                if ([endTimeString isEqualToString:timeString]) {
                    endIndex = j;
                    break;
                }
            }
        }
        
        
        SYDayTimePikerView *timePickView = [[SYDayTimePikerView alloc] initWithFrame:CGRectMake(viewX, ViewY, viewW, viewH) withBeginIndex:beginIndex endIndex:endIndex];
        timePickView.layer.cornerRadius = 3;
        timePickView.layer.masksToBounds = YES;
        timePickView.layer.borderWidth = 1;
        timePickView.layer.borderColor = kAppColorBackground.CGColor;
        timePickView.titleLabel.text = [NSString stringWithFormat:@"%@ %@",[self.mmddArray objectAtIndex:i],[self.weekArray objectAtIndex:i]];
        
//        if (i == 0) {
//            timePickView.beginTimeArray = self.firstTimeArray;
//        } else {
            timePickView.beginTimeArray = self.timeArray;
//        }

        timePickView.endTimeArray = self.timeArray;
        timePickView.tag = 100 + i;
        [self.timePickViewArray addObject:timePickView];
        
        [_containerView addSubview:timePickView];
    }
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}

- (NSString *)gettingserviceTime{
    NSMutableArray *changeTimeArray = [NSMutableArray array];
    for (SYDayTimePikerView *pickerView in self.timePickViewArray) {
        NSInteger selectedIndexBeginTime = [pickerView.pickerView selectedRowInComponent:0];
        NSInteger selectedIndexEndTime = [pickerView.pickerView selectedRowInComponent:2];
        id beginTime;
        id endTime;
//        if (pickerView.tag == 100) {
//            beginTime = [self.firstTimeArray objectAtIndex:selectedIndexBeginTime];
//        }else{
            beginTime = [self.timeArray objectAtIndex:selectedIndexBeginTime];
//        }
        endTime = [self.timeArray objectAtIndex:selectedIndexEndTime];
        
        NSString *beginH = [beginTime componentsSeparatedByString:@":"][0];
//        NSString *beginM = [beginTime componentsSeparatedByString:@":"][1];
        
        NSString *endH = [endTime componentsSeparatedByString:@":"][0];
        NSString *endM = [endTime componentsSeparatedByString:@":"][1];
        if ([endH floatValue] < [beginH floatValue]) {
            return nil;
        }
        
        if ([endH isEqualToString:beginH] && [endM isEqualToString:@"00"]) {
            return nil;
        }

        
        id dateTime = [self.dateArray objectAtIndex:pickerView.tag - 100];
        
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        [mutDic setObject:dateTime forKey:@"date"];
        
        NSMutableString *mutDate = [NSMutableString stringWithString:dateTime];
        NSString *startTimeString = [NSString stringWithFormat:@"%@ %@:00",[mutDate substringToIndex:10],beginTime];
        [mutDic setObject:startTimeString forKey:@"startTime1"];
        NSString *endTimeString = [NSString stringWithFormat:@"%@ %@:00",[mutDate substringToIndex:10],endTime];
        [mutDic setObject:endTimeString forKey:@"endTime1"];
        [mutDic setObject:[SYAppConfig shared].me.userID forKey:@"tid"];
        [changeTimeArray addObject:mutDic];
        NSLog(@"%@",mutDic);
    }
    return [changeTimeArray arrayToJson];
}

- (void)serviceItemSelectedMore{
    [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"最多只能选择三项服务")];
}

#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.pickerDone) {
        switch (_itemActionType) {
            case ItemActionTypeSelectWeekTime:
            {
                NSString *doneString = [self gettingserviceTime];
                if (!isNull(doneString)) {
                    self.pickerDone(doneString);
                    [self removeFromSuperview];
                } else {
                    [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"结束时间不能早于或等于开始时间！")];
                }
                
            }
                break;
            case ItemActionTypeSelectServiceType:
            {
                //已在tableViewdidselected处通知，此处不传值
                self.pickerDone(@"");
                [self removeFromSuperview];
            }
                break;
            case ItemActionTypeSelectProfessionalLevel:
            {
                NSString *string = [self.dataArray objectAtIndex:[self.profisionalLevelPicker selectedRowInComponent:0]];
                self.pickerDone(string);
                [self removeFromSuperview];
            }
                break;
            default:
                [self removeFromSuperview];
                break;
        }
        
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

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_itemActionType == ItemActionTypeSelectServiceType) {
        ServiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLable.text = [self.dataArray objectAtIndex:indexPath.row];
        return cell;
    }
    
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_itemActionType == ItemActionTypeSelectServiceType) {
        ServiceItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedBtn.selected = !cell.selectedBtn.selected;
        id obj = [self.dataArray objectAtIndex:indexPath.row];
        
        if (cell.selectedBtn.selected) {
            [self.selectedServiceArray addObject:obj];
        }else{
            if ([self.selectedServiceArray containsObject:obj]) {
                [self.selectedServiceArray removeObject:obj];
            }
        }
        
        //服务项目数量判断
        if (self.selectedServiceArray.count > 3) {
            //服务选项不超过3个
            [self serviceItemSelectedMore];
            cell.selectedBtn.selected = NO;
            [self.selectedServiceArray removeObject:obj];
        }else{
            if (cell.selectedBtn.selected) {
                cell.titleLable.textColor = kAppColorTextMiddleBlack;
                PostNotificationWithUserInfo(kNotificationSYItemSheetSelectedService, obj);
            }else{
                cell.titleLable.textColor = kAppColorTextLightBlack;
                PostNotificationWithUserInfo(kNotificationSYItemSheetCancelSelectedService, obj);
            }
        }
    }
    
    [self.myTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _myTableView.frame.size.height / 7;
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_itemActionType == ItemActionTypeSelectProfessionalLevel) {
        return 1;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.dataArray objectAtIndex:row];
}

#pragma mark 懒加载
- (UITableView *)myTableView{
    if (!_myTableView) {
        CGFloat tableViewX = 0;
        CGFloat tableViewY = TITLELABELHEIGHT;
        CGFloat tableViewW = _containerView.frame.size.width;
        CGFloat tableViewH = _containerView.frame.size.height - tableViewY - 40;
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX,tableViewY ,tableViewW ,tableViewH )];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_itemActionType == ItemActionTypeSelectServiceType) {
            [_myTableView registerNib:[UINib nibWithNibName:serviceCellID bundle:nil] forCellReuseIdentifier:serviceCellID];
        }
    }
    return _myTableView;
}

- (UIPickerView *)profisionalLevelPicker{
    if (!_profisionalLevelPicker) {
        CGFloat pickerX = 0;
        CGFloat pickerY = TITLELABELHEIGHT - 20 * kHeightFactor;
        CGFloat pickerW = _containerView.frame.size.width;
        CGFloat pickerH = _containerView.frame.size.height - TITLELABELHEIGHT - 40;
        _profisionalLevelPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        _profisionalLevelPicker.delegate = self;
        _profisionalLevelPicker.dataSource = self;
    }
    return _profisionalLevelPicker;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _containerView.frame.size.width, TITLELABELHEIGHT)];
        _titleLabel.text = self.titleStr;
        _titleLabel.textColor = kAppColorAuxiliaryGreen;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
        for (NSString *timeString in self.serviceStarTimeArray) {
            NSLog(@"serviceStarTimeArray = %@",timeString);
        }
        for (NSString *timeString in self.serviceEndTimeArray) {
            NSLog(@"serviceEndTimeArray = %@",timeString);
        }
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

- (NSMutableArray *)timePickViewArray{
    if (!_timePickViewArray) {
        _timePickViewArray = [NSMutableArray array];
    }
    return _timePickViewArray;
}

- (NSMutableArray *)selectedServiceArray{
    if (!_selectedServiceArray) {
        _selectedServiceArray = [NSMutableArray array];
    }
    return _selectedServiceArray;
}

@end
