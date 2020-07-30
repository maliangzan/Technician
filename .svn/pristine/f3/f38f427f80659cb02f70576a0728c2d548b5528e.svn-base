//
//  IDCardView.m
//  Technician
//
//  Created by TianQian on 2017/7/25.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "IDCardView.h"
#import "SYChooseImageHelper.h"

@implementation IDCardView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.zhengImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.fanImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.personImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (IBAction)chooseIDCardZhengAction:(UIButton *)sender {
    [self choosePhotoWith:sender];
}
- (IBAction)chooseIDCardFanAction:(UIButton *)sender {
    [self choosePhotoWith:sender];
}
- (IBAction)chooseIDCardPersonAction:(UIButton *)sender {
    [self choosePhotoWith:sender];
}

- (void)choosePhotoWith:(UIButton *)btn{
    SYChooseImageHelper *imageHelper = [SYChooseImageHelper shared];
    imageHelper.allowsEditing = YES;
    WeakSelf;
    imageHelper.resultImage = ^(SYChooseImageHelper *helper, NSDictionary *imageInfo){
        
        if (imageInfo) {
            UIImage *image = helper.editedImage;
            if (image) {
                
                btn.hidden = YES;
                
                if (btn == weakself.zhengBtn) {
                    //身份证正面
                    [weakself configImageView:weakself.zhengImageView withImage:image];
                    weakself.zhengImageView.backgroundColor = [UIColor whiteColor];
                } else if (btn == weakself.fanBtn) {
                    //身份证反面
                    [weakself configImageView:weakself.fanImageView withImage:image];
                    weakself.fanImageView.backgroundColor = [UIColor whiteColor];
                }else if (btn == weakself.personBtn) {
                    //手持身份证
                    [weakself configImageView:weakself.personImageView withImage:image];
                    weakself.personImageView.backgroundColor = [UIColor whiteColor];
                }
            }
        }
        [helper close];
    };
    [imageHelper show];
}

- (void)configImageView:(UIImageView *)imageView withImage:(UIImage *)image{
    imageView.image = image;
    NSArray *images = [NSArray arrayWithObject:image];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:@"0"  forKey:@"indexOfRow"];
    [mutDic setObject:images forKey:@"images"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUnionImagesSeletes object:mutDic];
}

@end
