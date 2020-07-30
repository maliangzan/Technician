//
//  UIImage+create.h
//  Printer
//
//  Created by 旷旷怡 on 16/8/26.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (create)
#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *	默认为1.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_borderWidth;
/**
 *	当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_pathWidth;
/**
 *	边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_borderColor;
/**
 *	Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_pathColor;



#pragma mark - 生成圆形图片
/**
 *	将图片裁剪成圆形
 *
 *	@param targetSize			  裁剪后的图片大小.如果宽与高不相等，会通过isMax参数决定
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return 圆形图片对象
 */
- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale;


- (UIImage *)hyb_clipCircleToSize:(CGSize)imageViewSize  avatarList:(NSArray*)avatarList
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale;


- (UIImage *)brandCircleToSize:(CGSize)imageViewSize;

-(UIImage*)clipOneImageToCircelImage:(UIImage*)image; 

@end
