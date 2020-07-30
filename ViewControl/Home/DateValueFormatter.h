//
//  DateValueFormatter.h
//  源健康
//
//  Created by 是源科技 on 17/4/17.
//  Copyright © 2017年 是源科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;

@interface DateValueFormatter : NSObject<IChartAxisValueFormatter>
@property (nonatomic,strong)NSArray *arr;

-(id)initWithArr:(NSArray *)arr;

@end
