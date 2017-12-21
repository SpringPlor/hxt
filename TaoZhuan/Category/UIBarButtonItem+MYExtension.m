//
//  UIBarButtonItem+MYExtension.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "UIBarButtonItem+MYExtension.h"

@implementation UIBarButtonItem (MYExtension)

/**
 *  自定义创建UIBarButtonItem
 *
 *  @param target         对应的导航栏
 *  @param action         点击此UIBarButtonItem的action
 *  @param image          UIBarButtonItem背景图片
 *  @param hilightedImage UIBarButtonItem高亮背景图片
 *
 *  @return 返回自定的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hilightedImage:(NSString *)hilightedImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hilightedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}


@end
