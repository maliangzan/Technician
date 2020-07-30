//
//  TextViewCell.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.valueTextView.layer.cornerRadius = 3;
    self.valueTextView.layer.masksToBounds = YES;
    self.valueTextView.layer.borderWidth = 1;
    self.valueTextView.layer.borderColor = kAppColorBackground.CGColor;
    
    self.valueTextView.delegate = self;
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length) {
        self.placeHolderLabel.hidden = YES;
    }else{
        self.placeHolderLabel.hidden = NO;
    }
}

@end
