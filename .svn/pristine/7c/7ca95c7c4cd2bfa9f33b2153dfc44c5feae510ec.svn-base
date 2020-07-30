//
//  QBAssetsCollectionCheckmarkView.m
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2014/01/01.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBAssetsCollectionCheckmarkView.h"

@implementation QBAssetsCollectionCheckmarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // View settings
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
//
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(20.0, 20.0);
}
//
- (void)drawRect:(CGRect)rect
{

//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Border
//    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.0);
//    CGContextFillEllipseInRect(context, self.bounds);
//    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);//线的宽度
   
    CGContextStrokeEllipseInRect(context, CGRectMake(1.2, 1.2, self.bounds.size.width-2.4, self.bounds.size.height-2.4));
     CGContextClip(context);
//     Body
    
    if (self.showNoSelect) {
           CGContextSetRGBFillColor(context,  90.0/255.0,  90.0/255.0,  90.0/255.0, 0.4);
    }else{
//           CGContextSetRGBFillColor(context, 20.0/255.0, 111.0/255.0, 223.0/255.0, 1.0);
 
           CGContextSetRGBFillColor(context, 39/255.0, 130/255.0, 215/255.0, 1.0);
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
//    });
//   
//});
}

@end
