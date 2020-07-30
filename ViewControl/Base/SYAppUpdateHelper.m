//
//  SYAppUpdateHelper.m
//  Technician
//
//  Created by TianQian on 2017/6/16.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYAppUpdateHelper.h"
#import <AFNetworking.h>

@implementation SYAppUpdateHelper
- (void)checkAndUpdate{
    [self upData];
}

/**提示更新*/ //在dict中的值为Apple ID，即是AppStore上的Apple ID
- (void)upData {
    //获取手机程序的版本号
    NSString *ver = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    //POST必须上传的字段
    NSDictionary *dict = @{@"id":@"Apple ID"};
    [mgr POST:@"https://itunes.apple.com/lookup" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *array = responseObject[@"results"];
        if (array.count != 0) {// 先判断返回的数据是否为空
            NSDictionary *dict = array[0];
            //判断版本  [dict[@"version"] floatValue] > [ver floatValue]
            if (dict[@"version"] > ver) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"更稳定、快速、多彩的功能和体验，立即点击升级！" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil] ;
                alert.delegate = self;
                alert.tag = 222;
                [alert show];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end
