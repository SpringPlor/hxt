//
//  TZSearchHeaderView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchHeaderView.h"

@implementation TZSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat itemWidth = SCREEN_WIDTH/4;
        NSArray *titleArray = @[@"综合",@"优惠券",@"评分",@"销量"];
        for (int i = 0; i < 4 ; i++) {
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:titleArray[i] titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(14)];
            [self addSubview:itemButton];
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(itemWidth*i);
                make.top.equalTo(self);
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(40);
            }];
            [itemButton setTitleColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(tapAciton:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = 1220+i;
            
            UIImageView *arrowImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"矩形50拷贝"]];
            [self addSubview:arrowImageView];
            [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemButton);
                make.centerX.equalTo(itemButton.mas_centerX).offset(20);
                make.width.mas_equalTo(7);
                make.height.mas_equalTo(6);
            }];
            arrowImageView.tag = 1230+i;
            
            if (i == 0) {
                self.zhButton = itemButton;
                self.zhButton.selected = YES;
                arrowImageView.image = [UIImage imageNamed:@"矩形50"];
            }
            if (i == 1) {
                self.yhlButton = itemButton;
                [arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(itemButton.mas_centerX).offset(30);
                }];
            }
            if (i == 2) {
                self.xlButton = itemButton;
            }
            if (i == 3) {
                self.qhjButton = itemButton;
                [arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(itemButton.mas_centerX).offset(30);
                }];
            }
        }
        UIView *topLine = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) backgroundColor:rGB_Color(230, 230, 230)];
        [self addSubview:topLine];
        
        UIView *headLine = [MYBaseView viewWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5) backgroundColor:rGB_Color(230, 230, 230)];
        [self addSubview:headLine];
        
    }
    return self;
}

- (void)tapAciton:(UIButton *)sender{
    self.zhButton.selected = NO;
    self.yhlButton.selected = NO;
    self.xlButton.selected = NO;
    self.qhjButton.selected = NO;
    sender.selected = YES;
    for (int i = 0; i < 4; i++){
        UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:1230+i];
        arrowImageView.image = [UIImage imageNamed:@"矩形50拷贝"];
    }
    UIImageView *senderImageView = (UIImageView *)[self viewWithTag:sender.tag+10];
    senderImageView.image = [UIImage imageNamed:@"矩形50"];
    if (self.tapBlcok) {
        NSString *order;
        switch (sender.tag - 1220) {
            case 0:
                [MobClick event:zonghe];
                order = @"default";
                break;
            case 1:
                [MobClick event:liebiaoxiaoliang];
                order = @"cpnprice";
                break;
            case 2:
                order = @"pdtscore";
                break;
            case 3:
                order = @"pdtsell";
                break;
            default:
                break;
        }
        self.tapBlcok(order);
    }
}

- (void)resetHeader{
    self.zhButton.selected = YES;
    self.yhlButton.selected = NO;
    self.xlButton.selected = NO;
    self.qhjButton.selected = NO;
    for (int i = 0; i < 4; i++){
        UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:1230+i];
        arrowImageView.image = [UIImage imageNamed:@"矩形50拷贝"];
    }
    UIImageView *senderImageView = (UIImageView *)[self viewWithTag:1230];
    senderImageView.image = [UIImage imageNamed:@"矩形50"];
}

- (void)BannedClick:(BOOL)click{
    if (click) {
        self.yhlButton.enabled = NO;
        self.xlButton.enabled = NO;
        self.qhjButton.enabled = NO;
    }else{
        self.yhlButton.enabled = YES;
        self.xlButton.enabled = YES;
        self.qhjButton.enabled = YES;
    }
}

@end
