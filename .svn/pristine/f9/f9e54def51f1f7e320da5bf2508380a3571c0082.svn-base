//
//  NSString+JMPath.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "NSString+JMPath.h"

@implementation NSString (JMPath)
+ (NSString *)pathDocuments {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)pathLibrary {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


+ (NSString *)pathTemporary {
    return NSTemporaryDirectory();
}

+ (NSString *)pathCaches {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)pathPreferences {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

#pragma mark setting
+ (NSString *)pathSettingMessage {
    //    NSURL*url=[NSURL URLWithString:@"prefs:root=MESSAGES"];
    //    [[UIApplication sharedApplication] openURL:url];
    return @"prefs:root=MESSAGES";
}

- (NSString *) transformBundlePNGImage {
    return [[NSBundle mainBundle] pathForResource:self ofType:@"png"];
}


#pragma mark messagePath
+ (NSString *)messageImageDocumentsPathWithFileName:(NSString*)dataName{
    
    /**< 怎么样防止字符串null崩溃 Ray*/
    if (!dataName || [dataName isEqual:[NSNull null]]) {
        
        return @"";
    }
    
    NSString* documentPath=[ [NSString pathDocuments] stringByAppendingPathComponent:@"ChatData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager fileExistsAtPath:documentPath isDirectory:nil];
    if (!res) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];//第二个参数表示其它没有的父文件但是你又涉及到了的是否也创建
    }

    return [documentPath stringByAppendingPathComponent:dataName];
}

+ (NSString *)messageAudioDocumentsPathWithFileName:(NSString*)dataName{
    
    if (!dataName || [dataName isEqual:[NSNull null]]) {
        
        return @"";
    }
    
    NSString* documentPath=[ [NSString pathDocuments] stringByAppendingPathComponent:@".audio"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager fileExistsAtPath:documentPath isDirectory:nil];
    if (!res) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];//第二个参数表示其它没有的父文件但是你又涉及到了的是否也创建
    }
    
    return [documentPath stringByAppendingPathComponent:dataName];
}
@end
