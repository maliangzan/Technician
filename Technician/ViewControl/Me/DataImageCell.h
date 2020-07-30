//
//  DataImageCell.h
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSmileImagesPickerView.h"

@interface DataImageCell : UITableViewCell<SmileImagesPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) JYSmileImagesPickerView *pickerView;

@end
