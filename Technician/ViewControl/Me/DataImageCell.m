//
//  DataImageCell.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "DataImageCell.h"

@implementation DataImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect{
    self.pickerView.frame = CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height);
    [self.bgView addSubview:self.pickerView];
}

#pragma mark Method


#pragma mark <UICollectionViewDelegate,UICollectionViewDataSource>

#pragma mark - SmileImagesPickerViewDelegate
- (void)updateHeight:(CGFloat)height {
    [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

#pragma mark 懒加载
- (JYSmileImagesPickerView *)pickerView {
    if (_pickerView == nil) {
        
        _pickerView = [[[NSBundle mainBundle] loadNibNamed:@"JYSmileImagesPickerView" owner:self options:nil] objectAtIndex:0];
        _pickerView.delegate = self;
        _pickerView.total = 6;
    }
    return _pickerView;
}

@end
