//
//  JYUserMode.h
//  Technician
//
//  Created by TianQian on 2017/4/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JYMode.h"

@interface JYUserMode : NSObject

@property (nonatomic,assign) BOOL hasLogin;//是否登陆


@property (nonatomic,copy) NSString *icon;//头像

@property (nonatomic,copy) NSString *name;//姓名

@property (nonatomic,strong) NSNumber *age;//年龄

@property (nonatomic,assign) BOOL sex;//性别

@property (nonatomic,copy) NSString *emailAddress;//邮箱

@property (nonatomic,copy) NSString *address;//地址

@property (nonatomic,copy) NSString *detailAddress;//详细地址

@property (nonatomic,copy) NSString *profitionalLevel;//职级

@property (nonatomic,copy) NSString *idNumber;//身份证号

@property (nonatomic,copy) NSString *serviceItem;//职业类别

@property (nonatomic,copy) NSString *workingYear;//工作年限

@property (nonatomic,copy) NSString *university;//毕业院校

@property (nonatomic,copy) NSString *goodAtIntroduction;//擅长简介


@end
