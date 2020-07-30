//
//  SYFileTools.m
//  JMTools
//
//  Created by xserver on 16/1/10.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "SYFileTools.h"

@implementation SYFileTools

+ (BOOL)createDirectory:(NSString *)path {
    
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:nil];
        return success;
    }
    return NO;
}


+ (BOOL)excludedBackupAtFilePath:(NSString *)path {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error = nil;
        
        BOOL success = [[NSURL URLWithString:path] setResourceValue:@YES
                                                             forKey:NSURLIsExcludedFromBackupKey
                                                              error:&error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", path, error);
        }
        return success;
    }
    
    return NO;
}


+ (NSArray *)listDirectory:(NSString *)path {
    
    NSMutableArray *fileNameList = [NSMutableArray arrayWithCapacity:10];
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *name in list) {
        [fileNameList addObject:[path stringByAppendingPathComponent:name]];
    }
    
    return fileNameList;
}


+ (long long)fileSizeAtPath:(NSString *)filePath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


+ (long long)directorySizeAtPath:(NSString*)dirPath {
    
    if ( ! [[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        return 0;
    }
    
    NSEnumerator *files = [[[NSFileManager defaultManager] subpathsAtPath:dirPath] objectEnumerator];
    NSString* fileName;
    long long total = 0;
    
    while ((fileName = [files nextObject]) != nil) {
        NSString* fileAbsolutePath = [dirPath stringByAppendingPathComponent:fileName];
        total += [self fileSizeAtPath:fileAbsolutePath];
    }
    return total;
}

#pragma mark - path
+ (NSString *)createTempFilePath {
    return [self createFilePathWithDirectory:NSTemporaryDirectory()];
}

+ (NSString *)createTempFilePathWithSuffix:(NSString *)suffix {
    return [NSString stringWithFormat:@"%@.%@", [self createTempFilePath], suffix];
}



+ (NSString *)createFilePathWithDirectory:(NSString *)directory {
    
    NSString *path = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    while(path == nil || [fm fileExistsAtPath:path]) {
        
        path = [directory stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    }
    
    return path;
}


@end
