//
//  SYUploadImageHelper.m
//  Technician
//
//  Created by TianQian on 2017/6/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUploadImageHelper.h"

@implementation SYUploadImageHelper

+ (SYUploadImageHelper *)shared{
    static SYUploadImageHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[SYUploadImageHelper alloc] init];
    });
    return helper;
}

//单张图片上传
- (void)uploadImage:(UIImage *)image withURLString:(NSString *)urlStr parameters:(NSDictionary *)params imageKey:(NSString *)imgKey progress:(progress)progress success:(success)success failure:(failure)failure{
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    NSString *strName = nil;
    if (UIImagePNGRepresentation(image) == nil){
        imageData = UIImageJPEGRepresentation(image, 1);
        mimeType = @"image/jpeg";
        strName = @"shiyuan.jpg";
    }else{
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
        strName = @"shiyuan.png";
    }
    
    [self.manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:imgKey fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//多图上传
- (void)uploadImages:(NSArray *)imageDatas withURLString:(NSString *)urlStr parameters:(NSDictionary *)params imageKey:(NSArray *)imgKeys progress:(progress)progress success:(success)success failure:(failure)failure{

    [self.manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger imgCount = 0;
        
        for (NSData *imageData in imageDatas) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
            
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
            NSString *nameString = @"";
            if (imgCount < imgKeys.count) {
                nameString = imgKeys[imgCount];
            }
            [formData appendPartWithFileData:imageData name:nameString fileName:fileName mimeType:@"image/png"];
            
            imgCount++;
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置请求的超时时间
        _manager.requestSerializer.timeoutInterval = 30.f;
        //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return _manager;
}

@end
