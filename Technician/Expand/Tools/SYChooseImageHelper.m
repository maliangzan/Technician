//
//  JMTools.h
//  JMTools
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "SYChooseImageHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHAsset.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SYChooseImageHelper () <UIActionSheetDelegate>

@property (nonatomic, assign) UIStatusBarStyle currentStatusBarStyle;

@end;

@implementation SYChooseImageHelper
{
    UIActionSheet *_actionSheet;
}

+ (SYChooseImageHelper *)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)dealloc {
    NSLog(@"SYChooseImageHelper dealloc");
}

#pragma mark - show
- (void)show {
    
    
    if (_onlyUseCamera) {
        [SYChooseImageHelper openCamera];
        return;
    }
    if (_onlyUsePhoto) {
        [SYChooseImageHelper openPhoto];
        return;
    }
    
    [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)close {
    if (self.imagePicker) {
        [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
        
        self.originalImage = nil;
        self.editedImage = nil;
        self.imagePicker = nil;
    }
}

#pragma mark - auth
- (BOOL)checkPermissions {
    //dispatch_async(dispatch_get_main_queue(), ^{
    //    [[QMAlertViewTwo(@"Camera_Auth", @"Camera_SetStep", Localized(@"取消"), Localized(@"确定"))
    //      setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
    //          [self closeCamera];
    //          if (index != kAlertCancelIndex) {
    //              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    //          }
    //      }] show];
    //    
    //});
    return YES;
}


#pragma mark - 菜单
// TODO
- (UIActionSheet *)actionSheet {
    
    if (_actionSheet == nil) {
        NSString *openCamera = @"拍照";
        NSString *openPhoto = @"从手机相册选择";
        NSString *cancel = @"取消";

        _actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:cancel
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:openCamera, openPhoto, nil];
        
    }
    return _actionSheet;
}

- (void)clickEmpty {
    [self.actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [SYChooseImageHelper openCamera];
        return;
    }
    if (buttonIndex == 1) {
        [SYChooseImageHelper openPhoto];
        return;
    }
}

/**
 *  @return 当前Window最上面的 UIViewController
 */
+ (UIViewController *)currentWindowTopViewController {
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //  normal 才是正确的 window
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow * win in windows) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    UIResponder *next = frontView.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while(next != nil);
    
    return window.rootViewController;
}

+ (void)openPhoto {
    
    if ([UIImagePickerController isSourceTypeAvailable:  UIImagePickerControllerSourceTypePhotoLibrary]){
        
        //判断相册是否能够使用
        ALAuthorizationStatus  status=[ALAssetsLibrary authorizationStatus];
        
        if(status == ALAuthorizationStatusAuthorized) {
            // authorized
            [self openPhotoAction];
            
        } else if(status == ALAuthorizationStatusDenied || status ==ALAuthorizationStatusRestricted){
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
            UIAlertController*alertVC=[UIAlertController  alertControllerWithTitle:@"去设置" message:@"请先在设置->隐私->照片中对源健康打开照片"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*sureAction=[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                /**< 确定去设置按钮 */
                [alertVC dismissViewControllerAnimated:YES completion:nil];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }];
            
            /**< 取消按钮 */
            
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            }];
            
            
            [alertVC addAction:cancelAction];
            
            [alertVC addAction:sureAction];
            
            [[self currentWindowTopViewController] presentViewController:alertVC animated:YES completion:nil];
            
#else
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"去设置" message:@"Camera_SetOpenPic" delegate:nil cancelButtonTitle:@"取消"otherButtonTitles: nil];
            [alertView show];
            
#endif
            return ;
        }
        else if(status == ALAuthorizationStatusNotDetermined){
            
            //  #if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
            //            #if JYAPPTYPE == AppTypeDispatch
            
            if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
                
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    
                    if (status == PHAuthorizationStatusAuthorized) {
                        
                        [self openPhotoAction];
                    }
                }];
            }
#else
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (*stop) {
                    
                    
                    [self openPhotoAction];
                    
                    return;
                }
                *stop = TRUE;
                
            } failureBlock:^(NSError *error) {
                
                NSLog(@"failureBlock");
            }];
#endif
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"没有权限" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];

    }
}

+ (void)openPhotoAction {
    
    [self shared].currentStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = [self shared];
    picker.allowsEditing = [self shared].allowsEditing;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [[self currentWindowTopViewController] presentViewController:picker animated:YES completion:nil];

}

+ (void)openCamera {
    [SYChooseImageHelper openCameraJuge];
}

+ (void)openCameraJuge {
        NSString *mediaType = AVMediaTypeVideo;
        //判断相机是否能够使用
        AVAuthorizationStatus  status=[AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(status == AVAuthorizationStatusAuthorized) {
            // authorized
            [self openCameraAction];
        } else if(status == AVAuthorizationStatusDenied || status ==AVAuthorizationStatusRestricted ){
            // denied
//            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
                UIAlertController*alertVC=[UIAlertController  alertControllerWithTitle:@"去设置" message:@"请先在设置->隐私->相机中对源健康打开相机" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*sureAction=[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    /**< 确定去设置按钮 */
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
                    NSString *app_id = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    
                }];
                
                /**< 取消按钮 */
                
                UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
                }];
                
                
                [alertVC addAction:cancelAction];
                
                [alertVC addAction:sureAction];
                
                [[self currentWindowTopViewController] presentViewController:alertVC animated:YES completion:nil];
#else
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:Localized(@"去设置") message:Localized(@"请先在设置->隐私->相机中对源健康打开相机") delegate:nil cancelButtonTitle:Localized(@"取消") otherButtonTitles: nil];
                [alertView show];
#endif
            return ;
        }
        else if(status == AVAuthorizationStatusNotDetermined){
            // not determined
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted){
                      [self openCameraAction];
                } else {
                    return;
                }
            }];
        }
}

+ (void)openCameraAction{
    
    [self shared].currentStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = [self shared];
        picker.allowsEditing = [self shared].allowsEditing;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        picker.showsCameraControls = NO;
        [[self currentWindowTopViewController] presentViewController:picker animated:YES completion:nil];
    });

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    self.imagePicker = picker;
    self.originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];//    UIImagePickerControllerMediaURL
    self.editedImage   = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    if (self.resultImage) {
        self.resultImage(self, info);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.imagePicker = picker;
    if (self.resultImage) {
        self.resultImage(self, nil);
    }
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:self.currentStatusBarStyle];
}

@end
