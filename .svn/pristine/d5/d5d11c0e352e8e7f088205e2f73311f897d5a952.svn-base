//
//  JYCommand.m
//  JYCommon
//
//  Created by Dragon on 15/6/18.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "JYCommand.h"

//@implementation JYCommand
//
//@end

@implementation NSDictionary (JYCommand)

- (NSInteger)command {
    
    @try {
        NSDictionary *head = [self objectForKey:kPHead];
        NSInteger cmd = [[head objectForKey:kPHeadCommand] integerValue];
        return cmd;
    }
    @catch (NSException *exception) {
        Log(@"%@\n%@", exception, self);
    }
}

- (NSInteger)retcode {
    @try {
        return [[self objectForKey:kPRetcode] integerValue];
    }
    @catch (NSException *exception) {
        Log(@"%@\n%@", exception, self);
    }
}

- (NSString *)errorMessage {
    return [self objectForKey:@"errmsg"];
}

@end


