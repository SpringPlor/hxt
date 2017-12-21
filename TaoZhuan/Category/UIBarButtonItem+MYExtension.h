//
//  UIBarButtonItem+MYExtension.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MYExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hilightedImage:(NSString *)hilightedImage;

@end

