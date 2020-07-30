//
//  JYSmileImagesPickerView.m
//  Printer
//
//  Created by Jim on 16/8/15.
//  Copyright © 2016年 √Å√†¬±√ã√Ö√∂√Ç√ß‚àû. All rights reserved.
//

#import "JYSmileImagesPickerView.h"
#import "JYSmileImagePickerCell.h"
#import "PhotoManager.h"
//#import "UIImageView+JYNetwork.h"

#import "UIView+JMUIViewController.h"

@interface JYSmileImagesPickerView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PhotoManagerDelegate,SmileImagePickerCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;

@end

@implementation JYSmileImagesPickerView

static NSString *cellId = @"JYSmileImagePickerCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.myCollection.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((KscreenWidth - 50) / 3 , self.myCollection.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.myCollection.collectionViewLayout = layout;
    self.myCollection.scrollsToTop = NO;
    self.myCollection.showsVerticalScrollIndicator = NO;
    self.myCollection.showsHorizontalScrollIndicator = NO;
    
    [self.myCollection registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    _images = [[NSMutableArray alloc] initWithCapacity:0];
    _imagesAndKey = [[NSMutableArray alloc] initWithCapacity:0];
}

//- (void)setImages:(NSMutableArray *)images {
//    _images = images;
//    [self.myCollection reloadData];
//}

- (void)setImagesData:(NSArray *)images {
    [self.images addObjectsFromArray:images];
//    [self updatePickerViewHeight];
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:[NSString stringWithFormat:@"%ld",self.tag - 100]  forKey:@"indexOfRow"];
    [mutDic setObject:images forKey:@"images"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUnionImagesSeletes object:mutDic];
    
    [self.myCollection reloadData];
}

- (void)setImageKeys:(NSArray *)imageKeys {
    [self.imagesAndKey addObjectsFromArray:imageKeys];
}

//- (void)updatePickerViewHeight {
//    NSInteger lines = 0;
//    if (self.images.count < self.total) {
//        lines = (self.images.count + 3)/3;
//    } else {
//        lines = (self.images.count + 2)/3;
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(updateHeight:)]) {
//        [self.delegate updateHeight:lines * (KscreenWidth /3.0 -12)];
//    }
//}

#pragma mark - SmileImagePickerCellDelegate
- (void)deleteImageAtCell:(UICollectionViewCell *)cell {
    WeakSelf;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:Localized(@"提示") message:Localized(@"确认删除该图片？") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:Localized(@"确认") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = [weakself.myCollection indexPathForCell:cell];
        if (indexPath) {
            [weakself.images removeObjectAtIndex:indexPath.item];      //移除图片或者url
            [weakself.imagesAndKey removeObjectAtIndex:indexPath.item];// 图片或者key
            if (weakself.images.count == 2) {
//                [weakself updatePickerViewHeight];
            }
            [weakself .myCollection reloadData];
        }
    }];
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:Localized(@"取消") style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:doneAction];
    [actionSheet addAction:cancelAction];
    [self.superController presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - images action
- (void)addImageAction {
    WeakSelf;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *caremaAction = [UIAlertAction actionWithTitle:Localized(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openCamera];
    }];
    
    UIAlertAction *albumAction  = [UIAlertAction actionWithTitle:Localized(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openPhoto];
    }];
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:Localized(@"取消") style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:caremaAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    [self.superController presentViewController:actionSheet animated:YES completion:nil];
}

- (void)openPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self.superController presentViewController:picker animated:YES completion:nil];
    
//    PhotoManager* photoManager=[PhotoManager new];
//    photoManager.cameraStyle = CameraPickerSystemPhotoNeedClip;
//    photoManager.maxImageNum = self.total - self.images.count;
//    photoManager.controller = self.superController;
//    photoManager.delegate = self;
//    [photoManager enter];
}

- (void)openCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self.superController presentViewController:picker animated:YES completion:nil];
//    PhotoManager* photoManager = [PhotoManager new];
//    photoManager.cameraStyle = CameraPickerSystemCarmeraNeedClip;
//    photoManager.controller  = self.superController;
//    photoManager.delegate    = self;
//    [photoManager enter];
}

#pragma mark == PhotoManager Delegate
/**< 拍照图片 */
- (void)didChooseImageByCameraWithAsset:(ALAsset *)asset{
    self.isEditedImage = YES;
    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    WeakSelf;
    
    [weakself.imagesAndKey addObject:image];
    [weakself setImagesData:@[image]];

}

/**< 相册图片 */
-(void)didChooseImageAssets:(NSArray *)assets{
    self.isEditedImage = YES;
    WeakSelf;
 
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < assets.count; i++) {
            ALAsset *asset = assets[i];
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [array addObject:image];
        }
        [weakself.imagesAndKey addObjectsFromArray:array];
        [weakself setImagesData:array];
    
}

#pragma mark - image picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imagesAndKey addObject:image];
    [self setImagesData:@[image]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.images.count < self.total) {
        return self.images.count + 1;
    }
    else {
        return self.images.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYSmileImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    id img = nil;
    if (indexPath.item < self.images.count) {
        img = [self.images objectAtIndex:indexPath.item];
        cell.myImageViewWidth.constant = cell.frame.size.width - 10;
        cell.deleteButton.hidden = NO;
        cell.uploadTitleLabel.hidden = YES;
    } else {
        img = PNGIMAGE(@"send_image");
        cell.myImageViewWidth.constant = cell.frame.size.width / 3;
        cell.deleteButton.hidden = YES;
        cell.uploadTitleLabel.hidden = NO;
    }

    //图片 和  url
    if ([img isKindOfClass:[UIImage class]]) {
        cell.myImageView.image = img;
    } else if ([img isKindOfClass:[NSString class]]) {
        cell.myImageViewWidth.constant = cell.frame.size.width;
//        [cell.myImageView setImageURL:img placeholderImage:placeh_image];
    }
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.images.count < self.total && indexPath.item == self.images.count) {
        [self addImageAction];
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(KscreenWidth /3.0 - 8, KscreenWidth /3.0 - 12);
//}

@end
