//
//  JJVerticalButton.m
//  refresh
//
//  Created by myjawdrops on 16/11/29.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import "MYVerticalButton.h"

@implementation MYVerticalButton

+ (instancetype)verticalButtonWithFrame:(CGRect)frame{
    
    MYVerticalButton *button = [[MYVerticalButton alloc] initWithFrame:frame];
    button.frame = frame;
    button.imageHeightRatio = 0.7;
    
    return button;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //使图片和文字水平居中显示
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.frame.size.height * self.imageHeightRatio,-self.width + 5, 2.0, -7)];
    //图片距离右边框距离减少label的宽度，其它不边
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -5, self.height *(1- self.imageHeightRatio), -self.width)];
}

- (void)setImageHeightRatio:(CGFloat)imageHeightRatio{

    _imageHeightRatio = imageHeightRatio;
    [self layoutSubviews];
}




@end
