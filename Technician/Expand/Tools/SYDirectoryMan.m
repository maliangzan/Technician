//
//  SYDirectoryMan.m
//  JMTools
//
//  Created by xserver on 16/1/6.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYDirectoryMan.h"
#import "SYFileTools.h"

@interface SYDirectoryMan ()

@property (nonatomic, copy) NSString *directoryPath;

@end


@implementation SYDirectoryMan

- (instancetype)initWithDirectory:(NSString *)dirPath {

    if (self = [super init]) {
        
        self.directoryPath = dirPath;
        
        if ( ! [[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            
            BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath
                                                     withIntermediateDirectories:YES
                                                                      attributes:nil
                                                                           error:nil];
            if (! success) {
                self = nil;
            }
        }
    }
    return self;
}

- (long long)size {
    return [SYFileTools directorySizeAtPath:self.directoryPath];
}

- (NSString *)createFilePath {
    return [SYFileTools createFilePathWithDirectory:self.directoryPath];
}

- (NSString *)createFilePathWithSuffix:(NSString *)suffix {
    return [NSString stringWithFormat:@"%@.%@", [self createFilePath], suffix];
}

- (NSString *)copyFileToHere:(NSString *)file {
    
    NSError *error;
    NSString *path = [self createFilePath];
    if ([[NSFileManager defaultManager] copyItemAtPath:file toPath:path error:&error]) {
        return path;
    }

    NSLog(@"error copying file: %@", [error localizedDescription]);
    return nil;
}

#pragma mark == save
- (NSString *)saveObject:(id)object fileSuffix:(NSString *)suffix {

    if ([object isKindOfClass:[NSData class]]) {
        return [self saveData:object fileSuffix:suffix];
    }
    
    if ([object isKindOfClass:[UIImage class]]) {
        return [self saveData:UIImagePNGRepresentation(object) fileSuffix:suffix];
    }
    
    return nil;
}

- (NSString *)saveData:(NSData *)data fileSuffix:(NSString *)suffix {
    
    NSString *file = [self createFilePathWithSuffix:suffix];
    if ([data writeToFile:file atomically:YES]) {
        return file;
    }
    return nil;
}

@end
