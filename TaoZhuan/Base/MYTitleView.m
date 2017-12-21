//
//  MYTitleView.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/17.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYTitleView.h"

@implementation MYTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
