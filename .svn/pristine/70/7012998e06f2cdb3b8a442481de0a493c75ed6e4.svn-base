//
//  QBScrollView.m
//  FunHotel
//
//  Created by Etre on 16/4/26.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import "QBScrollView.h"
#import "QBAssetsCollectionCheckmarkView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import "UIImage+JMC.h"

#define  edge 9.0
@interface QBScrollView()

@end
@implementation QBScrollView
{
    UIImageView*imageView;

    UIActivityIndicatorView *_indicatorView;
    
    QBAssetsCollectionCheckmarkView *checkmarkView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    if (self=[super initWithFrame:frame]) {
        self.bounces=YES;
        self.pagingEnabled=NO;
        self.maximumZoomScale=3.0;
        self.minimumZoomScale=0.5;
        self.backgroundColor=[UIColor blackColor];
        self.delegate=self;
        self.userInteractionEnabled=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.image=image;
        imageView.userInteractionEnabled=YES;
        self.contentSize=imageView.frame.size;
        self.imageView=imageView;
        [self addSubview:imageView];

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andImageUrlStr:(NSString*)urlStr{
    if (self=[super initWithFrame:frame]) {
        self.bounces=YES;
        self.pagingEnabled=NO;
        self.maximumZoomScale=2.0;
        self.minimumZoomScale=0.5;
        self.backgroundColor=[UIColor blackColor];
        self.delegate=self;
        self.userInteractionEnabled=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
    
     
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_pic"]];
        imageView.userInteractionEnabled=YES;
        self.contentSize=imageView.frame.size;
        self.imageView=imageView;
        [self addSubview:imageView];
        
    }
    return self;

}

-(void)setFullUrl:(NSString *)fullUrl{
    _fullUrl=fullUrl;
    if (!isNull(self.fullUrl)) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.fullUrl] placeholderImage:imageView.image];
    }
    
}


-(void)setAsset:(ALAsset *)asset{
    _asset=asset;
    if (!asset) {
        return;
    }
    
//    CGImageRef imageRef=[[asset defaultRepresentation] fullScreenImage];
//  UIImage*image=[UIImage imageWithCGImage:imageRef ];
//    imageView.image=image;
//    
//  UIActivityIndicatorView*  indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.userInteractionEnabled=NO;
//    indicatorView.frame=CGRectMake(imageView.frame.size.width/2-25, imageView.frame.size.height/2-25,50, 50);
//   [imageView addSubview:indicatorView];
//    [indicatorView startAnimating];
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,
//                                                 0),
//                       ^{
       imageView.contentMode=UIViewContentModeScaleAspectFit;
                           UIImage*image2=[UIImage imageWithCGImage: [asset  aspectRatioThumbnail]];
    
//                           dispatch_async(dispatch_get_main_queue(), ^{
                               imageView.image=image2;
//                               [indicatorView removeFromSuperview];
                               
//
//                           });
//                           
//                       });
  
    
    delayExcitueMethod(0.3, ^{
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,
                                                                                0),
                                                      ^{
        
                                                          CGImageRef imageRef=[[asset defaultRepresentation] fullResolutionImage];
        
                                                          UIImage*image=[UIImage imageWithCGImage:imageRef scale:1 orientation:(UIImageOrientation)[[asset defaultRepresentation] orientation] ];
//
        
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                    
                                                              imageView.image=image;
                                                              
                                                          });
                                                          
                                                      });

    });

   
}




-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = self.bounds.size.width/2 , ycenter = self.bounds.size.height/2;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ?
    scrollView.contentSize.width/2 : xcenter;
    //同上，此处修改y值
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?
    scrollView.contentSize.height/2 : ycenter;
    [self.imageView setCenter:CGPointMake(xcenter, ycenter)];
}

-(void)recover{
    self.imageView.transform=CGAffineTransformIdentity;
    self.imageView.frame=CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    
    
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    
    return self.imageView;
    
}




- (void)saveImage
{
  
    
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
//    label.layer.cornerRadius = 5;
//    label.clipsToBounds = YES;
//    label.bounds = CGRectMake(0, 0, 150, 30);
//    label.center = self.center;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont boldSystemFontOfSize:17];
//    [[UIApplication sharedApplication].keyWindow addSubview:label];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
//        label.text = @"图片保存失败";
        [MBProgressHUD show:Localized(@"图片保存失败") icon:nil view:nil Delay:1.f];
        
    }   else {
            [MBProgressHUD show:Localized(@"图片保存成功") icon:nil view:nil Delay:1.f];
     
    }
//    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}




@end
