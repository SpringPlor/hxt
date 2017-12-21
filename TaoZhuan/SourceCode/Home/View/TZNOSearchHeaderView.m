//
//  TZNOSearchHeaderView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNOSearchHeaderView.h"

@implementation TZNOSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = rGB_Color(241, 242, 243);

        self.tjLabel = [MYBaseView labelWithFrame:CGRectZero text:@"猜您喜欢" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self addSubview:self.tjLabel];
        [self.tjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        self.leftImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"矩形44拷贝"]];
        [self addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tjLabel.mas_left).offset(-7);
            make.centerY.equalTo(self.tjLabel);
            make.width.mas_equalTo(105/2);
            make.height.mas_equalTo(2);
        }];
        
        self.rightImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"矩形44"]];
        [self addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tjLabel.mas_right).offset(7);
            make.centerY.equalTo(self.tjLabel);
            make.width.mas_equalTo(105/2);
            make.height.mas_equalTo(2);
        }];
    }
    return self;
}

@end

