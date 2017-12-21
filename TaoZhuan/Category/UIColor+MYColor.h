//
//  UIColor+MYColor.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MYColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//UIColor 转UIImage
+ (UIImage*) imageWithColor: (UIColor*) color;

+ (UIImage*) imageWithColor: (UIColor*) color andSize:(CGSize)size;

@end
