//
//  TZOrderCollectionView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZOrderCollectionView.h"

@implementation TZOrderCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
        [kWindow addSubview:self.bgView];
        self.bgView.alpha = 0.3;
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInput:)]];
        
        UIImageView *bgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"订单补录弹框"]];
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(285);
            make.height.mas_equalTo(290);
        }];
        bgImageView.userInteractionEnabled = YES;
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"金额≥¥9.9的订单可获得50积分" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [bgImageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImageView).offset(92);
            make.centerX.equalTo(bgImageView);
        }];
        
        UILabel *titleLabel2 = [MYBaseView labelWithFrame:CGRectZero text:@"金额<¥9.9的订单将随机获得积分" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [bgImageView addSubview:titleLabel2];
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
            make.centerX.equalTo(bgImageView);
        }];

        
        self.textField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFontSize:15 placeholder:@"请输入订单号" style:UITextBorderStyleRoundedRect];
        [bgImageView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel2.mas_bottom).offset(25);
            make.left.equalTo(bgImageView).offset(25);
            make.right.equalTo(bgImageView).offset(-15);
            make.height.mas_equalTo(30);
        }];
        
        self.submitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"确定" textColor:rGB_Color(220, 220, 220) textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
        [bgImageView addSubview:self.submitLabel];
        [self.submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textField.mas_bottom).offset(20);
            make.left.equalTo(bgImageView).offset(25);
            make.right.equalTo(bgImageView).offset(-15);
            make.height.mas_equalTo(40);
        }];
        self.submitLabel.userInteractionEnabled = NO;
        self.submitLabel.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
        self.submitLabel.layer.cornerRadius = 5;
        self.submitLabel.clipsToBounds = YES;
        [self.submitLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submit:)]];
        RAC(self.submitLabel,textColor) = [self.textField.rac_textSignal map:^id(NSString *orderNum) {
            return orderNum.length > 0 ? [UIColor whiteColor] : rGB_Color(220, 220, 220);
        }];
        RAC(self.submitLabel,userInteractionEnabled) = [self.textField.rac_textSignal map:^id(NSString *orderNum) {
            return orderNum.length > 0 ? @(YES) : @(NO);
        }];
    }
    return self;
}

- (void)cancelInput:(UITapGestureRecognizer *)sende{
    if (self.orderNumBlock) {
        self.orderNumBlock(nil);
    }
}

- (void)submit:(UITapGestureRecognizer *)sender{
    if (self.orderNumBlock) {
        self.orderNumBlock(self.textField.text);
    }
    NSLog(@".....");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
