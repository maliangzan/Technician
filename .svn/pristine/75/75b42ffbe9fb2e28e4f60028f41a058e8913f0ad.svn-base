//
//  UIImage+JMC.m
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIImage+JMC.h"

@implementation UIImage (JMC)



- (UIImage *)blurryWithLevel:(CGFloat)blur {

    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage, @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

- (UIImage *)xcResizeWithScale:(CGFloat)scale {
    
    CGFloat width  = CGImageGetWidth(self.CGImage) * scale;
    CGFloat height = CGImageGetHeight(self.CGImage) * scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [self drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)xcResizeWithMinWidth:(CGFloat)width {
    
    CGFloat widthNow = CGImageGetWidth(self.CGImage);
    if (width > widthNow) {
        return self;
    }
    
    CGFloat scale  = width / CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage) * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGRect rect = CGRectMake(0, 0, width, height);
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)xcResizeWithMinHeight:(CGFloat)height {
    
    CGFloat heightNow = CGImageGetHeight(self.CGImage);
    if (height > heightNow) {
        return self;
    }
    
    CGFloat scale  = height / CGImageGetHeight(self.CGImage);
    CGFloat width = CGImageGetWidth(self.CGImage) * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGRect rect = CGRectMake(0, 0, width, height);
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)xcResizeWithMinSize:(CGSize)size {
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    if (size.width > self.size.width && size.height > self.size.height) {
        return self;
    }
    
    CGSize newsize;
    CGFloat k1 = size.width / size.height;
    CGFloat k2 = self.size.width / self.size.height;
    
    if (k1 > k2) {
        //  比较高
        newsize = CGSizeMake(size.width, size.width/k2);
    }else{
        //  比较宽
        newsize = CGSizeMake(size.height * k2, size.height);
    }
    
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 1);
    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newing;
}

- (UIImage *)xcResetWithSize:(CGSize)size {
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:rect];
    
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newing;
}

- (UIImage *)scaleWithValue:(CGFloat)scale {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat width  = CGImageGetWidth(self.CGImage) * scale;
    CGFloat height = CGImageGetHeight(self.CGImage) * scale;
    size_t bitsPerComponent = CGImageGetBytesPerRow(self.CGImage);//8
    
    CGContextRef context = CGBitmapContextCreate(nil, width, height,
                                                 bitsPerComponent, 0,
                                                 colorSpace, kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    CGContextRelease(context);
    CGImageRelease(shrunken);
    return final;
}

+ (UIImage *)xcimageWithName:(NSString *)name ofType:(NSString *)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)bundlePNG:(NSString *)name {
    
    name = [name stringByAppendingString:@"@2x"];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    if (path != nil) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    NSLog(Localized(@"没有图片: %@"), name);
    return nil;
    
    //    日后优化，可以根据不同的设备返回不同的图片，自动为图片添加后缀。
    //    _ipad     _ipad@2x    -568h@2x
    
    //    甚至是一个 url
    
    //#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
    //#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
}

- (UIImage *)cropWithRect:(CGRect)rect {
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    //    * self.scale
    CGRect drawRect = CGRectMake(-rect.origin.x , -rect.origin.y,
                                 self.size.width,
                                 self.size.height );
    [self drawInRect:drawRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
    //    //    这种裁剪，不适合旋转后的图片
    //    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    //    UIImage *image = [UIImage imageWithCGImage:imageRef];
    //    CGImageRelease(imageRef);
    //    return image;
}

- (UIImage *)flip:(BOOL)isHorizontal {

    //TODO:有问题，为 fix
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    if (UIGraphicsBeginImageContextWithOptions != NULL) {
//        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    } else {
//        UIGraphicsBeginImageContext(rect.size);
//    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    if (isHorizontal) {
        CGContextRotateCTM(ctx, M_PI);
        CGContextTranslateCTM(ctx, -rect.size.width, -rect.size.height);
    }
    CGContextDrawImage(ctx, rect, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)flipVertical {
    return [self flip:NO];
}

- (UIImage *)flipHorizontal {
    return [self flip:YES];
}

- (UIImage *)orientation:(UIImageOrientation)orientation {
    
    return [[UIImage alloc] initWithCGImage:self.CGImage scale:self.scale orientation:orientation];
}

- (UIImage *)orientationByCTM:(UIImageOrientation)orientation {
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (UIImage *)orientationByxxxx {
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    UIImageOrientation orientation = self.imageOrientation;
    
    //  不用转
    if (orientation == UIImageOrientationUp) {
        return self;
    }
    
    //  图片的新大小
    if (orientation == UIImageOrientationUp || orientation == UIImageOrientationDown) {
        rect = CGRectMake(0, 0, self.size.width, self.size.height);
    }else{
        rect = CGRectMake(0, 0, self.size.height, self.size.width);
    }
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            //            translateX = 0;
            //            translateY = -rect.size.width;
            break;
            
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            //            translateX = -rect.size.height;
            //            translateY = 0;
            break;
            
        case UIImageOrientationDown:
            rotate = M_PI;
            //            translateX = -rect.size.width;
            //            translateY = -rect.size.height;
            break;
            
        default:
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
    
    //    switch (orientation) {
    //        case UIImageOrientationLeft:
    //            rotate = M_PI_2;
    //            rect = CGRectMake(0, 0, self.size.height, self.size.width);
    //            translateX = 0;
    //            translateY = -rect.size.width;
    //            scaleY = rect.size.width/rect.size.height;
    //            scaleX = rect.size.height/rect.size.width;
    //            break;
    //        case UIImageOrientationRight:
    //            rotate = 3 * M_PI_2;
    //            rect = CGRectMake(0, 0, self.size.height, self.size.width);
    //            translateX = -rect.size.height;
    //            translateY = 0;
    //            scaleY = rect.size.width/rect.size.height;
    //            scaleX = rect.size.height/rect.size.width;
    //            break;
    //        case UIImageOrientationDown:
    //            rotate = M_PI;
    //            rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //            translateX = -rect.size.width;
    //            translateY = -rect.size.height;
    //            break;
    //        default:
    //            rotate = 0.0;
    //            rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //            translateX = 0;
    //            translateY = 0;
    //            break;
    //    }
    
    //    UIGraphicsBeginImageContext(rect.size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    CGContextTranslateCTM(context, 0.0, rect.size.height);
    //    CGContextScaleCTM(context, 1.0, -1.0);
    //    CGContextRotateCTM(context, rotate);
    //    CGContextTranslateCTM(context, translateX, translateY);
    //
    //    CGContextScaleCTM(context, scaleX, scaleY);
    //    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    //    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    return newPic;
}

- (UIImage *)rotateLeft {
    UIImageOrientation ori = self.imageOrientation;
    switch (ori) {
        case UIImageOrientationUp:
            ori = UIImageOrientationLeft;
            break;
            
        case UIImageOrientationLeft:
            ori = UIImageOrientationDown;
            break;
            
        case UIImageOrientationDown:
            ori = UIImageOrientationRight;
            break;
            
        case UIImageOrientationRight:
            ori = UIImageOrientationUp;
            break;
            
        default:
            break;
    }
    
    return [self orientation:ori];
}

- (UIImage *)rotateRight {
    UIImageOrientation ori = self.imageOrientation;
    switch (ori) {
        case UIImageOrientationUp:
            ori = UIImageOrientationRight;
            break;
            
        case UIImageOrientationLeft:
            ori = UIImageOrientationUp;
            break;
            
        case UIImageOrientationDown:
            ori = UIImageOrientationLeft;
            break;
            
        case UIImageOrientationRight:
            ori = UIImageOrientationDown;
            break;
            
        default:
            break;
    }
    return [self orientation:ori];
}

static inline double radians (double degrees) {return degrees * M_PI/180;}

/*
 根据图片方向 imageOrientation，旋转图像数据，重置为 UIImageOrientationUp
 */
- (UIImage *)transformOrientationUp {
    
    //  默认的不转
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    double rotate = 0.0;
    CGFloat translateX = 0;
    CGFloat translateY = 0;
    CGSize originalSize;    //  原图大小
    
    UIImageOrientation orientation = self.imageOrientation; //  当前方向
    //  新旧方向对画布大小的影响
    if (orientation == UIImageOrientationDown) {
        
        originalSize = CGSizeMake(self.size.width, self.size.height);
    }else{
        originalSize = CGSizeMake(self.size.height, self.size.width);
    }
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = radians(90);
            translateX = self.size.height;
            translateY = 0;
            break;
            
        case UIImageOrientationRight:
            rotate = radians(-90);
            translateX = 0;
            translateY = self.size.width;
            break;
            
        case UIImageOrientationDown:
            rotate = radians(180);
            translateX = self.size.width;
            translateY = self.size.height;
            break;
            
        default:
            break;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //  解决坐标系不同，原点在左下角
    CGContextTranslateCTM(context, 0.0, originalSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextRotateCTM(context, rotate);
    
    CGContextDrawImage(context, CGRectMake(0, 0, originalSize.width, originalSize.height), self.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}


+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+(UIImage*) createImageWithColor:(UIColor*) color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
