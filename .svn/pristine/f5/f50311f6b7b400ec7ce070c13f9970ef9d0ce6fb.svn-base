//
//  SY_GCDTimerManager.m
//  Technician
//
//  Created by TianQian on 2017/5/9.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SY_GCDTimerManager.h"

@implementation SY_GCDTimerManager

+ (instancetype)sharedInstance{
    static SY_GCDTimerManager *man;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        man = [[SY_GCDTimerManager alloc] init];
    });
    return man;
}

- (void)scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action{
    
    if (nil == timerName) {
        return;
    }
    //拿到一个队列
    if (nil == queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    //创建一个timer放到队列里面
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //激活timer
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
    }
    //设置timer的首次执行时间／执行时间间隔／精确度
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    //设置timer执行的事件
    WeakSelf;
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [weakself cancelTimerWithName:timerName];
        }
    });
    
}
//取消timer
- (void)cancelTimerWithName:(NSString *)timerName{
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        return;
    }
    [self.timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}



#pragma mark get
- (NSMutableDictionary *)timerContainer{
    if (!_timerContainer) {
        _timerContainer = [NSMutableDictionary dictionary];
    }
    return _timerContainer;
}

@end
