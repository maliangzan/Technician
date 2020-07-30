//
//  SYNotificationName.h
//  源健康
//
//  Created by TianQian on 2017/3/23.
//  Copyright © 2017年 是源科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYNotificationName : NSObject

extern NSString *const kNotificationLoginSuccess;//登录成功

extern NSString *const kNotificationLoginOut;//退出登录

extern NSString *const kNotificationHomeViewControllerLoadData;//登录成功，首页获取数据

extern NSString *const kNotificationSYItemSheetSelectedService;//选中服务项目

extern NSString *const kNotificationSYItemSheetCancelSelectedService;//取消选中服务项目

extern NSString *const kNotificationSetOrderViewControllerClickServiceType;//我的订单排序方式
extern NSString *const kNotificationSetOrderViewControllerClickServiceTime;//我的订单排序方式

extern NSString *const kNotificationOrderListBaseViewControllerRefresh;//我的订单刷新

extern NSString *const kNotificationSearchAddressAction;//搜索地址

extern NSString *const kNotificationSYServiceAddressMapViewControllerSelectedAddressAction;//确定选择地址

extern NSString *const kNotificationSYAddDeviceViewControllerAddDeviceSuccess;//添加设备成功

extern NSString *const kNotificationBaseUserInfoViewControllerRefresh;//BaseUserInfoViewController刷新

extern NSString *const kNotificationUnionImagesSeletes;//加盟图片选择

extern NSString *const kNotificationUnionImagesUploadSuccess;//加盟图片上传成功

extern NSString *const kNotificationUnionInfomationUploadSuccess;//加盟个人资料上传成功

extern NSString *const kNotificationUpdateLocations;//用户位置更新

extern NSString *const kNotificationSearchLocations;//搜索到位置

extern NSString *const kNotificationServiceTimeViewControllerEndTimeSuccess;//结束服务成功

extern NSString *const kNotificationWalletViewControllerRefresh;//提现成功，刷新对账单

extern NSString *const kNotificationChangeOrderState;//修改订单状态

extern NSString *const kNotificationOrdersViewControllerRefresh;//OrdersViewController刷新

extern NSString *const kNotificationApplicationDidBecomeActive;//applicationDidBecomeActive

@end
