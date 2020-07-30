//
//  OCAlertView.h
//  H400
//
//  Created by wangzhen on 14-6-30.
//  Copyright (c) 2014年 王振. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCAlertView : UIView
{
    BOOL _leftLeave;

}
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
     TimeLabelTitle:(NSString *)timeTitle;

- (void)show;
- (void)dismissAlert;
- (void)rightBtnClicked:(id)sender;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@property (nonatomic, strong) UILabel *alerttitTopLabel;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UILabel *alertTimeLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;


@end
