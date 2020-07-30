//
//  JYRequestApi.h
//  Printer
//
//  Created by Dragon on 16/4/21.
//  Copyright © 2016年 是源医学. All rights reserved.
//

#import "YTKRequest.h"
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JYResponseStatus) {
    kJYResponseStatusSuccess,    //  业务成功
    kJYResponseStatusUnusual,    //  业务错误
    kJYResponseStatusFailure,    //  网络异常
};



@interface JYRequestApi : YTKRequest

//  默认是提示的
@property (nonatomic, assign) BOOL hiddenTips;
@property (nonatomic, copy) NSString *requestTips;

//  成功 or 失败
@property (nonatomic, copy) void(^receiverData)(JYRequestApi *response, id data);

//  业务错误处理，需要做特殊错误处理
@property (nonatomic, copy) void(^handleBusinessError)(JYRequestApi *response, NSInteger code);




/**
 *  开始请求数据
 *
 *  @param view     需要弹出提示、阻塞的试图
 */

- (void)jyRequest__ForView:(UIView *)view;
- (void)requestForPullTable:(UITableView *)table;

@end



@protocol JYRequestApiDelegate <NSObject>

/**
 *  数据回调
 *
 *  @param api  请求的 api
 *  @param data 返回的数据。错误返回 nil
 */
- (void)responseApi:(id)api successData:(id)data;

- (void)responseApi:(id)api businessErrorCode:(NSInteger)code;
@end
