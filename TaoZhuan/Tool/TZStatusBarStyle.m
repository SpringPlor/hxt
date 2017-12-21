//
//  TZStatusBarStyle.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/10/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZStatusBarStyle.h"

@implementation TZStatusBarStyle

+ (void)setStatusBarColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
