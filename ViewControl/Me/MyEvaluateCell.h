//
//  MyEvaluateCell.h
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEvaluateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fourthStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImgView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
