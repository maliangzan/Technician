//
//  SYCustomAlertView.h
//  Technician
//
//  Created by TianQian on 2017/5/23.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^complate)(NSInteger btnIndex);

@interface SYCustomAlertView : UIView

@property (nonatomic,copy) complate complateBlock;

- (instancetype)initWithTitle:(NSString *)titleString tips:(NSString *)tipsString cancelTitle:(NSString *)canclString sureTitle:(NSString *)sureTitle;

- (void)show;

@end
