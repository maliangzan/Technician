//
//  QBAssetsCollectionViewCell.m
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/31.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBAssetsCollectionViewCell.h"
#import <ImageIO/ImageIO.h>

#import "QBAssetsCollectionCheckmarkView.h"

#import "UIImage+JMC.h"

#import "MyScrollView.h"

#import "QBPreImageController.h"
//#import "QBLayerDelegate.h"
#import "QBLayer.h"
@interface QBAssetsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) QBAssetsCollectionCheckmarkView *checkmarkView;

@property(nonatomic,strong)QBLayer*myLayer;
@end

@implementation QBAssetsCollectionViewCell
{
    MyScrollView  *scrollView;
//    QBPreImageController*preViewC;
  
}

-(QBLayer*)myLayer{
    if (!_myLayer) {
        _myLayer=[QBLayer layer];
        
        [_myLayer setShouldRasterize:YES];
        _myLayer.contentsScale= 4;
        _myLayer.rasterizationScale= 4;
        
        _myLayer.frame=CGRectMake(self.bounds.size.width - (4.0 + 20.0),  4.0 , 20.0, 20.0);
  
        _myLayer.rect=_myLayer.frame;
        
//        _myLayer.shouldRasterize=NO;
//
//        _myLayer.shouldRasterize=YES;
        [self.layer addSublayer:_myLayer];
        

        }
    return _myLayer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showsOverlayViewWhenSelected = YES;
        
        // Create a image view
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.clipsToBounds=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    
         [self hideOverlayView];
        
        
    }
    
    return self;
}



-(void)setSelectVaild:(BOOL)selectVaild{
    _selectVaild=selectVaild;
    
//    scrollView.selectedValid=selectVaild;
//  preViewC.selectedValid=selectVaild;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self];
   
    if (point.x>self.bounds.size.width/2-15&&point.y<self.bounds.size.width/2-15) {
        //NSLog(@"出发cell选择事件");
        self.showBigImage=NO;
        [super touchesBegan:touches withEvent:event];
    }else{
      //NSLog(@"全图显示");
        self.showBigImage=YES;
        UIViewController*vc=currentViewControllerFormView(self);
        vc.navigationController.navigationBarHidden=YES;
/*
        scrollView=[[MyScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) andImageView:[UIImage fixOrientation:[UIImage imageWithCGImage:[[_asset defaultRepresentation] fullResolutionImage]]]];
        
        scrollView.forSend=self.selected;
        scrollView.selectedValid=self.selectVaild;
        scrollView.maxNum=self.maxNum;
        
        __weak typeof(self) weakSelf=self;
        
        scrollView.selectBlock=^(BOOL isSelected){
            
            if (isSelected) {
//                [self hideOverlayView];
                [self showOverlayView];
            }else{
                [self hideOverlayView];
            }
            
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(isSelected);
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:scrollView];
    */
       QBPreImageController*  preViewC=[[QBPreImageController alloc]init];
        preViewC.selectedAssetURLs=self.selectedAssetURLs;
        preViewC.assets=self.assets;
        preViewC.index=self.indexPath.row;
        preViewC.forSend=self.selected;
        preViewC.selectedValid=self.selectVaild;
        preViewC.maxNum=self.maxNum;
        preViewC.isForChat=self.isForChat;
        
        __weak typeof(self) weakSelf=self;
        
        preViewC.selectImageBlock=^(BOOL isSelected,NSInteger index){
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(isSelected,index);
            }
        };
        [currentViewControllerFormView(weakSelf).navigationController pushViewController:preViewC animated:YES];
     
    }
    
}


//点击后的cell执行方法不写在cellectionView里面，直接写在这里
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
   
    // Show/hide overlay view
    if (selected && self.showsOverlayViewWhenSelected) {
//        [self hideOverlayView];
        [self showOverlayView];
    } else {
        [self hideOverlayView];
    }
}






- (void)showOverlayView
{
//     [self.checkmarkView removeFromSuperview];
//
//    
//    QBAssetsCollectionCheckmarkView *checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 20.0),  4.0 , 20.0, 20.0)];
//    
//    checkmarkView.autoresizingMask = UIViewAutoresizingNone;
//    checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
//    checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
//    checkmarkView.layer.shadowOpacity = 0.6;
//    checkmarkView.layer.shadowRadius = 2.0;
//    checkmarkView.showNoSelect=NO;
//  
//    [self addSubview:checkmarkView];
//    
//    self.checkmarkView=checkmarkView;
    
    self.myLayer.showNoSelect=NO;

    [self.myLayer setNeedsDisplay];
}

- (void)hideOverlayView
{
//    [self.checkmarkView removeFromSuperview];
    
//    QBAssetsCollectionCheckmarkView *checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 20.0),  4.0 , 20.0, 20.0)];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    checkmarkView.autoresizingMask = UIViewAutoresizingNone;
//    checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
//    checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
//    checkmarkView.layer.shadowOpacity = 0.6;
//    checkmarkView.layer.shadowRadius = 2.0;
//    });
//    
//    checkmarkView.showNoSelect=YES;
//    
//     
//    [self addSubview:checkmarkView];
//      self.checkmarkView=checkmarkView;
//    dispatch_async(dispatch_get_main_queue(), ^{
    
 
    
  
//    layer.backgroundColor=[UIColor redColor].CGColor;
//    _myLayer.frame=CGRectMake(self.bounds.size.width - (4.0 + 20.0),  4.0 , 20.0, 20.0);
//    
    
    
//    QBLayerDelegate*layerDelegate=[[QBLayerDelegate alloc]init];
//    _myLayer.rect=_myLayer.frame;
    
    self.myLayer.showNoSelect=YES;

  
    [self.myLayer setNeedsDisplay];
    
  
//       });
}


#pragma mark - Accessors

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
//        self.imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    // Update view
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage*image=[self thumbnailForAsset:asset maxPixelSize:150];
        
        UIImage*image=[[UIImage imageWithCGImage:self.asset.aspectRatioThumbnail] transformOrientationUp];
    
//        UIImage*image=[UIImage imageWithImageSimple:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] scaledToSize:CGSizeMake(150, 150)];
        dispatch_async(dispatch_get_main_queue(), ^{
               self.imageView.image =image ;
        });
}

- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(int)size {
    NSParameterAssert(asset != nil);
    NSParameterAssert(size > 0);
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInt:size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}

static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        //NSLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }
    
    return countRead;
}

static void releaseAssetCallback(void *info) {
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}

@end
