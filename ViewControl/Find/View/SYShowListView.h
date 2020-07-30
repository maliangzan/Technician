//
//  SYShowListView.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYListContenView.h"

@protocol SYShowListViewDelegate <NSObject>

- (void)clikEmptyAndRemoveSubView;

@end

@interface SYShowListView : UIView
@property (nonatomic,weak) id<SYShowListViewDelegate> delegate;

- (void)show;
@end
