//
//  QBLayer.h
//  FunHotel
//
//  Created by Etre on 16/5/24.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface QBLayer : CALayer
@property(nonatomic,assign) CGRect rect;

@property(nonatomic,assign)BOOL showNoSelect;
@end
