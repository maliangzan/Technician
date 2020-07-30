//
//  MyEvaluateSubHeadView.h
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEvaluateSubHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *leftPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *satisfactionPercentLabel;

@end
