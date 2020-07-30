//
//  SYNearView.h
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYNearViewDelegate <NSObject>

- (void)nearViewClickButton:(UIButton *)btn;

@end

@interface SYNearView : UIView
@property (weak, nonatomic) IBOutlet UIButton *nearBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *releaseTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *doorTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *releaseTimeImgView;
@property (weak, nonatomic) IBOutlet UIImageView *doorImgView;
@property (weak, nonatomic) IBOutlet UIImageView *distanceImgView;
@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,weak) id<SYNearViewDelegate> delegate;


@end
