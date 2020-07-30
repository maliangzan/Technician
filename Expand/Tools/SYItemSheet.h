//
//  SYItemSheet.h
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ItemActionType) {
    ItemActionTypeSelectWeekTime = 100,//选择服务时间
    ItemActionTypeSelectServiceType = 101,//选择服务项目
    ItemActionTypeSelectProfessionalLevel = 102,//选择职级

};

@interface SYItemSheet : UIActionSheet<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property(copy, nonatomic) void (^pickerDone)(NSString *selectedStr);
@property (nonatomic, strong) NSString * selectDate;
@property (nonatomic,assign) ItemActionType itemActionType;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *serviceStarTimeArray;
@property (nonatomic,strong) NSMutableArray *serviceEndTimeArray;

- (instancetype)initWithFrame:(CGRect)frame actionType:(ItemActionType)actionType title:(NSString *)title;
- (void)dayPickerView;

@end
