//
//  JYSmileImagesPickerView.h
//  Printer
//
//  Created by Jim on 16/8/15.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmileImagesPickerViewDelegate <NSObject>

@optional
- (void)updateHeight:(CGFloat)height;  // 选择完后视图高度被改变

@end

@interface JYSmileImagesPickerView : UIView

@property (nonatomic, assign) BOOL isEditedImage;
@property (nonatomic, strong) NSMutableArray *images;    //图片和url
@property (nonatomic, strong) NSMutableArray *imagesAndKey; //图片和图片的key
@property (nonatomic, assign) NSInteger total; //照片上限
@property (nonatomic, assign) id<SmileImagesPickerViewDelegate> delegate;

- (void)setImagesData:(NSArray *)images;      //设置图片  编辑的时候会用到
- (void)setImageKeys:(NSArray *)imageKeys;    //设置图片key  编辑的时候会用到

//@property (nonatomic, copy) void (^updateHeight)(CGFloat h);

@end
