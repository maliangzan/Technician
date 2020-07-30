//
//  UIImage+create.m
//  Printer
//
//  Created by 旷旷怡 on 16/8/26.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import "UIImage+create.h"
#import "UIImage+JMC.h"
#import <objc/runtime.h>

static const char *s_hyb_image_borderColorKey = "s_hyb_image_borderColorKey";
static const char *s_hyb_image_borderWidthKey = "s_hyb_image_borderWidthKey";
static const char *s_hyb_image_pathColorKey = "s_hyb_image_pathColorKey";
static const char *s_hyb_image_pathWidthKey = "s_hyb_image_pathWidthKey";

@implementation UIImage (create)

- (CGFloat)hyb_borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, s_hyb_image_borderWidthKey);
    
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    
    return 1;
}

- (void)setHyb_borderWidth:(CGFloat)hyb_borderWidth {
    objc_setAssociatedObject(self,
                             s_hyb_image_borderWidthKey,
                             @(hyb_borderWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hyb_pathWidth {
    NSNumber *width = objc_getAssociatedObject(self, s_hyb_image_pathWidthKey);
    
    if ([width respondsToSelector:@selector(doubleValue)]) {
        return width.doubleValue;
    }
    
    return 0;
}

- (void)setHyb_pathWidth:(CGFloat)hyb_pathWidth {
    objc_setAssociatedObject(self,
                             s_hyb_image_pathWidthKey,
                             @(hyb_pathWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hyb_pathColor {
    UIColor *color = objc_getAssociatedObject(self, s_hyb_image_pathColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor whiteColor];
}

- (void)setHyb_pathColor:(UIColor *)hyb_pathColor {
    objc_setAssociatedObject(self,
                             s_hyb_image_pathColorKey,
                             hyb_pathColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIColor *)hyb_borderColor {
    UIColor *color = objc_getAssociatedObject(self, s_hyb_image_borderColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor lightGrayColor];
}

- (void)setHyb_borderColor:(UIColor *)hyb_borderColor {
    objc_setAssociatedObject(self,
                             s_hyb_image_borderColorKey,
                             hyb_borderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale {
    return [self hyb_private_clipImageToSize:targetSize
                                cornerRadius:0
                                     corners:UIRectCornerAllCorners
                             backgroundColor:backgroundColor
                                isEqualScale:isEqualScale
                                    isCircle:YES];
}





- (UIImage *)hyb_private_clipImageToSize:(CGSize)targetSize
                            cornerRadius:(CGFloat)cornerRadius
                                 corners:(UIRectCorner)corners
                         backgroundColor:(UIColor *)backgroundColor
                            isEqualScale:(BOOL)isEqualScale
                                isCircle:(BOOL)isCircle {
    if (targetSize.width <= 0 || targetSize.height <= 0) {
        return self;
    }
    //  NSTimeInterval timerval = CFAbsoluteTimeGetCurrent();
    
    CGSize imgSize = self.size;
    
    CGSize resultSize = targetSize;
    if (isEqualScale) {
        CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
        resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    }
    
    CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
    
    if (isCircle) {
        CGFloat width = MIN(resultSize.width, resultSize.height);
        targetRect = (CGRect){0, 0, width, width};
    }
    
    UIGraphicsBeginImageContextWithOptions(targetRect.size, NO, [UIScreen mainScreen].scale);
    
    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
    }
    
    
    CGFloat pathWidth = self.hyb_pathWidth;
    CGFloat borderWidth = self.hyb_borderWidth;
    
    if (pathWidth > 0 && borderWidth > 0 && (isCircle || cornerRadius == 0)) {
        UIColor *borderColor = self.hyb_borderColor;
        UIColor *pathColor = self.hyb_pathColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += pathWidth;
        rectImage.origin.y += pathWidth;
        rectImage.size.width -= pathWidth * 2.0;
        rectImage.size.height -= pathWidth * 2.0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        if (isCircle) {
            CGContextAddEllipseInRect(ctx, rect);
        } else {
            CGContextAddRect(ctx, rect);
        }
        
        CGContextClip(ctx);
        [self drawInRect:rectImage];
        
        // 添加内线和外线
        rectImage.origin.x -= borderWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0;
        rectImage.size.width += borderWidth;
        rectImage.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        if (isCircle) {
            CGContextStrokeEllipseInRect(ctx, rectImage);
            CGContextStrokeEllipseInRect(ctx, rect);
        } else if (cornerRadius == 0) {
            CGContextStrokeRect(ctx, rectImage);
            CGContextStrokeRect(ctx, rect);
        }
        
        float centerPathWidth = pathWidth - borderWidth * 2.0;
        CGContextSetLineWidth(ctx, centerPathWidth);
        CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
        
        rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
        rectImage.size.width += borderWidth + centerPathWidth;
        rectImage.size.height += borderWidth + centerPathWidth;
        
        if (isCircle) {
            CGContextStrokeEllipseInRect(ctx, rectImage);
        } else if (cornerRadius == 0) {
            CGContextStrokeRect(ctx, rectImage);
        }
    } else {
        if (isCircle) {
            CGContextAddPath(UIGraphicsGetCurrentContext(),
                             [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                        cornerRadius:targetRect.size.width / 2].CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        } else if (cornerRadius > 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        }
        
        [self drawInRect:targetRect];
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}


/**< 普通单个头像 Ray*/
- (UIImage *)hyb_clipCircleToSize:(CGSize)imageViewSize  image:(UIImage*)image
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale{
    
    image = [self clipOneImageToCircelImage:image];

    CGSize targetImageSize = imageViewSize;

    CGRect targetRect = (CGRect){0, 0, targetImageSize.width, targetImageSize.height};

    
    UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, [UIScreen mainScreen].scale);
    
    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, imageViewSize.width, imageViewSize.height));
    }
    
    
    targetRect.origin.x = imageViewSize.width/2 - targetRect.size.width/2;
    
    
    [image drawInRect:targetRect];
    
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
    
    
}


/**< 品牌头像 Ray*/
- (UIImage *)brandCircleToSize:(CGSize)imageViewSize{
    UIImage* backGroundImage = [UIImage createImageWithColor:[UIColor whiteColor] size:imageViewSize];
    
    backGroundImage = [self clipOneImageToCircelImage:backGroundImage];
    
//    cell.icon.layer.borderWidth=1;
    //                 cell.icon.layer.borderColor=[UIColor hexColorWithString:@"e5e5e5"].CGColor;
    //                 cell.icon.layer.cornerRadius=23;
    
    CGSize targetImageSize = imageViewSize;
    
    CGRect targetRect = (CGRect){0, 0, targetImageSize.width, targetImageSize.height};
    
    CGFloat cornerRadius = imageViewSize.width/2;

    CGFloat borderWidth = 1;
    

    UIColor *borderColor = [UIColor hexColorWithString:@"e5e5e5"];


    CGFloat ratio = self.size.width/self.size.height;
    CGRect brandImageRect = CGRectZero;
    if (ratio>1) {
        
        /**< 这种算法，图片会全部显示在圆框框内
         
         CGFloat  x = sqrt((pow(cornerRadius,2.0)*pow(ratio, 2.0))/(pow(ratio, 2.0)+1));
         brandImageRect = CGRectMake(cornerRadius -x,cornerRadius - x/ratio, 2*x, (2*x)/ratio);
         Ray*/
    
        
         brandImageRect = CGRectMake(0,(imageViewSize.height - imageViewSize.width/ratio)/2.0f, imageViewSize.width, imageViewSize.width/ratio);
        
    }else{
        
        /**< 这种算法，图片会全部显示在圆框框内
         
         CGFloat  y = sqrt(pow(cornerRadius,2.0)/(pow(ratio, 2.0)+1));
         brandImageRect = CGRectMake(cornerRadius -y*ratio,cornerRadius - y, 2*y*ratio, 2*y);
         Ray*/
 
        brandImageRect = CGRectMake((imageViewSize.width - imageViewSize.height*ratio )/2.0f,0, imageViewSize.height*ratio, imageViewSize.height);
    }
    
        
        CGRect rect = targetRect;
//        CGRect rectImage = rect;
//        rectImage.origin.x += pathWidth;
//        rectImage.origin.y += pathWidth;
//        rectImage.size.width -= pathWidth * 2.0;
//        rectImage.size.height -= pathWidth * 2.0;
    
    
       UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, [UIScreen mainScreen].scale);
    
       CGContextRef ctx = UIGraphicsGetCurrentContext();
    
        [backGroundImage drawInRect:targetRect];
    
    
       CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect
                                                cornerRadius:cornerRadius].CGPath);
       CGContextClip(ctx);

        [self drawInRect:brandImageRect];
    
        // 添加内线和外线
        brandImageRect.origin.x -= borderWidth / 2.0;
        brandImageRect.origin.y -= borderWidth / 2.0;
        brandImageRect.size.width += borderWidth;
        brandImageRect.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
    
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
    
    
          CGContextAddEllipseInRect(ctx, rect);
  
//
//            CGContextStrokeEllipseInRect(ctx, brandImageRect);
            CGContextStrokeEllipseInRect(ctx, rect);
    
//        
//        float centerPathWidth = pathWidth - borderWidth * 2.0;
//        CGContextSetLineWidth(ctx, centerPathWidth);
//        CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
//        
//        brandImageRect.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
//        brandImageRect.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
//        brandImageRect.size.width += borderWidth + centerPathWidth;
//        brandImageRect.size.height += borderWidth + centerPathWidth;
//        
//   
//            CGContextStrokeEllipseInRect(ctx, brandImageRect);
    

    

    
//    if (backgroundColor) {
//        [backgroundColor setFill];
//        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, imageViewSize.width, imageViewSize.height));
//    }
    
    
//    targetRect.origin.x = imageViewSize.width/2 - targetRect.size.width/2;
    
    
//    [image drawInRect:targetRect];
    
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
    
    
}



- (UIImage *)hyb_clipCircleToSize:(CGSize)imageViewSize  avatarList:(NSArray*)imgList
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale{
    NSMutableArray* avatarList =[NSMutableArray array];
    for (UIImage*img in imgList) {
        [avatarList addObject: [self clipOneImageToCircelImage:img]];
    }
    
    CGFloat space = 2;
    
    CGSize targetImageSize =  CGSizeMake((imageViewSize.width-space)/2.0f, (imageViewSize.width-space)/2.0f);
    
    
    CGRect targetRect = (CGRect){0, 0, targetImageSize.width, targetImageSize.height};
    
    
    //        CGFloat width = MIN(resultSize.width, resultSize.height);
    //        targetRect = (CGRect){0, 0, width, width};
    
    
    UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, [UIScreen mainScreen].scale);
    
    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, imageViewSize.width, imageViewSize.height));
    }
    
    if (avatarList.count == 1) {
        targetRect = (CGRect){0, 0, imageViewSize.width, imageViewSize.height};
        UIImage* image = avatarList.firstObject;
        [image drawInRect:targetRect];
    
    }
    
   else if (avatarList.count == 3) {
        
        //        if (isEqualScale) {
        //            CGFloat x = MAX(targetImageSize.width / imgSize.width, targetImageSize.height / imgSize.height);
        //            resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
        //        }
        
        for (int i=0; i<3 ; i++) {
            
            if (i == 0) {
                targetRect.origin.x = imageViewSize.width/2 - targetRect.size.width/2;
            }else if (i == 1)
            {
                targetRect.origin.x = 0;
                targetRect.origin.y +=  (targetRect.size.height+space);
            }else if (i == 2)
            {  targetRect.origin.x +=  (targetRect.size.width+space);
                
            }
            
            
            
            UIImage* image = avatarList[i];
            
            
            [image drawInRect:targetRect];
            
            
            
        }
        
        
    }else if (avatarList.count >= 4){
        
        
        for (int i=0; i<4 ; i++) {
            
            if (i == 0) {
                targetRect.origin.x = 0;
            }
            else if (i == 1) {
                targetRect.origin.x +=  (targetRect.size.width+space);
            }else if (i == 2)
            {
                targetRect.origin.x -=  (targetRect.size.width+space);
                targetRect.origin.y +=  (targetRect.size.height+space);
            }else if (i == 3)
            {  targetRect.origin.x +=  (targetRect.size.width+space);
                
            }
            
            UIImage* image = avatarList[i];
            
            [image drawInRect:targetRect];
        }
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}


-(UIImage*)clipOneImageToCircelImage:(UIImage*)image{

    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    CGRect targetRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextRef ctr=UIGraphicsGetCurrentContext();
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                cornerRadius:image.size.width / 2].CGPath);
    CGContextClip(ctr);

    [image drawInRect:targetRect];

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return finalImage;

}

void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}
@end
