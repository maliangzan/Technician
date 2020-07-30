//
//  UIView+JMC.h
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//  http://ericasadun.com

#import <UIKit/UIKit.h>

@interface UIView (JMC)

+ (id)viewWithNib:(NSString *)name;

//  只查一层
- (BOOL)containsSubview:(id)aView;

#pragma mark - frame
@property (nonatomic, readonly) NSString *frameString;

////  容易冲突，例如和 masonry。要用的话，需要加前缀
//@property CGFloat top;
//@property CGFloat left;
//@property CGFloat bottom;
//@property CGFloat right;
//
//@property CGFloat width;
//@property CGFloat height;
//
//@property CGPoint origin;
//@property CGSize  size;
//
//@property (readonly) CGPoint topLeft;
//@property (readonly) CGPoint topRight;
//@property (readonly) CGPoint bottomLeft;
//@property (readonly) CGPoint bottomRight;


#pragma mark - ?
- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

@end
