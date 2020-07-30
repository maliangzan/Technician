//
//  NSString+JMC.h
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_INLINE NSString *
NSStringFromDouble(double value) {
    return [NSString stringWithFormat:@"%f", value];
}

NS_INLINE NSString *
NSStringFromInteger(NSInteger value) {
    return [NSString stringWithFormat:@"%ld", value];
}

@interface NSString (JMC)

@property (readonly) NSString *toMD5;
@property (readonly) NSURL    *toURL;
@property (readonly) NSString *toJSON;
@property (readonly) UIImage  *toCacheImage;
@property (readonly) UIImage  *toBundleImagePNG;

+ (NSString *)stringWithJSON:(id)JSON;  //  NSDictionary, NSArray


//  URL 替换特殊字符
- (NSString *)URLEncodedString;

//  Number
- (NSNumber *)number;
+ (NSString *)int2str:(int)num;

+ (NSString *)random;

+ (NSString *)timestampBy1970;


//- (UIImage *)nameToImage;

/*
 使用 imageWithContentsOfFile, 默认是从 mainBundle 查找 png
 
 @return 图片 || nil
 */

- (NSString *)xcSubstringFromMinLength:(NSUInteger)min;

//  查找字符串所有出现的位置
- (NSArray *)findAllSubstringRange:(NSString *)sub;

@end
