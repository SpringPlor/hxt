//
//  TZReturnJFExchangeHeadView.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFExchangeHeadView.h"

@implementation TZReturnJFExchangeHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"积分兑换banner"]];
        [self addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH-30);
            make.height.mas_equalTo(160*kScale);
        }];
        
        UILabel *infoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"全网话费充值  /  全国流量到家  /  各大网站会员" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.picImageView.mas_bottom).offset(15);
            make.centerX.equalTo(self);
        }];
        
        UIView *garyView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
        [self addSubview:garyView];
        [garyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(5);
        }];
    }
    return self;
}

@end
