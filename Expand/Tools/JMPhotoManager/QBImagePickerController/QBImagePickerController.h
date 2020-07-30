//
//  QBImagePickerController.h
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/30.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSUInteger, QBImagePickerControllerFilterType) {
    QBImagePickerControllerFilterTypeNone,
    QBImagePickerControllerFilterTypePhotos,
    QBImagePickerControllerFilterTypeVideos
};

UIKIT_EXTERN ALAssetsFilter * ALAssetsFilterFromQBImagePickerControllerFilterType(QBImagePickerControllerFilterType type);

@class QBImagePickerController;

@protocol QBImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset;
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets;
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController;

@end

@interface QBImagePickerController : UITableViewController

@property (nonatomic, strong, readonly) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, copy, readonly) NSArray *assetsGroups;
@property (nonatomic, strong) NSMutableSet *selectedAssetURLs;

@property (nonatomic, weak) id<QBImagePickerControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *groupTypes;
@property (nonatomic, assign) QBImagePickerControllerFilterType filterType;
@property (nonatomic, assign) BOOL showsCancelButton;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;
@property (nonatomic, assign) BOOL isForChat; // 用于标识是否从聊天选择图片 更改发送文案

+ (BOOL)isAccessible;


/**
 *  从某个控制器推出相册列表里面的某一个相册
 *
 *  @param indexPath  第几个相册，都是第一个区
 *  @param controller 当前控制器
 */
-(void)jumpIndexPathAlbum:(NSIndexPath*)indexPath fromController:(UIViewController*)controller andNavigation:(UINavigationController*)navigationController;
@end
