//
//  QBScrollView.h
//  FunHotel
//
//  Created by Etre on 16/4/26.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface QBScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView*imageView;
//大图的地址
@property(nonatomic,strong)NSString*fullUrl;

@property(nonatomic,strong)ALAsset*asset;

//手势
@property(nonatomic,strong)UILongPressGestureRecognizer*longGR;



-(void)recover;
-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)image;

-(instancetype)initWithFrame:(CGRect)frame andImageUrlStr:(NSString*)urlStr;

//保存图片
- (void)saveImage;
@end
