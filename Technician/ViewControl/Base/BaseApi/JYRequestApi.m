//
//  JYRequestApi.m
//  Printer
//
//  Created by Dragon on 16/4/21.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#import "JYRequestApi.h"
//#import "YTKBaseRequest+JYResponse.h"
#import "SYCommand.h"
#import "MJRefresh.h"

@interface JYRequestApi ()

//  发起请求的 controller
@property (nonatomic, weak) UIView *view;

@end

@implementation JYRequestApi

- (void)jyRequest__ForView:(UIView *)view {
    
    self.view = view;
    
    if ( ! _hiddenTips) {
        [view showHUDWithMessage:self.requestTips];
    }
    
    WeakSelf;
//    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *req) {
//        
//        JYRequestApi *request = (JYRequestApi *)req;
//        
//        if ( ! weakself.hiddenTips) {
//            [weakself.view hideHUD];
//        }
//        
//        if ([request isSuccess]) {
//            
//            if (weakself.receiverData) {
//                weakself.receiverData(request, request.responseJSONObject);
//            }
//            
//        } else if ([request isCommonErrorAndHandle]) {
//            //  全局错误
//            return ;
//        } else {
//            
//            if ( ! weakself.hiddenTips) {
//                [weakself.view showHUDForError:request.businessErrorMessage];
//            }
//
//            if (weakself.handleBusinessError) {
//                weakself.handleBusinessError(request, request.jyCode);
//            }
//        }
//        
//    } failure:^(YTKBaseRequest *request) {
//        
//        if ( ! weakself.hiddenTips) {
//            [weakself.view showHUDForError:request.requestErrorMessage];
//        }
//        
//        if (weakself.receiverData) {
//            weakself.receiverData(request, nil);
//        } else {
//            [weakself.view showHUDForInfo:lls(@"请使用 block receiverData")];
//        }
//    }];
}

@end
