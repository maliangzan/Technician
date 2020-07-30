//
//  SYMode.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@implementation SYMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)JSON {
    
    if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
        
        NSError *error;
        id obj = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:JSON error:&error];
        if (error) {
            NSLog(@"%@", error);
            return nil;
        }
        return obj;
    }
    
    return nil;
}

+ (NSArray *)fromJSONArray:(NSArray *)array {
    
    if (array && [array isKindOfClass:[NSArray class]]) {
        
        NSError *error;
        NSArray *ay = [MTLJSONAdapter modelsOfClass:self.class fromJSONArray:array error:&error];
        if (error) {
            NSLog(@"%@", error);
            return nil;
        }
        return ay;
    }
    
    return nil;
}

+ (instancetype)testModel {
    return [[SYMode alloc] init];
}
@end
