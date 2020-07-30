//
//  PhotoManager.h
//  PhotosDemo
//
//  Created by any on 16/6/21.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSInteger, CameraStyle) {
    CameraPickerVendorCarmera= 0,//第三方相机，不需要截图
    CameraPickerSystemPhoto = 1,//调用系统相册，不需要截图
    CameraPickerVendorPhoto= 2,//第三方选择相册，不需要截图
    CameraPickerSystemCarmera = 3,//调用相机，不需要截图
    CameraPickerVendorCarmeraNeedClip = 4,//第三方需要截图相机
    CameraPickerVendorPhotoNeedClip = 5,//第三方选择相册，需要截图
    CameraPickerSystemPhotoNeedClip = 6,//调用系统相册，需要截图
    CameraPickerSystemCarmeraNeedClip = 7,//调用系统相机，需要截图
};

@protocol PhotoManagerDelegate <NSObject>
@optional
-(void)didChooseImage:(UIImage*)image;
-(void)didChooseimageArray:(NSArray*)imageArray;
-(void)didChooseImageAssets:(NSArray*)assets;
-(void)didChooseImageUrl:(NSURL*)url;
/**
 * @author KuangYi, 16-03-16 17:03:25
 *
 * @brief 调取照相机拍照返回的
 *
 * @param asset 返回Image的地址
 */
- (void)didChooseImageByCameraWithAsset:(ALAsset *)asset;
@required
@end

@interface PhotoManager : NSObject

/**< 负责推出相册的控制器 */
@property(nonatomic,strong) UIViewController*controller;

@property (nonatomic, assign) BOOL isForChat; // 用于标识是否从聊天选择图片 更改发送文案

/**<调用什么类型  */
@property(nonatomic,assign) CameraStyle cameraStyle;

/**< 系统相册的资源 */
@property(nonatomic)           UIImagePickerControllerSourceType     sourceType;                                                        // default value is UIImagePickerControllerSourceTypePhotoLibrary.
/**< 多选值 */
@property(nonatomic,assign)NSInteger maxImageNum;

@property(nonatomic,weak)id<PhotoManagerDelegate> delegate;

/**< 进入照片资源 */
-(void)enter;
@end
