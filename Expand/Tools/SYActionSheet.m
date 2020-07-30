//
//  SYActionSheet.m
//  Technician
//
//  Created by TianQian on 2017/4/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYActionSheet.h"

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;

@interface SYActionSheet()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;

@end
@implementation SYActionSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(10, MainScreenHeight - 290 - 70, MainScreenWidth - 20, 290 - 40)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 5;
    _containerView.layer.masksToBounds = YES;
    _picker =  [[UIPickerView alloc] initWithFrame:CGRectMake(0, 10, MainScreenWidth - 20, 200)];
    _picker.delegate = self;
    [_containerView addSubview:_picker];
    
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake((MainScreenWidth - 19.2) / 2, CGRectGetMaxY(_picker.frame), (MainScreenWidth - 19.2) / 2, 40);
    [_btnDone setTitleColor:kAppColorAuxiliaryGreen forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnDone.layer.borderWidth = 0.3;
    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_containerView addSubview:_btnDone];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame = CGRectMake(-0.4,  CGRectGetMaxY(_picker.frame), (MainScreenWidth - 19.2) / 2, 40);
    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnCancel.layer.borderWidth = 0.3;
    _btnCancel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_containerView addSubview:_btnCancel];
    
    [self addSubview:_containerView];
}


#pragma mark UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *contentArray = self.dataArray[component];
    return contentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *contentArray = self.dataArray[component];
    return contentArray[row];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.pickerDone) {
        NSString *string = [NSMutableString string];
        for (int i = 0; i < self.dataArray.count; i++) {
            NSArray *subArray = [self.dataArray objectAtIndex:i];
            NSInteger selectedIndex = [self.picker selectedRowInComponent:i];
            string = [string stringByAppendingString:subArray[selectedIndex]];
        }
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

@end
