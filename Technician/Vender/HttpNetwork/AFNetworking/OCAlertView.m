//
//  OCAlertView.m
//  H400
//
//  Created by wangzhen on 14-6-30.
//  Copyright (c) 2014年 王振. All rights reserved.
//

#import "OCAlertView.h"
#define kAlertWidth 265.0f
#define kAlertHeight 140.0f

#define kTitleYOffset 15.0f
#define kTitleHeight 20.0f
@implementation OCAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

UIImage*imageWithColor(UIColor *color, CGSize size)
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
     TimeLabelTitle:(NSString *)timeTitle
{
    if (self = [super init])
    {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.alerttitTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAlertWidth, kTitleHeight)];
        self.alerttitTopLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        self.alerttitTopLabel.textColor = [UIColor grayColor];
        [self addSubview:self.alerttitTopLabel];
        
        
        self.alertTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kTitleYOffset+10, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        self.alertTitleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,kTitleHeight+kTitleYOffset+10, contentLabelWidth, kTitleHeight+5)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor blackColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.alertContentLabel];
        if (timeTitle)
        {
            self.alertTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, kTitleHeight*2+kTitleYOffset+15, contentLabelWidth, kTitleHeight)];
            self.alertTimeLabel.textColor = [UIColor blackColor];
            self.alertTimeLabel.font = [UIFont systemFontOfSize:15.0f];
            [self addSubview:self.alertTimeLabel];
        }else
        {
            self.alertContentLabel.frame = CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,kTitleHeight+kTitleYOffset+10, contentLabelWidth, 40+5);
        }
        

        
        self.alertContentLabel.textAlignment =
        self.alertTitleLabel.textAlignment   =
        self.alerttitTopLabel.textAlignment  =
        self.alertTimeLabel.textAlignment    = NSTextAlignmentCenter;
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
        if (!leftTitle) {
            rightBtnFrame = CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight, kAlertWidth, kButtonHeight+kButtonBottomOffset);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (IOS7) {
                self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            }
            self.rightBtn.frame = rightBtnFrame;
            
        }else {
            leftBtnFrame = CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight, kAlertWidth/2, kButtonHeight+kButtonBottomOffset);
            rightBtnFrame = CGRectMake(kAlertWidth/2, kAlertHeight - kButtonBottomOffset - kButtonHeight, kAlertWidth/2, kButtonHeight+kButtonBottomOffset);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (IOS7) {
                self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            }
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
            UIImageView *lineImages = [[UIImageView alloc]initWithImage:imageWithColor([UIColor grayColor],CGSizeMake(1.0f, kButtonHeight+kButtonBottomOffset))];
            lineImages.frame = CGRectMake(kAlertWidth/2, kAlertHeight - kButtonBottomOffset - kButtonHeight, 1.0f, kButtonHeight+kButtonBottomOffset);
            [self addSubview:lineImages];
        }
        
        UIImageView *lineImage = [[UIImageView alloc]initWithImage:imageWithColor([UIColor grayColor],CGSizeMake(kAlertWidth, 1.0f))];
        lineImage.frame = CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight, kAlertWidth, 1);
        lineImage.alpha = 0.4;
        [self addSubview:lineImage];
        
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
//        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        if (!IOS7) {
            [self.leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        }

        
       
        
//        [self.leftBtn setBackgroundImage:generateImagesBasedOnColorValuesAndAlpha([UIColor whiteColor],self.leftBtn.frame.size) forState:UIControlStateHighlighted];
//        [self.rightBtn setBackgroundImage:generateImagesBasedOnColorValuesAndAlpha([UIColor whiteColor],self.rightBtn.frame.size) forState:UIControlStateHighlighted];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        

        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        self.alertTimeLabel.text = timeTitle;
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}
- (void)show
{
    
    self.alerttitTopLabel.text = @"sayes";
    
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}
- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
    
    self.frame = afterFrame;

    
    [UIView animateWithDuration:0.17 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.12 animations:^{
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];

    
    [super removeFromSuperview];
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    self.frame = afterFrame;

    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.17 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.12 animations:^{
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        } completion:^(BOOL finished) {

            self.layer.transform = CATransform3DIdentity;
        }];
    }];
    
    [super willMoveToSuperview:newSuperview];
    
}
@end
