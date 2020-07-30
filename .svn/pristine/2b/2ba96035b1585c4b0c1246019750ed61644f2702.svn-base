//
//  BrowserImageView.m
//  FunHotel
//
//  Created by Etre on 16/5/19.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import "BrowserImageView.h"
#import "UIImageView+WebCache.h"
#define SDPhotoBrowserShowImageAnimationDuration 0.4f
@implementation BrowserImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    UIImageView*imageView;
    
    CGRect _convertRect;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame: frame]) {
        self.alpha=0.0f;
        
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
      
        imageView.userInteractionEnabled=YES;
        self.contentSize=imageView.frame.size;
        imageView.hidden=YES;
        [self addSubview:imageView];
        
        [self getTapGestureRecognizer:self];
       
    }
    return self;
}

////获得点击退出手势
-(void)getTapGestureRecognizer:(UIView*)control{
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBack)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [control addGestureRecognizer:tap];
    
}


-(void)clickBack{

    CGRect targetTemp = _convertRect;
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = UIViewContentModeScaleAspectFit;
    tempView.clipsToBounds = YES;
    tempView.layer.cornerRadius=5;
    tempView.image = imageView.image;
    CGFloat h = (self.bounds.size.width / imageView.image.size.width) * imageView.image.size.height;
    
    if (!imageView.image) { // 防止 因imageview的image加载失败 导致 崩溃
        h = self.bounds.size.height;
    }
    
//       self.bounds=[UIApplication sharedApplication].keyWindow.bounds;
   
    tempView.frame=imageView.frame;
//    tempView.frame = CGRectMake(0, 0, self.bounds.size.width, h);
 
//    tempView.center = self.center;
    
    [self addSubview:tempView];
    
    imageView.hidden = YES;
    
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.frame = targetTemp;
          self.bounds=[UIApplication sharedApplication].keyWindow.bounds;
        tempView.layer.cornerRadius=tempView.frame.size.width/2;
  
        self.alpha = 0.1f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


-(void)pushAnimationWithConvertRect:(CGRect)convertRect andImage:(UIImage*)image  andImageUlr:(NSString*)urlStr{
      //    弹出一个新界面时可以用这个方法来让新界面，相对于整个屏幕的同一位置显示这个图片
//    CGRect rect = [sourceView convertRect:sourceView.frame toView:self];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = image;
    _convertRect=convertRect;
    
    [self addSubview:tempView];
    
    CGRect targetTemp =self.bounds;
    
    tempView.frame = convertRect;
    tempView.contentMode = UIViewContentModeScaleAspectFit;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image];
  
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.center = self.center;
        self.alpha=1.0f;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
    } completion:^(BOOL finished) {
    
        [tempView removeFromSuperview];
        imageView.hidden = NO;
    }];

}


//
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    //    写了这个方法就会滚动时恢复原来的大小,但不会回到原来位置
    //    [scrollView setZoomScale:scale animated:NO];
    
    
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = self.bounds.size.width/2 , ycenter = self.bounds.size.height/2;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ?
    scrollView.contentSize.width/2 : xcenter;
    //同上，此处修改y值
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?
    scrollView.contentSize.height/2 : ycenter;
    [imageView setCenter:CGPointMake(xcenter, ycenter)];
}

-(void)recover{
  imageView.transform=CGAffineTransformIdentity;
imageView.frame=CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    
    
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    
    return imageView;
    
}




@end
