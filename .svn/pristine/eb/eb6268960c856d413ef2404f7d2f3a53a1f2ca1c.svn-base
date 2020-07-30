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

@end
@implementation SYItemSheet

- (instancetype)initWithFrame:(CGRect)frame actionType:(ItemActionType)actionType title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.itemActionType = actionType;
        self.titleStr = title;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
//        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    [self baseUI];
    
    if (_itemActionType == ItemActionTypeSelectWeekTime) {
        [self dayPickerView];
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
        containerViewH = KscreenHeight / 2;
    }else if(_itemActionType == ItemActionTypeSelectServiceType){
        containerViewH = KscreenHeight / 2;
    }else if(_itemActionType == ItemActionTypeSelectProfessionalLevel){
        containerViewY = 150 * kHeightFactor * 2;
        containerViewH = KscreenHeight / 4;
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
        switch (_itemActionType) {
            case ItemActionTypeSelectWeekTime:
            {
            
            }
                break;
            case ItemActionTypeSelectServiceType:
            {
                
            }
                break;
            case ItemActionTypeSelectProfessionalLevel:
            {
                NSString *string = [self.dataArray objectAtIndex:[self.profisionalLevelPicker selectedRowInComponent:0]];
                self.pickerDone(string);
            }
                break;
            default:
                break;
        }
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
        if (cell.selectedBtn.selected) {
            cell.titleLable.textColor = kAppColorTextMiddleBlack;
            PostNotificationWithUserInfo(kNotificationSYItemSheetSelectedService, [self.dataArray objectAtIndex:indexPath.row]);
        }else{
            cell.titleLable.textColor = kAppColorTextLightBlack;
            PostNotificationWithUserInfo(kNotificationSYItemSheetCancelSelectedService, [self.dataArray objectAtIndex:indexPath.row]);
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
