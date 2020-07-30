//
//  AboutUsViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsBackView.h"

@interface AboutUsViewController ()
@property (nonatomic,strong) AboutUsBackView *aboutUsBackView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"关于我们";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };

    [self.view addSubview:self.aboutUsBackView];
}

#pragma mark 懒加载
- (AboutUsBackView *)aboutUsBackView{
    if (!_aboutUsBackView) {
        _aboutUsBackView = [[[NSBundle mainBundle] loadNibNamed:@"AboutUsBackView" owner:nil options:nil] objectAtIndex:0];
        _aboutUsBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
    }
    return _aboutUsBackView;
}

@end
