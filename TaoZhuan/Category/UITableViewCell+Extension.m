//
//  UITableViewCell+Extension.m
//  DolphinCommunity
//
//  Created by Tony on 3/30/16.
//  Copyright © 2016 Chen Jianye. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

- (void)setSeperatorInsetToZero {
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)setSeperatorInsetToZero:(CGFloat)left {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset = UIEdgeInsetsMake(0, left, 0, 0);
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins = UIEdgeInsetsMake(0, left, 0, 0);
    }
}

@end
