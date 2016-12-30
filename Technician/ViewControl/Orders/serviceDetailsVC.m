//
//  serviceDetailsVC.m
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "serviceDetailsVC.h"

@interface serviceDetailsVC ()

@end

@implementation serviceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buildUI{
    [super buildUI];
    __block typeof(self) weakSelf = self;
    self.blackBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
