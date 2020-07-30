//
//  UserSexCell.h
//  Technician
//
//  Created by TianQian on 2017/4/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserSexCellDelegate <NSObject>
- (void)selectSex:(BOOL)isMan;
@end

@interface UserSexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (nonatomic,weak) id<UserSexCellDelegate> delegate;

@end
