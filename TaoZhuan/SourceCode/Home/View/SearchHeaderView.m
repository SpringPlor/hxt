//
//  SearchHeaderView.m
//  MaiYou
//
//  Created by bm on 2017/4/6.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "SearchHeaderView.h"

@implementation SearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5) backgroundColor:rGB_Color(240, 240, 240)];
        [self addSubview:self.lineView];
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.lineView).offset(20);
        }];
        
        self.iconButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"图层19"] selectImage:nil];
        [self addSubview:self.iconButton];
        [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.titleLabel);
            make.width.height.mas_equalTo(15);
        }];
        [self.iconButton addTarget:self action:@selector(deleteSearchCache) forControlEvents:UIControlEventTouchUpInside];
        self.iconButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -20);
    }
    return self;
}

- (void)deleteSearchCache{
    self.deleteBlock();
}

@end
