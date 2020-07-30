//
//  QBLayer.m
//  FunHotel
//
//  Created by Etre on 16/5/24.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import "QBLayer.h"

@implementation QBLayer



-(void)drawInContext:(CGContextRef)ctx{
    
  
    
    UIGraphicsPushContext(ctx);
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRef context=ctx;

    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);//线的宽度
    
    CGContextStrokeEllipseInRect(context, CGRectMake(1.2, 1.2, self.bounds.size.width-2.4, self.bounds.size.height-2.4));
//    CGContextClip(context);

    //     Body
    
    
    
    if (self.showNoSelect) {
        CGContextSetRGBFillColor(context,  90.0/255.0,  90.0/255.0,  90.0/255.0, 0.4);
    }else{
        CGContextSetRGBFillColor(context, 20.0/255.0, 111.0/255.0, 223.0/255.0, 1.0);
    }
    
    CGContextFillEllipseInRect(context, CGRectInset(self.bounds, 1.0, 1.0));
    
    
    
    // Checkmark
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);
    
    CGContextMoveToPoint(context, 4.0, 10.0);
    CGContextAddLineToPoint(context, 8.0, 14.0);
    CGContextAddLineToPoint(context, 16.0, 6.0);
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    CGContextStrokePath(context);

    UIGraphicsPopContext();
}
@end
