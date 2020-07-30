//
//  JMTools.h
//  JMTools
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYChooseImageHelper : NSObject

@property (assign, nonatomic) BOOL allowsEditing;
@property (assign, nonatomic) BOOL onlyUseCamera;   //  default NO
@property (assign, nonatomic) BOOL onlyUsePhoto;    //  default NO


@property (nonatomic, strong) UIImagePickerController *imagePicker;   //  选完照片后附上，close 时，置 nil
@property (nonatomic, strong) UIImage *originalImage;     //  选完照片后附上，close 时，置 nil
@property (nonatomic, strong) UIImage *editedImage;       //  选完照片后附上，close 时，置 nil


@property (nonatomic, copy) void(^resultImage)(SYChooseImageHelper *helper, NSDictionary *info);


+ (SYChooseImageHelper *)shared;

- (void)show;
- (void)close;

@end
