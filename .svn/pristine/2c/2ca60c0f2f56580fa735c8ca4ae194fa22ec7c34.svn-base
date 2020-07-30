//
//  Function.h
//  Printer
//
//  Created by any on 16/6/15.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#ifndef Function_h
#define Function_h


//打印一个函数（方法）或者指定代码块的运行时长
/*
#define OUTPUT_TIME_CONSUMING_FUN double startTime __attribute__((cleanup(timeConsumingFun))) __unused = [[NSDate date] timeIntervalSince1970];
#define OUTPUT_TIME_CONSUMING_CODE(code) {double startTime __attribute__((cleanup(timeConsumingFun))) __unused = [[NSDate date] timeIntervalSince1970];code}
static __unused void timeConsumingFun(double *startTime){
    double endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"OUTPUT_TIME_CONSUMING:%f",endTime - *startTime);
}
*/

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*-------------------系统版本--------------------*/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//typedef void(^MyBlock) ();
//GCD延迟
CG_INLINE void delayExcitueMethod(float delayTime,void (^gcdDelay)()){
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        gcdDelay();
        
    });
}


/**< 判断是否全是空格 */
CG_INLINE BOOL isEmpty(NSString *str) {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}



//判断一个字符串是不是空的
CG_INLINE BOOL isNull(NSString *aString)
{
    
    if ([aString isEqual:[NSNull null]]) { //如果为null crash
        return YES;
    }
    
    if (!aString) { // == nil
        return YES;
    }
    
    
    if (![aString isKindOfClass:[NSString class]]) {
        aString = [NSString stringWithFormat:@"%@",aString];
    }
    
    if ([aString isEqualToString:@""]) {
        return YES;
    }
    
    if (isEmpty(aString)) {
        return YES;
    }
    

    return NO;
}



//获得当前view所在的控制器
CG_INLINE UIViewController* currentViewControllerFormView(UIView*view) {
    
    for (  UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



CG_INLINE CGFloat compareStrDate(NSString *dateA,NSString*dateB){
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:dateA];
    NSDate *date = [dateFormatter dateFromString:dateB];
    
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date1 timeIntervalSinceDate:date];
    //计算天数、时、分、秒-- （%i可以自动将输入转换为十进制,而%d则不会进行转换），这个总时间是分钟数加秒钟数在家小时和天
    
    int days = ((int)time)/(3600*24);
    
    int hours = ((int)time)%(3600*24)/3600;
    
    int minutes = ((int)time)%(3600*24)%3600/60;
    
    int seconds = ((int)time)%(3600*24)%3600%60;
    
    
    return time;
    
    //    NSString *dateContent = [[NSString alloc] initWithFormat:@"仅剩%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    //
    //    return @[@(days),@(hours),@(minutes),@(seconds)];
    
}


//判断一个数组是否存在，是不是空的
CG_INLINE BOOL isNullArray(NSArray *array)
{
    if (![array isKindOfClass:[NSArray class]]) {
        return YES;
    }
    if (array.count==0) {
        return YES;
    }
    return NO;
}

//判断一个字典是否存在，是不是空的
CG_INLINE BOOL isNullDictionary(NSDictionary *dic)
{
    if (!dic) {
        return YES;
    }
    if ([dic isEqual:[NSNull null]]) {
        return YES;
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    
    return NO;
}


/**< 判断是否含有中文 */


CG_INLINE BOOL isChinese(NSString*str)
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) return YES;
 
}
    return NO;
    
}

CG_INLINE NSUInteger checkIsHaveChineseAndNum(NSString*str)
{
    NSRegularExpression *tChineseRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合中文字条件的有几个字节
    NSUInteger tChineseMatchCount = [tChineseRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    return tChineseMatchCount;
}

CG_INLINE NSUInteger checkIsHaveLetterAndNum(NSString*str)
{
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    return tLetterMatchCount;
}

CG_INLINE NSUInteger checkIsHaveDigitAndNum(NSString*str)
{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:str
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, str.length)];
    return tNumMatchCount;
}

//直接调用这个方法就行
CG_INLINE int checkIsHaveNumAndLetter(NSString*str)
{
       //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = checkIsHaveDigitAndNum(str);
    

    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = checkIsHaveLetterAndNum(str);
    

    
    //符合中文字条件的有几个字节
    NSUInteger tChineseMatchCount = checkIsHaveChineseAndNum(str);
    
    
    //标点符号
//    NSRegularExpression *tChineseRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
//    
//    //符合英文字条件的有几个字节
//    NSUInteger tChineseMatchCount = [tChineseRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    
    /**< 有数字 */
    if (tNumMatchCount > 0) {
        return 1;
    }
    
    /**< 中英文都有 */
    if (tLetterMatchCount>0 && tChineseMatchCount>0) {
        return 5;
    }
    
    /**< 全是字母 */
    if (tLetterMatchCount== str.length) {
        return 2;
    }
    
    /**< 全是中文 */
    if (tChineseMatchCount == str.length) {
        return 3;
    }
    
    NSArray*a1=[str componentsSeparatedByString:@"."];
    NSArray*a2=[str componentsSeparatedByString:@"·"];
      NSArray*a3=[str componentsSeparatedByString:@" "];
    if ((a1.count+a2.count+a3.count)-3 == str.length - tLetterMatchCount -tChineseMatchCount) {
           return 4;
    }
    
//    /**< 有允许出现的符号 */
//    if ([str containsString:@"."] || [str containsString:@"·"] || [str containsString:@" "]) {
//        return 4;
//    }

  
    
  
    
    
    /**< 都不符合 */
    return 0;
    
    
}


//将传入的数据转换成str
CG_INLINE NSString *classToJson(id data)
{
    if(data==nil)
    {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [[NSData alloc]initWithData:[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error]];
    NSString *initStr = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
    NSString *str_ = [NSString stringWithFormat:@"%@",initStr];
    //    [jsonData release];
    //    [initStr release];
    return str_;
}


//将传入的数据转换成str
CG_INLINE void alterView(NSString* title,NSString* showText,NSString* sureTitle,NSString* cancelTitle,UIViewController* target,void (^afterClickSure)()){
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:showText preferredStyle:UIAlertControllerStyleAlert];
   
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        afterClickSure();
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:doneAction];
    [target presentViewController:alert animated:YES completion:nil];


}


#endif /* Function_h */
