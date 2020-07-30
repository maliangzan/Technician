//
//  SYUploadImageHelper.h
//  Technician
//
//  Created by TianQian on 2017/6/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^progress)(NSProgress *progress);
typedef void(^success)(id responseObject);
typedef void(^failure)(NSError *error);

@interface SYUploadImageHelper : NSObject
@property (nonatomic,strong) AFHTTPSessionManager *manager;

+ (SYUploadImageHelper *)shared;

- (void)uploadImage:(UIImage *)image withURLString:(NSString *)urlStr parameters:(NSDictionary *)params imageKey:(NSString *)imgKey progress:(progress)progress success:(success)success failure:(failure)failure;//单图上传

- (void)uploadImages:(NSArray *)imageDatas withURLString:(NSString *)urlStr parameters:(NSDictionary *)params imageKey:(NSArray *)imgKeys progress:(progress)progress success:(success)success failure:(failure)failure;//多图上传

@end
