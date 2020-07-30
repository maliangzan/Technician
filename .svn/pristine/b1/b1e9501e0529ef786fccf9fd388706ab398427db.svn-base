/*******************************************************************
 
 File name: OCUIFunction
 
 Description:
 1、函数,方法等。
 
 Author: Ocean Wang
 
 History: 2013.3.2。
 
 *******************************************************************/

#ifndef OCUIFunction_h
#define OCUIFunction_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//GCD线程队列
dispatch_queue_t serialQueue(void);


/*手机号码验证 MODIFIED BY HELENSONG*/
BOOL isValidateMobile(NSString *mobile);

//利用正则表达式验证
BOOL isValidateEmail(NSString *email);

//保存邮箱或是手机号
BOOL saveMailboxOrPhoneNumber(NSString *Mail_Number);

//身份证验证正则表达式
BOOL IsIdentityCard(NSString *IDCardNumber);

//银行卡证验证正则表达式
BOOL IsBankCard(NSString *cardNumber);



//将16进制颜色转换成UIColor
UIColor * getColor(NSString *hexColor);
#pragma mark -
#pragma mark UIView分类
@interface UIView (UIViewAddition)
//加载背景视图
//- (void) addBackgroundView:(NSString *)backViewStr;

//导航
//- (OCNavigationView *)addNavigationView;

//显示风火轮界面等
- (void) showActivityViewWithMessage:(NSString *)msgStr;
- (void) dismissActivityViewWithMessage;

@end

//非正式协议
@interface UIView ()
- (id) initWithOrigin:(CGPoint)origin;
@end


//深复制(复制后的对象计数=1)
@protocol OCDeepCopying <NSObject>

@optional
- (id) deepCopying;

@end


#endif
