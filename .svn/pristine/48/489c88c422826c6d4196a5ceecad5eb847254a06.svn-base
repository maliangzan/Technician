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
    if (self.tag == 100) {
        self.idCardView.frame = CGRectMake(0, 0, KscreenWidth, 200);
        [self.bgView addSubview:self.idCardView];
    } else {
        self.pickerView.frame = CGRectMake(0, 0, KscreenWidth, 110);
        [self.bgView addSubview:self.pickerView];
    }
    
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
        _pickerView.frame = self.bgView.frame;
        _pickerView.delegate = self;
        _pickerView.total = 2;
        _pickerView.tag = self.tag;
    }
    return _pickerView;
}

- (IDCardView *)idCardView {
    if (_idCardView == nil) {
        
        _idCardView = [[[NSBundle mainBundle] loadNibNamed:@"IDCardView" owner:self options:nil] objectAtIndex:0];
        _idCardView.frame = self.bgView.frame;
//        _idCardView.delegate = self;
        _idCardView.tag = self.tag;
    }
    return _idCardView;
}

@end
