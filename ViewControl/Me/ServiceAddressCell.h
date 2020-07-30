//
//  ServiceAddressCell.h
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServiceAddressCell;
@protocol ServiceAddressCellDelegate <NSObject>

- (void)contactUserAtCell:(ServiceAddressCell *)cell;
- (void)locationTheAddressAtCell:(ServiceAddressCell *)cell;

@end

@interface ServiceAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *callPhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,weak) id<ServiceAddressCellDelegate> delegate;

- (void)configServiceAddressCellWithDictionary:(NSDictionary *)dic;
@end
