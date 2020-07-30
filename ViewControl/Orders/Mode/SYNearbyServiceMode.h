//
//  SYNearbyServiceMode.h
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYNearbyServiceMode : SYMode
//@property (nonatomic,assign) long serviceID;

@property (nonatomic,strong) NSNumber *serviceID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) BOOL isSelected;


@end
