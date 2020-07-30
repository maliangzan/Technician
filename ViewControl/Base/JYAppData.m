//
//  JYAppData.m
//  Printer
//
//  Created by Dragon on 16/2/22.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#import "JYAppData.h"
#import "JMKeyValueStore.h"
#import "JYUserMode.h"
#import "NSString+JMPath.h"

@interface JYAppData ()
@property (nonatomic, strong) JMKeyValueStore *store;
@end


@implementation JYAppData

+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)setupForCurrentUserID:(NSNumber *)uid {
    
    if ( !self.store) {
        NSString *dir = [NSString stringWithFormat:@".partmall/kvdb_%@", [uid stringValue]];
        NSString *path = [[NSString pathDocuments] stringByAppendingPathComponent:dir];;
        
        self.store = [[JMKeyValueStore alloc] initWithDatabasePath:path];
        self.store.defaultTableName = @"deftab";
    }
}

- (void)logout {
    if (self.store) {
        [self.store close];
        self.store = nil;
    }
}

#pragma mark - Model Suppor
NS_INLINE NSString*
createModelClassKey(NSString *key) {
    return [NSString stringWithFormat:@"%@_model", key];
}

//- (void)putModel:(JYMode *)model forKey:(NSString *)key {
//    NSError *error;
//    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:model error:&error];
//    if (dic) {
//        [_store putValue:NSStringFromClass([model class]) forKey:createModelClassKey(key)];
//        [_store putValue:dic forKey:key];
//    }
//}

- (id)modelForKey:(NSString *)key {
    
    NSDictionary *dic = [_store valueForKey:key];
    NSString *name = [_store valueForKey:createModelClassKey(key)];
    
    id model = [NSClassFromString(name) fromJSONDictionary:dic];
    return model;
}

//#pragma mark - Value
//- (void)putValue:(id)value forKey:(NSString *)key {
//
//    if ([value isKindOfClass:[JYMode class]]) {
//        [self putModel:value forKey:key];
//    } else {
//        [_store putValue:value forKey:key];
//    }
//}
//
//- (id)valueForKey:(NSString *)key {
//
//    if ([_store valueForKey:createModelClassKey(key)]) {
//        return [self modelForKey:key];
//    } else {
//        return [_store valueForKey:key];
//    }
//}

#pragma mark - business keys

//NSString *const kPowerTimestamp = @"powerTimestamp";
//NSString *const kPowerData = @"powerData";
NSString *const kRegisterRemoteNotificationState = @"registerRemoteNotificationState";

NSString *const kNotificationPlaySound = @"notificationPlaySound";
NSString *const kNotificationVibrate = @"notificationVibrate";

#pragma mark - 系统
- (void)putRegisterRemoteNotificationState:(NSString *)value {
    [_store putValue:value forKey:kRegisterRemoteNotificationState];
}
- (NSString *)registerRemoteNotificationState {
    return [_store valueForKey:kRegisterRemoteNotificationState];
}

- (void)putNotificationPlaySound:(BOOL)value {
    if (value) {
        [_store putValue:@"YES" forKey:kNotificationPlaySound];
    } else {
        [_store putValue:@"NO" forKey:kNotificationPlaySound];
    }
}

- (BOOL)notificationPlaySound {
    id value = [_store valueForKey:kNotificationPlaySound];
    if (value) {
        return [value isEqualToString:@"YES"];
    } else {
        return YES; //  default = YES
    }
}

- (void)putNotificationVibrate:(BOOL)value {
    if (value) {
        [_store putValue:@"YES" forKey:kNotificationVibrate];
    } else {
        [_store putValue:@"NO" forKey:kNotificationVibrate];
    }
}
- (BOOL)notificationVibrate {
    id value = [_store valueForKey:kNotificationVibrate];
    if (value) {
        return [value isEqualToString:@"YES"];
    } else {
        return YES; //  default = YES
    }
}

#pragma mark - xxx
@end
