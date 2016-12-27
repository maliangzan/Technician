//
//  BaseViewController.m
//  smanos
//
//  Created by sven on 3/16/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+ColorImage.h"
#import "ProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setExclusiveTouchForButtons:self.view];
}

-(void)setExclusiveTouchForButtons:(UIView *)myView
{
    //just respond one click atcion at a time
    for (UIView * v in [myView subviews]) {
        if([v isKindOfClass:[UIButton class]])
            [((UIButton *)v) setExclusiveTouch:YES];
        else if ([v isKindOfClass:[UIView class]]){
            [self setExclusiveTouchForButtons:v];
        }
    }
}

- (void)buildUI
{
    // enable swipe action
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)hideNavBarBottomLine
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden=YES;
            }
        }
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 44)];
        imageView.image= [UIImage imageWithColor:[UIColor clearColor]];
        [self.navigationController.navigationBar addSubview:imageView];
        [self.navigationController.navigationBar sendSubviewToBack:imageView];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self resizeForIOS7];
    }
    return self;
}

#pragma mark - methods

- (void)resizeForIOS7{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
#endif
}

- (void)showWaitTips:(NSString *)tip
{
    self.view.userInteractionEnabled = NO;
    if (tip.length > 0) {
        [ProgressHUD show:tip hide:NO];
    }else{
        [ProgressHUD show:kWaitTips hide:NO];
    }
}
- (void)disMissWaitTips
{
    self.view.userInteractionEnabled = YES;
    [ProgressHUD dismiss];
}

@end
