//
//  SYUserModel.h
//  Technician
//
//  Created by TianQian on 2017/4/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYUserModel : NSObject
//头像
@property (nonatomic,copy) NSString *icon;
//姓名
@property (nonatomic,copy) NSString *name;
//年龄
@property (nonatomic,strong) NSNumber *age;
//性别
@property (nonatomic,assign) BOOL sex;
//邮箱
@property (nonatomic,copy) NSString *emailAddress;
//地址
@property (nonatomic,copy) NSString *address;
//详细地址
@property (nonatomic,copy) NSString *detailAddress;
//职级
@property (nonatomic,copy) NSString *profitionalLevel;
//身份证号
@property (nonatomic,copy) NSString *idNumber;
//职业类别
@property (nonatomic,copy) NSString *serviceItem;
//工作年限
@property (nonatomic,copy) NSString *workingYear;
//毕业院校
@property (nonatomic,copy) NSString *university;
//擅长简介
@property (nonatomic,copy) NSString *goodAtIntroduction;


@end
