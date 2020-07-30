//
//  MyScrollView.h
//  Cube
//
//  Created by zpz on 15/10/20.
//  Copyright (c) 2015年 VP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>



typedef void(^SelectBlock) (BOOL);
@interface MyScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView*imageView;
//大图的地址
@property(nonatomic,strong)NSString*fullUrl;

@property(nonatomic,strong)ALAsset*asset;

@property(nonatomic,assign)BOOL forSend;

@property(nonatomic,assign)BOOL selectedValid;

@property(nonatomic,copy)SelectBlock selectBlock;

@property(nonatomic,assign)NSInteger maxNum;

-(void)recover;
-(instancetype)initWithFrame:(CGRect)frame andImageView:(UIImage*)image;
@end
