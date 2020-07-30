//
//  SY_GCDTimerManager.h
//  Technician
//
//  Created by TianQian on 2017/5/9.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SY_GCDTimerManager : NSObject
@property (nonatomic,strong) NSMutableDictionary*timerContainer;

+ (instancetype)sharedInstance;
- (void)scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action;
- (void)cancelTimerWithName:(NSString *)timerName;

@end
