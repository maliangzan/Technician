//
//  BackGroundViewController.m
//  smanos
//
//  Created by sven on 3/16/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import "BackGroundViewController.h"

@interface BackGroundViewController ()

@property (nonatomic , strong) UIImageView *backGroundImg;
@end

@implementation BackGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImageView *)backGroundImg{
    if (!_backGroundImg) {
        _backGroundImg = [[UIImageView alloc] init];
         [_backGroundImg setBackgroundColor:[UIColor colorWithRed:239/255.0 green:240/255.0 blue:241/255.0 alpha:1.0]];
        _backGroundImg.image = PNGIMAGE(@"Login_backGound");
        _backGroundImg.userInteractionEnabled = YES;
    }
    return _backGroundImg;
}
- (void)buildUI
{
    [super buildUI];
    
    [self.view addSubview:self.backGroundImg];
    [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.fd_prefersNavigationBarHidden = YES;
}

@end
