//
//  DateValueFormatter.m
//  源健康
//
//  Created by 是源科技 on 17/4/17.
//  Copyright © 2017年 是源科技. All rights reserved.
//

#import "DateValueFormatter.h"

@implementation DateValueFormatter

-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}
-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    if ((int)value >= _arr.count) {
        return @"";
    }
    return _arr[(int)value];
}

@end
