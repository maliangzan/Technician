//
//  MyScrollView.m
//  Cube
//
//  Created by zpz on 15/10/20.
//  Copyright (c) 2015年 VP. All rights reserved.
//

#import "MyScrollView.h"
#import "QBAssetsCollectionCheckmarkView.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#define  edge 9.0
@interface MyScrollView()

@end

@implementation MyScrollView
{
    UIImageView*imageView;
    
    UIView*topSelectView;
    
    QBAssetsCollectionCheckmarkView *checkmarkView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andImageView:(UIImage *)image{
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
//        imageView.contentMode= UIViewContentModeScaleAspectFit;
        imageView.contentMode=UIViewContentModeScaleAspectFit;
//        CGFloat y=self.center.y;
//        imageView.center=CGPointMake(imageView.center.x, y);
        imageView.image=image;
        
        

        imageView.userInteractionEnabled=YES;
        self.contentSize=imageView.frame.size;
       
        self.imageView=imageView;
        [self addSubview:imageView];
        
        
        
       
    }
    return self;
}

-(void)setForSend:(BOOL)forSend{
 
    
    
    _forSend=forSend;
    
    topSelectView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
    [[UIApplication sharedApplication].keyWindow addSubview:topSelectView];
//    topSelectView.backgroundColor=hexStringToColor(@"646464");
    topSelectView.backgroundColor=[UIColor hexColor:0x646464];
    topSelectView.userInteractionEnabled=YES;
    
    UIButton*navBtn=[[UIButton alloc]initWithFrame:CGRectMake(edge, edge+20, 24.0, 24.0)];
    [navBtn setBackgroundImage:[UIImage imageNamed:@"btn_BackArrow"] forState:UIControlStateNormal];
    navBtn.userInteractionEnabled=NO;
    [topSelectView addSubview:navBtn];
    
    
    UIButton*clearBtn=[[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth-80, 0, 80, 64)];
    [topSelectView addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.selected=forSend;
    
    
    UIButton*clearNavBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50.0, 64.0)];

     [clearNavBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
     [topSelectView addSubview:clearNavBtn];
     [clearNavBtn  addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [topSelectView addSubview:clearNavBtn];
    
    
    if (forSend) {
        [self showOverlayView];
    }else{
        self.selectedValid=YES;
        [self hideOverlayView];
    }
    
}

-(void)clickBtn{
    if (self.selectBlock) {
        self.selectBlock(!checkmarkView.showNoSelect);
    }
    currentViewControllerFormView(self).navigationController.navigationBarHidden=NO;
//       [AppDelegate getInstance].hlNavigationController.navigationBarHidden=NO;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        topSelectView.center=CGPointMake(topSelectView.center.x+KscreenWidth, topSelectView.center.y);
       self.center=CGPointMake(self.center.x+KscreenWidth, self.center.y);
    } completion:^(BOOL finished) {
        [topSelectView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
    
    
    
  
}

-(void)selectImage:(UIButton*)sender{
//    if (!self.selectedValid) {
    if (!self.selectedValid) {

      [MBProgressHUD show:[NSString stringWithFormat:Localized(@"最多选择%ld张照片"),(long)self.maxNum] icon:nil view:nil];
        return;
    }
    sender.selected=!sender.selected;
    if (sender.selected) {
         [self showOverlayView];
    }else{
        [self hideOverlayView];
       
    }
}


-(void)setFullUrl:(NSString *)fullUrl{
    _fullUrl=fullUrl;
    if (!isNull(self.fullUrl)) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.fullUrl] placeholderImage:imageView.image];
    }
    
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
    [self.imageView setCenter:CGPointMake(xcenter, ycenter)];
}

-(void)recover{
     self.imageView.transform=CGAffineTransformIdentity;
    self.imageView.frame=CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);


}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{


        return self.imageView;

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSLog(@"asss");
//    if (topSelectView.tag) {
//       [self pushAnimation:topSelectView.center];
//    }else{
//        [self popAnimation:topSelectView.center];
//    }
    
}


- (void)showOverlayView
{
     [checkmarkView removeFromSuperview];
   checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (edge+5 + 20.0),  edge+23 , 20.0,20.0)];
    checkmarkView.autoresizingMask = UIViewAutoresizingNone;
    checkmarkView.showNoSelect=NO;
    checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
    checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
    checkmarkView.layer.shadowOpacity = 0.6;
    checkmarkView.layer.shadowRadius = 2.0;
    checkmarkView.userInteractionEnabled=NO;
    [topSelectView addSubview:checkmarkView];

}

- (void)hideOverlayView
{
    [checkmarkView removeFromSuperview];
    checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (edge+5 + 20.0),  edge+23 , 20.0, 20.0)];
    checkmarkView.autoresizingMask = UIViewAutoresizingNone;
    checkmarkView.showNoSelect=YES;
    checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
    checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
    checkmarkView.layer.shadowOpacity = 0.6;
    checkmarkView.layer.shadowRadius = 2.0;
     checkmarkView.userInteractionEnabled=NO;
    [topSelectView addSubview:checkmarkView];
}


-(void)pushAnimation:(CGPoint)center{
    topSelectView.tag=0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //DLog(@"center:%@",NSStringFromCGPoint(center));
    center.y=center.y+topSelectView.frame.size.height;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        topSelectView.center=center;
    }];
    
}


-(void)popAnimation:(CGPoint)center{
    topSelectView.tag=1;
    center.y=center.y-topSelectView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        topSelectView.center=center;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];
    
}
//
@end
