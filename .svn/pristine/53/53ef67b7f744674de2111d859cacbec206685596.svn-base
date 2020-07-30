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
    
    [self gettingCurrentAppVersion];
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

- (void)gettingCurrentAppVersion{
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    //获取 Version  版本号
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];//currentVersion为当前工程项目版本号
    //获取 Build  构建版本号
    NSString *buildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    self.aboutUsBackView.versionLabel.text = [NSString stringWithFormat:@"V%@测试版本%@",currentVersion,buildVersion];
    
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
