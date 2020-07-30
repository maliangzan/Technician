//
//  PhotoManager.m
//  PhotosDemo
//
//  Created by any on 16/6/21.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "PhotoManager.h"
#import "QBImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+JMC.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UINavigationController+JMSwizzle.h"




@interface PhotoManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate>

@property(nonatomic,strong)QBImagePickerController*imagePickerController;

@property(nonatomic,strong)NSMutableArray*imageArray;

@property(nonatomic,strong)NSMutableArray*assets;



@end
@implementation PhotoManager
{
    PhotoManager*_manager;
}

-(instancetype)init{
    if (self=[super init]) {
        _manager=self;
    }
    return self;
}


-(void)enter{
    switch (self.cameraStyle) {
        case CameraPickerSystemCarmeraNeedClip:
        {
            [self selectCameraNeedClip:YES];            }
            break;
        case CameraPickerSystemPhotoNeedClip:
        {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  
            picker.delegate = self;
            
            picker.allowsEditing = YES;
            
            picker.sourceType =  self.sourceType;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            
            [self.controller presentViewController:picker animated:YES completion:nil];
        }
            
        case CameraPickerSystemPhoto:{
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //DLog(@"进入相册");
            picker.delegate = self;
            
            picker.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            
            [self.controller presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        case CameraPickerVendorPhoto:
        {
            
            [self selectAddPhoto];
        }
            break;
            
        case CameraPickerSystemCarmera:{
            [self selectCameraNeedClip:NO];
        }
            break;
        case CameraPickerVendorCarmeraNeedClip:{
            
        }
            
            
        default:
            
            
            break;
        case CameraPickerVendorPhotoNeedClip: {
            
            break;
        }
    }
    

}


-(void)selectCameraNeedClip:(BOOL)isNeed{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
    
            //                 NSString *mediaType = AVCaptureDeviceWasConnectedNotification;
            NSString *mediaType = AVMediaTypeVideo;
            //判断相机是否能够使用
            AVAuthorizationStatus  status=[AVCaptureDevice authorizationStatusForMediaType:mediaType];
            
            if(status == AVAuthorizationStatusAuthorized) {
                // authorized
                [self presentCameraNeedClip:isNeed];
            } else if(status == AVAuthorizationStatusDenied || status ==AVAuthorizationStatusRestricted ){
                // denied
//                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
 #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
                    UIAlertController*alertVC=[UIAlertController  alertControllerWithTitle:Localized(@"提示") message:Localized(@"请先在设置->隐私->相机中对技师端打开相机") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*sureAction=[UIAlertAction actionWithTitle:Localized(@"去设置") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        /**< 确定去设置按钮 */
                        [alertVC dismissViewControllerAnimated:YES completion:nil];
                        NSString *app_id = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
                        
//                        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@", app_id ]];
//                        
//                        [[UIApplication sharedApplication] openURL:setUrl];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
          
                    }];
                    
                    /**< 取消按钮 */

                    UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:Localized(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [alertVC dismissViewControllerAnimated:YES completion:nil];
                    }];
                    
                  
                    [alertVC addAction:cancelAction];
                    
                      [alertVC addAction:sureAction];

                      [self.controller presentViewController:alertVC animated:YES completion:nil];
//                }else{
#else
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:Localized(@"提示") message:Localized(@"请先在设置->隐私->相机中对欢旅打开相机") delegate:nil cancelButtonTitle:Localized(@"确定") otherButtonTitles: nil];
                [alertView show];
//                }
#endif
                return ;
            }
            else if(status == AVAuthorizationStatusNotDetermined){
                // not determined
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted){
                        [self presentCameraNeedClip:isNeed];
                    } else {
                        return;
                    }
                }];
            }
        
    }else {
        //DLog(@"该设备无摄像头");
    }
    
}

/**< 推出系统相机 */
-(void)presentCameraNeedClip:(BOOL)isNeed{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    picker.allowsEditing = isNeed;
    picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice=    UIImagePickerControllerCameraDeviceRear;
    
    [self.controller presentViewController:picker animated:YES completion:nil];
    
}



#pragma 拍照的代理方法
//拍照的代理方法--系统相册的选择也是走这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    if ([self.delegate respondsToSelector:@selector(didChooseImageUrl:)]) {
        [self.delegate didChooseImageUrl:imageURL];
    }
    
    UIImage*image=nil;
    if ((int)self.cameraStyle<4) {
        image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    }else{
        image=[info objectForKey:UIImagePickerControllerEditedImage];
    }
    
  /**< 保存图片 */
        NSString* date;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        date = [formatter stringFromDate:[NSDate date]];
        [self saveImage:image withName:[date stringByAppendingString:@"MoFang.png"]];


        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{
               if ([weakSelf.delegate respondsToSelector:@selector(didChooseImage:)]&&image) {
            [weakSelf.delegate didChooseImage: image];
                      }
            
            if ([weakSelf.delegate respondsToSelector:@selector(didChooseimageArray:)]&&image) {
                [weakSelf.delegate didChooseimageArray:@[ image]];
            }
        });
        
 
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissImagePickerController];
    });
    
    
    
    
}


#pragma mark 拍照后保存图片的方式
-(void)saveImage:(UIImage*)currentImage withName:(NSString*)imageName{
    
    [self saveImageToPhotos:currentImage];
}


- (void)saveImageToPhotos:(UIImage*)savedImage

{
    
    UIImage*image =[savedImage transformOrientationUp];
    QBImagePickerController *qbcontroller = [QBImagePickerController new];
    [qbcontroller.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [self getImageAlassetWithAssetUrl:assetURL];
    }];
    
}

//通过AssetUrl获取alssetUrl
- (void)getImageAlassetWithAssetUrl:(NSURL *)assetUrl {
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    QBImagePickerController *qbcontroller = [QBImagePickerController new];
    [qbcontroller.assetsLibrary assetForURL:assetUrl resultBlock:^(ALAsset *asset) {
        if ([self.delegate respondsToSelector:@selector(didChooseImageByCameraWithAsset:)]) {
            [self.delegate didChooseImageByCameraWithAsset:asset];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    
}

// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = Localized(@"保存图片失败") ;
        
    }else{
        
        msg = Localized(@"保存图片成功") ;
        
    }
    
    
}


- (void)dismissImagePickerController
{
   
    if (self.controller.presentedViewController) {
        [self.controller.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        if(self.controller){
            [self.controller.navigationController popViewControllerAnimated:YES];
            
        }
    }
}


#pragma mark 第三方库选择照片

#pragma mark QBImage
//选择相册相片方法
-(void)selectAddPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:  UIImagePickerControllerSourceTypePhotoLibrary]){
        
        //判断相册是否能够使用
        ALAuthorizationStatus  status=[ALAssetsLibrary authorizationStatus];
        
        if(status == ALAuthorizationStatusAuthorized) {
            // authorized
            [self openPhotoLibrary];            
            
        } else if(status == ALAuthorizationStatusDenied || status ==ALAuthorizationStatusRestricted){
            // denied
//            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            
            #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
                UIAlertController*alertVC=[UIAlertController  alertControllerWithTitle:Localized(@"提示") message:Localized(@"请先在设置->隐私->照片中对技师端打开照片") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*sureAction=[UIAlertAction actionWithTitle:Localized(@"去设置") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    /**< 确定去设置按钮 */
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
//                    NSString *app_id = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
                    //                        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@", app_id ]];
                    //
                    //                        [[UIApplication sharedApplication] openURL:setUrl];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    
                }];
                
                /**< 取消按钮 */
                
                UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:Localized(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
                }];
                
                
                [alertVC addAction:cancelAction];
                
                [alertVC addAction:sureAction];
                
                [self.controller presentViewController:alertVC animated:YES completion:nil];
//            }else{
#else
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:Localized(@"提示") message:Localized(@"请先在设置->隐私->照片中对技师端打开照片") delegate:nil cancelButtonTitle:Localized(@"确定") otherButtonTitles: nil];
                [alertView show];
//            }
#endif
            return ;
        }
        else if(status == ALAuthorizationStatusNotDetermined){
//                   [self openPhotoLibrary];
            
            //  #if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
            //            #if JYAPPTYPE == AppTypeDispatch
            
            if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
                
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    
                    if (status == PHAuthorizationStatusAuthorized) {
                        
                       [self openPhotoLibrary];
                    }
                }];
            }
            
#else
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (*stop) {
                    
                  [self openPhotoLibrary];
                    
                    return;
                }
                *stop = TRUE;
                
            } failureBlock:^(NSError *error) {
                
                NSLog(@"failureBlock");
            }];
            
            
#endif
            
        }
        
        
        
//            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
//
//            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                
//                if (*stop) {
//                    
//                    // TODO:...
//                    return;
//                }
//                *stop = TRUE;//不能省略
//                
//            } failureBlock:^(NSError *error) {
//                
//                NSLog(@"failureBlock");
//            }];
//            
//            
//            // not determined
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                if(granted){
//    
//                    [self openPhotoLibrary];
//                    
//                         } else {
//                    return;
//                }
//            }];

    }else {
        //DLog(@"该设备无摄像头");
    }

    
  

    
}


-(void)openPhotoLibrary{
    self.imagePickerController=[[QBImagePickerController alloc]init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsMultipleSelection =YES;
    self.imagePickerController.minimumNumberOfSelection = 0;
    self.imagePickerController.maximumNumberOfSelection = self.maxImageNum;
    self.imagePickerController.isForChat = self.isForChat;
    
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController:self.imagePickerController delegateMyself:self];
    
    [self.imagePickerController jumpIndexPathAlbum:[NSIndexPath indexPathForRow:0 inSection:0] fromController:self.controller andNavigation:navigationController];
    
    

}


#pragma mark - QBImagePickerControllerDelegate
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    
    
    //已经选好照片
    [self dismissImagePickerController];
    
    [MBProgressHUD showMessage:Localized(@"正在处理")];
    
    //    子线程加载方法
    NSOperationQueue*queue=[[NSOperationQueue alloc]init];
    __weak typeof(self) weakSelf=self;
    [queue addOperationWithBlock:^{
        for (ALAsset*asset in assets) {
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage*image = [UIImage imageWithCGImage:imgRef
                                                scale:assetRep.scale
                                          orientation:(UIImageOrientation)assetRep.orientation];
            
            [weakSelf.imageArray addObject:image];
            
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            if ([weakSelf.delegate respondsToSelector:@selector(didChooseimageArray:)]) {
                [weakSelf.delegate didChooseimageArray:self.imageArray];
            }
            if ([weakSelf.delegate respondsToSelector:@selector(didChooseImageAssets:)]) {
                [weakSelf.delegate didChooseImageAssets:assets];
            }
            
        });
        
    }];
    
    
    
}


- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissImagePickerController];
}






@end
