//
//  JYSmileImagePickerCell.m
//  Printer
//
//  Created by Jim on 16/8/15.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import "JYSmileImagePickerCell.h"

@implementation JYSmileImagePickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self bringSubviewToFront:self.deleteButton];
    
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (IBAction)deleteImageAction:(UIButton *)sender {
    [self.delegate deleteImageAtCell:self];
}

@end
