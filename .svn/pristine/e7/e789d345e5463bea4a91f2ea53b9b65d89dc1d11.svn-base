//
//  CustomTipsSheet.h
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SYTipType) {
    SYTipTypeCommitSuccess = 100,//资料成功提交
    SYTipTypeFeedback = 101,//意见反馈
};

@interface CustomTipsSheet : UIActionSheet
@property(copy, nonatomic) void (^pickerDone)(NSString *selectedStr);
@property(copy, nonatomic) void (^closeDone)();
@property (nonatomic,assign) SYTipType tipType;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,assign) CGFloat contentViewHeight;
@property (nonatomic,strong) NSDictionary *userInfo;

//不指定contentViewHeight传0
- (instancetype)initWithFrame:(CGRect)frame tipType:(SYTipType)actionType title:(NSString *)title contenViewHeight:(CGFloat)contentViewHeight;
- (instancetype)initWithFrame:(CGRect)frame tipType:(SYTipType)actionType title:(NSString *)title contenViewHeight:(CGFloat)contentViewHeight userInfo:(NSDictionary *)dic;
@end
