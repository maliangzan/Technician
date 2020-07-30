//
//  QBAssetsCollectionViewCell.h
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/31.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^SelectImageBlock) (BOOL isSelected, NSInteger index);
@interface QBAssetsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ALAsset *asset;
@property(nonatomic,copy) SelectImageBlock cellSelectBlock;
@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;//是否允许多选，允许多选才会有勾

@property(nonatomic,assign)BOOL selectVaild;

@property(nonatomic,strong)NSMutableSet*selectedAssetURLs;

//整个相册的所有图片
@property(nonatomic,strong)NSMutableArray *assets;

//当前cell的IndexPath
@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)bool showBigImage;

@property(nonatomic,assign)NSInteger maxNum;

@property (nonatomic, assign) BOOL isForChat; // 用于标识是否从聊天选择图片 更改发送文案
@end
