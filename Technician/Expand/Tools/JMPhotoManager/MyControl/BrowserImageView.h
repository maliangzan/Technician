//
//  BrowserImageView.h
//  FunHotel
//
//  Created by Etre on 16/5/19.
//  Copyright © 2016年 FunHotel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserImageView : UIScrollView<UIScrollViewDelegate>
-(void)pushAnimationWithConvertRect:(CGRect)convertRect andImage:(UIImage*)image  andImageUlr:(NSString*)urlStr;
@end
