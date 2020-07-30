//
//  QBPreImageController.h
//  FunHotel
//
//  Created by Etre on 16/4/26.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


typedef void(^SelectImageBlock) (BOOL isSelected, NSInteger index);
@interface QBPreImageController : UIViewController
@property(nonatomic,copy)SelectImageBlock selectImageBlock;


@property(nonatomic,strong)NSMutableArray*assets;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,assign)BOOL selectedValid;

@property(nonatomic,assign)BOOL forSend;

@property (nonatomic, assign) BOOL isForChat; // 用于标识是否从聊天选择图片 更改发送文案

@property(nonatomic,strong)NSMutableSet *selectedAssetURLs;

@property(nonatomic,assign)NSInteger maxNum;

@end
