

#import "OCUIFunction.h"


/**
 *  GCD线程队列的用法
 *
 *  dispatch_async(threadQueue(), ^{
 NSLog(@"执行你要执行的任务%@", [NSThread currentThread]);
 });
 
 */

dispatch_queue_t serialQueue(void)
{
    static dispatch_once_t onceToken;
    static dispatch_queue_t queue;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.sayes.Technician", DISPATCH_QUEUE_CONCURRENT);//创建串行队列
    });
    return queue;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
BOOL isValidateMobile(NSString *mobile)
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
//利用正则表达式验证邮箱
BOOL isValidateEmail(NSString *email)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//身份证验证正则表达式
BOOL IsIdentityCard(NSString *IDCardNumber)
{
//    if (IDCardNumber.length <= 0) {
//        return NO;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:IDCardNumber];
    if (IDCardNumber.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:IDCardNumber]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex  = [[IDCardNumber substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum      += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [IDCardNumber substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
//银行卡证验证正则表达式
BOOL IsBankCard(NSString *cardNumber)
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
//将16进制颜色转换成UIColor
UIColor * getColor(NSString *hexColor)
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@interface OCActivityView : UIView
@property (nonatomic, retain) UIActivityIndicatorView *activityV;
@property (nonatomic, retain) UILabel *tipLB;
@end
@implementation OCActivityView
@synthesize activityV;
@synthesize tipLB;

+ (id) shareActivityView
{
    static OCActivityView *actV = nil;
    if (!actV)
    {
        actV = [[OCActivityView alloc] initWithFrame:CGRectMake((320-100)/2, (480-100)/2, 100, 100)];
        
        [actV setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        actV.activityV = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(35, 30, 30, 30)];
        [actV.activityV setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [actV addSubview:actV.activityV];
        actV.layer.cornerRadius = 10;
        
        actV.tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 30)];
        [actV.tipLB setBackgroundColor:[UIColor clearColor]];
        [actV.tipLB setTextAlignment:NSTextAlignmentCenter];
        [actV.tipLB setTextColor:[UIColor whiteColor]];
        actV.tipLB.font = [UIFont systemFontOfSize:12];
        actV.tipLB.text = @"wait...";
        [actV addSubview:actV.tipLB];
    }
    return actV;
}

@end

#pragma mark -
#pragma mark UIViewAddition实现
@implementation UIView (UIViewAddition)

//显示风火轮界面等
- (void) showActivityViewWithMessage:(NSString *)msgStr
{
    OCActivityView *activityV = [OCActivityView shareActivityView];
    [self setUserInteractionEnabled:NO];
    [self addSubview:activityV];
    [activityV.activityV startAnimating];
    activityV.tipLB.text = msgStr ? msgStr:(msgStr);
}

- (void) dismissActivityViewWithMessage
{
    OCActivityView *activityV = [OCActivityView shareActivityView];
    [self setUserInteractionEnabled:YES];
    [activityV removeFromSuperview];
    [activityV.activityV stopAnimating];
}

@end



