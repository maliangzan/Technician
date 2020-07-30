//
//  QBPreImageController.m
//  FunHotel
//
//  Created by Etre on 16/4/26.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import "QBPreImageController.h"
#import "QBScrollView.h"
//#import "UIImage+ResizeImage.h"

#import "QBAssetsCollectionCheckmarkView.h"
#import "UIImage+JMC.h"
#import "MBProgressHUD+MJ.h"

#define ratio [UIScreen mainScreen].bounds.size.width/375
#define  edge 9.0
@interface QBPreImageController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView*scrollView;



@property(nonatomic,strong)NSMutableArray*scrollViews;
@property(nonatomic,strong)NSMutableArray*views;

@property(nonatomic,assign)NSInteger scrollIndex;

@property(nonatomic,strong)UIPinchGestureRecognizer*pinch;

@property(nonatomic,assign)CGRect orignalFrame;

@property(nonatomic,strong)QBScrollView* nearScrollView;


@end

@implementation QBPreImageController
{
    UIButton*clearBtn;
    UIView*topSelectView;
    
    UIView*bottomView;
    UILabel*numLabel;
    QBAssetsCollectionCheckmarkView *checkmarkView;
}

-(void)loadView{
    [super loadView];
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    self.view .backgroundColor=[UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollViews=nil;

    //获得scrollview
    [self getScrollView];
    //        给image增加点击手势
//    [self getTapGestureRecognizer];
    
    [self showTopView];
    

    if (self.forSend) {
        [self showOverlayView];
        
    }else{
    [self hideOverlayView];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBarHidden=YES;
 [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden=NO;

     [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}


-(NSMutableArray*)scrollViews{
    if (!_scrollViews) {
        _scrollViews=[NSMutableArray array];
    }
    return _scrollViews;
}
-(NSMutableArray*)views{
    if (!_views) {
        _views=[NSMutableArray array];
    }
    return _views;
}


-(void)getScrollView{
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate=self;
    self.scrollView.bounces=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(self.assets.count>3?KscreenWidth*3:KscreenWidth*self.assets.count, KscreenHeight);
    
    CGRect frame=self.view.bounds;
    NSInteger num=self.assets.count;
    for (NSInteger i=0; i<3&&i<num; i++) {
        QBScrollView*myScrollView=[[QBScrollView alloc]initWithFrame:CGRectMake(frame.origin.x, 0, KscreenWidth, KscreenHeight) andImage:[[UIImage imageWithCGImage:[_assets[i] thumbnail]] transformOrientationUp]];
        
   
        frame.origin.x+=frame.size.width;
        [self.scrollView addSubview:myScrollView];
        
        [self.scrollViews addObject: myScrollView];
        
    }
    
    
    if (self.assets.count<=3) {
        self.scrollView.contentOffset=CGPointMake(KscreenWidth*self.index, 0);
        return;
    }
    
    self.scrollIndex=self.index;
    if (self.index>self.assets.count-2) {
        
         [self layoutScrollView:self.index currentScrollViewIndex:2 andIsFirst:YES];
    }else if(self.index<=0){
         [self layoutScrollView:self.index currentScrollViewIndex:0 andIsFirst:YES];
    }else{
        
        [self layoutScrollView:self.index currentScrollViewIndex:1 andIsFirst:YES];
    }

//    self.nearScrollView=self.scrollViews[self.index];
}



-(void)layoutScrollView:(NSInteger) currentImageIndex currentScrollViewIndex:(NSInteger)scrollIndex andIsFirst:(BOOL)isFirst{

    
    if (self.assets.count<=3) {
        return;
    }
    


    self.scrollView.contentOffset=CGPointMake(KscreenWidth, 0);
    switch (scrollIndex) {
        case 0:
        {
             QBScrollView *currentScrollView=self.scrollViews[0];
            CGRect rect= currentScrollView.frame;
            if (isFirst) {
                currentScrollView.asset=self.assets[currentImageIndex+1];
            }
            rect.origin.x=KscreenWidth;
            currentScrollView.frame=rect;
            
            currentScrollView=self.scrollViews[1];
         rect= currentScrollView.frame;
            rect.origin.x=0;
            currentScrollView.frame=rect;
            if (currentImageIndex>0) {
              currentScrollView.asset=self.assets[currentImageIndex-1];
            }
            
            if (isFirst) {
                currentScrollView.asset=self.assets[currentImageIndex];
            }
           
            
            currentScrollView=self.scrollViews[2];
            rect= currentScrollView.frame;
            rect.origin.x=2*KscreenWidth;
            currentScrollView.frame=rect;
            currentScrollView.asset=self.assets[currentImageIndex+1];
            if (isFirst) {
                self.scrollIndex++;
                currentScrollView.asset=self.assets[currentImageIndex+2];
                self.scrollView.contentOffset=CGPointMake(0, 0);
            }
            
             [self.scrollViews exchangeObjectAtIndex:0 withObjectAtIndex:1];
            
        }
            break;
     case 1:   {
         
         

         QBScrollView *currentScrollView1=self.scrollViews[1];
         CGRect rect= currentScrollView1.frame;
         rect.origin.x=KscreenWidth;
         currentScrollView1.frame=rect;
          QBScrollView *currentScrollView2=self.scrollViews[2];
         rect= currentScrollView2.frame;
         rect.origin.x=2*KscreenWidth;
         currentScrollView2.frame=rect;
         
    
        QBScrollView *currentScrollView3=self.scrollViews[0];
         rect= currentScrollView3.frame;
         rect.origin.x=0;
         currentScrollView3.frame=rect;
         
        currentScrollView1.asset=self.assets[currentImageIndex];
         
         
         if (currentImageIndex<self.assets.count-1) {
             currentScrollView2.asset=self.assets[currentImageIndex+1];
         }else{
         
             self.scrollView.contentOffset=CGPointMake(KscreenWidth*2, 0);
         }
         
         if (currentImageIndex>0) {
             currentScrollView3.asset=self.assets[currentImageIndex-1];
         }else{
             self.scrollView.contentOffset=CGPointMake(0, 0);
         }
        }
            break;
            case 2:
        {
            QBScrollView *currentScrollView=self.scrollViews[2];
            if (isFirst) {
                currentScrollView.asset=self.assets[currentImageIndex-1];
            }
            
            CGRect rect= currentScrollView.frame;
            rect.origin.x=KscreenWidth;
            currentScrollView.frame=rect;
            
            
            currentScrollView=self.scrollViews[0];
            rect= currentScrollView.frame;
            rect.origin.x=0;
            currentScrollView.frame=rect;
            currentScrollView.asset=self.assets[currentImageIndex-1];
            if (isFirst) {
                currentScrollView.asset=self.assets[currentImageIndex-2];
            }
            
            currentScrollView=self.scrollViews[1];
            rect= currentScrollView.frame;
            rect.origin.x=2*KscreenWidth;
            currentScrollView.frame=rect;
            if (currentImageIndex<self.assets.count-1) {
                currentScrollView.asset=self.assets[currentImageIndex+1];
            }
            
            if (isFirst) {
                self.scrollIndex--;
                currentScrollView.asset=self.assets[currentImageIndex];
                self.scrollView.contentOffset=CGPointMake(KscreenWidth*2, 0);
            }
            
            
            
            [self.scrollViews exchangeObjectAtIndex:2 withObjectAtIndex:1];
        }
            
        default:
            break;
    }
    
   
}


////获得点击退出手势
-(void)getTapGestureRecognizer{
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClicked:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tap];

    
}

-(void)imageViewClicked:(UIImageView*)imageView{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [self hidenNav];
    
  

}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    for (QBScrollView*scrollView in self.scrollViews) {
        scrollView.transform=CGAffineTransformIdentity;
        scrollView.contentSize=CGSizeMake(KscreenWidth, KscreenHeight);
        [scrollView recover];
    }
   
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point=scrollView.contentOffset;
      NSInteger currentImageIndex=0;
    if (self.assets.count<=3) {
        
      
        if (point.x==0) {
            currentImageIndex=0;
            
        }
        
        if (point.x==KscreenWidth) {
            currentImageIndex=1;
            
        }
        if (point.x==KscreenWidth*2) {
            currentImageIndex=2;
        }
        self.index=currentImageIndex;
       
    }else{
    
    
    if (point.x==KscreenWidth*2) {
        if (self.index<=self.assets.count-2) {
               self.index++;
        }
     
       
        if (self.scrollIndex>=self.assets.count-2) {
            
        }else{
            
            self.scrollIndex++;
           
           
            [self layoutScrollView:self.scrollIndex currentScrollViewIndex:2 andIsFirst:NO];
        }
       
    }else if (point.x==0) {
 
        if (self.index>0) {
               self.index--;
        }
       
        
        
      
        
        if (self.scrollIndex<=1) {
            
        }else{
            self.scrollIndex--;
           
            [self layoutScrollView:self.scrollIndex currentScrollViewIndex:0 andIsFirst:NO];
        }
        
    }else if(point.x==KscreenWidth){
        
        if (self.index==self.assets.count-1) {
            self.index--;
        }else if(self.index==0){
            self.index++;
        }
        
        
    }
        
        currentImageIndex=self.index;
//        currentImageIndex=self.scrollIndex;
        
    }
    
    //NSLog(@"--%d---",currentImageIndex);
    
    
    
    BOOL hasFound=NO;
    for (NSURL*asset in self.selectedAssetURLs) {
       
        NSURL *currentUrl = [self.assets[currentImageIndex] valueForProperty:ALAssetPropertyAssetURL];
        if ([asset.absoluteString isEqualToString:currentUrl.absoluteString]) {
            [self showOverlayView];
            hasFound=YES;
            break;
        }
        
    }
    
    if (!hasFound) {
        
        [self hideOverlayView];
    }
    clearBtn.selected=hasFound;
  
    

}






-(void)showTopView{
    
  
        topSelectView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
        [self.view addSubview:topSelectView];
//        topSelectView.backgroundColor=hexStringToColor(@"646464");
    topSelectView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        topSelectView.userInteractionEnabled=YES;
    
        UIButton*navBtn=[[UIButton alloc]initWithFrame:CGRectMake(edge, edge+20, 24.0, 24.0)];
        [navBtn setBackgroundImage:[UIImage imageNamed:@"btn_BackArrow"] forState:UIControlStateNormal];
        navBtn.userInteractionEnabled=NO;
        [topSelectView addSubview:navBtn];
    
    
        clearBtn=[[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth-80, 0, 80, 64)];
        [topSelectView addSubview:clearBtn];
        [clearBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        clearBtn.selected=self.forSend;
    
    
        UIButton*clearNavBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50.0, 64.0)];
    
        [clearNavBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [topSelectView addSubview:clearNavBtn];
        [clearNavBtn  addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [topSelectView addSubview:clearNavBtn];
    
    
    bottomView=[[UIView alloc ]initWithFrame:CGRectMake(0, KscreenHeight-40, KscreenWidth, 40)];
    bottomView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    [self.view addSubview:bottomView];
    
    
    CGFloat sendBtn_w=75.0;
    UIButton*sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth-sendBtn_w-20, (40-sendBtn_w)/2-5, 64, sendBtn_w)];
    if (self.isForChat) {
        [sendBtn setTitle:Localized(@"发送") forState:UIControlStateNormal];
    } else {
        [sendBtn setTitle:Localized(@"完成") forState:UIControlStateNormal];
    }
//    [sendBtn setTitleColor:[UIColor colorWithRed:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     39/255.0  green:130/255.0 blue:215/255.0 alpha:1.0] forState:UIControlStateNormal];
       [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    sendBtn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [bottomView addSubview:sendBtn];
    sendBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [sendBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 32 , 0, -10)];
    
    numLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 27.5, 22, 22)];
    [sendBtn addSubview:numLabel];
    numLabel.font=[UIFont systemFontOfSize:16];
    numLabel.backgroundColor=[UIColor colorWithRed: 39/255.0  green:130/255.0 blue:215/255.0 alpha:1.0];
    numLabel.textColor=[UIColor whiteColor];
    numLabel.layer.cornerRadius=numLabel.frame.size.width/2.0f;
    numLabel.layer.masksToBounds=YES;
    numLabel.textAlignment=NSTextAlignmentCenter;
    
    if (self.selectedAssetURLs.count>0) {
        numLabel.text=[NSString stringWithFormat:@"%ld",self.selectedAssetURLs.count];
    }else{
        numLabel.hidden=YES;
    }
    
    
    [sendBtn addTarget:self action:@selector(clickSend:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
  
}

-(void)hidenNav{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(didAfterHidden)];
    [UIView setAnimationDuration:2.3];
//    [view setAlpha:0.0f];
    [UIView commitAnimations];
//    UINavigationBar*navigationBar=self.navigationController.navigationBar;
//    CGRect frame=navigationBar.frame;
 CGRect frame=topSelectView.bounds;
    
     __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.35
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseInOut)
                     animations:^{
                         
                         if (topSelectView.frame.origin.y>10) {
                                                          topSelectView.frame =CGRectMake(0, -50, frame.size.width, frame.size.height) ;
                                                      }else{
                                                          topSelectView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height) ;
                                                      }
                                              } completion:^(BOOL finished){
                    
                     }];
}


- (void)showOverlayView
{
    [checkmarkView removeFromSuperview];
    checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - (edge+5 + 20.0),  edge+23 , 20.0,20.0)];
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
    checkmarkView = [[QBAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - (edge+5 + 20.0),  edge+23 , 20.0, 20.0)];
    checkmarkView.autoresizingMask = UIViewAutoresizingNone;
    checkmarkView.showNoSelect=YES;
    checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
    checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
    checkmarkView.layer.shadowOpacity = 0.6;
    checkmarkView.layer.shadowRadius = 2.0;
    checkmarkView.userInteractionEnabled=NO;
    [topSelectView addSubview:checkmarkView];
}

-(void)clickBtn{
  
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)clickSend:(UIButton*)clickSender{
    
    if (self.selectedAssetURLs.count<=0) {
           [self selectImage:clearBtn];
    }
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didClickSendImage" object:nil];
}

-(void)selectImage:(UIButton*)sender{
//    if (!self.selectedValid) {
     if (self.selectedAssetURLs.count>=self.maxNum&&!sender.selected) {
        [MBProgressHUD show:[NSString stringWithFormat:Localized(@"最多选择%ld张照片"),(long)self.maxNum] icon:nil view:nil];
        return;
    }

    sender.selected=!sender.selected;
    if (sender.selected) {
        [self showOverlayView];
    }else{
        [self hideOverlayView];
        
    }
    if (self.selectImageBlock) {
        self.selectImageBlock(!checkmarkView.showNoSelect,self.index);
    }
    
    if (self.selectedAssetURLs.count>0) {
        numLabel.hidden=NO;
        numLabel.text=[NSString stringWithFormat:@"%ld",self.selectedAssetURLs.count];
    }else{
        numLabel.hidden=YES;
    }
    
}


-(void)dealloc{
    
}
@end
