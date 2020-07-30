//
//  UIView+JMC.m
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c)2015年 pitaya. All rights reserved.
//

#import "UIView+JMC.h"

@implementation UIView (JMC)

+ (id)viewWithNib:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0];
}

- (BOOL)containsSubview:(id)aView {
    
    for (id view in self.subviews) {
        if ([view isKindOfClass:[aView class]]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)frameString {
    return NSStringFromCGRect(self.frame);
}

//#pragma mark - top, left, bottom, right
//- (CGFloat)top {
//    return self.frame.origin.y;
//}
//
//- (void)setTop:(CGFloat)newtop {
//    CGRect newframe = self.frame;
//    newframe.origin.y = newtop;
//    self.frame = newframe;
//}
//
//- (CGFloat)left {
//    return self.frame.origin.x;
//}
//
//- (void)setLeft:(CGFloat)newleft {
//    CGRect newframe = self.frame;
//    newframe.origin.x = newleft;
//    self.frame = newframe;
//}
//
//- (CGFloat)bottom {
//    return self.frame.origin.y + self.frame.size.height;
//}
//
//- (void)setBottom:(CGFloat)newbottom {
//    CGRect newframe = self.frame;
//    newframe.origin.y = newbottom - self.frame.size.height;
//    self.frame = newframe;
//}
//
//- (CGFloat)right {
//    return self.frame.origin.x + self.frame.size.width;
//}
//
//- (void)setRight:(CGFloat)newright {
//    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
//    CGRect newframe = self.frame;
//    newframe.origin.x += delta ;
//    self.frame = newframe;
//}
//
//#pragma mark - 四个角的坐标
//- (CGPoint)bottomRight {
//    CGFloat x = self.frame.origin.x + self.frame.size.width;
//    CGFloat y = self.frame.origin.y + self.frame.size.height;
//    return CGPointMake(x, y);
//}
//
//- (CGPoint)bottomLeft {
//    CGFloat x = self.frame.origin.x;
//    CGFloat y = self.frame.origin.y + self.frame.size.height;
//    return CGPointMake(x, y);
//}
//
//- (CGPoint)topRight {
//    CGFloat x = self.frame.origin.x + self.frame.size.width;
//    CGFloat y = self.frame.origin.y;
//    return CGPointMake(x, y);
//}
//
//- (CGPoint)topLeft {
//    return self.frame.origin;
//}
//
//#pragma mark - width & height
//- (CGFloat)height {
//    return self.frame.size.height;
//}
//
//- (void)setHeight:(CGFloat)newheight {
//    CGRect newframe = self.frame;
//    newframe.size.height = newheight;
//    self.frame = newframe;
//}
//
//- (CGFloat)width {
//    return self.frame.size.width;
//}
//
//- (void)setWidth:(CGFloat)newwidth {
//    CGRect newframe = self.frame;
//    newframe.size.width = newwidth;
//    self.frame = newframe;
//}
//
//#pragma mark - origin & size
//// Retrieve and set the origin
//- (CGPoint)origin {
//    return self.frame.origin;
//}
//
//- (void)setOrigin:(CGPoint)origin {
//    self.frame = CGRectMake(origin.x, origin.y,
//                            self.frame.size.width, self.frame.size.height);
//}
//
//// Retrieve and set the size
//- (CGSize)size {
//    return self.frame.size;
//}
//
//- (void)setSize:(CGSize)size {
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
//                            size.width, size.height);
//}


#pragma mark - ?
- (UIImage *)cropWithRect:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// Move via offset
- (void)moveBy:(CGPoint)delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor {
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize {
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height)){
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width)){
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}
@end
