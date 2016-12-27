//
//  OCProject.h
//  Technician
//
//  Created by 马良赞 on 16/12/27.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCProject : NSObject
//将16进制颜色转换成UIColor
UIColor * getColor(NSString *hexColor);
@end
