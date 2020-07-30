//
//  UIImage+JMC.h
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JMC)

- (UIImage *)blurryWithLevel:(CGFloat)blur;
//  放大缩小
- (UIImage *)xcResizeWithScale:(CGFloat)scale;
- (UIImage *)xcResizeWithMinWidth:(CGFloat)width;
- (UIImage *)xcResizeWithMinHeight:(CGFloat)height;
- (UIImage *)xcResizeWithMinSize:(CGSize)size;

+ (UIImage *)xcimageWithName:(NSString *)name ofType:(NSString *)type;


// 返回一个 PNG 的本地文件
+ (UIImage *)bundlePNG:(NSString *)name;

//  裁剪
- (UIImage *)cropWithRect:(CGRect)rect;

//  垂直翻转
- (UIImage *)flipVertical;
- (UIImage *)flipHorizontal;

- (UIImage *)orientation:(UIImageOrientation)orientation;
- (UIImage *)orientationByCTM:(UIImageOrientation)orientation;

- (UIImage *)rotateLeft;
- (UIImage *)rotateRight;

//  旋转为 up 方向
- (UIImage *)transformOrientationUp;

/**< 画出颜色图片 */
+(UIImage*) createImageWithColor:(UIColor*) color;


+(UIImage*) createImageWithColor:(UIColor*) color size:(CGSize)size;
@end
