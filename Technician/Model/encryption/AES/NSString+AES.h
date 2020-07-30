//
//  NSString+AES.h
//  孕妙
//
//  Created by 马良赞 on 16/12/28.
//  Copyright © 2016年 是源科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)
//AES加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
//AES解密
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;
@end
