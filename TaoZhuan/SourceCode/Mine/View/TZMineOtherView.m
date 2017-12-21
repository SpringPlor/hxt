//
//  TZMineOtherView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineOtherView.h"

@implementation TZMineOtherView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"其他" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(17);
        }];
        
        UIView *line1View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line1View];
        [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(42);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line2View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line2View];
        [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(97);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line3View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line3View];
        [line3View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(36);
            make.top.equalTo(line1View.mas_bottom).offset(9);
        }];
        
        UIView *line4View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line4View];
        [line4View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(36);
            make.top.equalTo(line2View.mas_bottom).offset(9);
        }];
        
        UIView *line5View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line5View];
        [line5View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(97+55);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line6View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line6View];
        [line6View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(36);
            make.top.equalTo(line5View.mas_bottom).offset(9);
        }];
        
        UIView *line7View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:line7View];
        [line7View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(97+55+55);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
//        UIView *line8View = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
//        [self addSubview:line8View];
//        [line8View mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.width.mas_equalTo(0.5);
//            make.height.mas_equalTo(36);
//            make.top.equalTo(line7View.mas_bottom).offset(9);
//        }];

        
        CGFloat itemWidth = SCREEN_WIDTH/2;
        NSArray *iconArray = @[@"淘友icon",@"taobao",@"gouwuche",@"dingdanbulu",@"yijianfankui",@"kefu",@"shezhi"];
        NSArray *itemArray = @[@"我的淘友",@"淘宝账号授权",@"购物车",@"订单补录",@"意见反馈",@"客服与帮助",@"设置"];
        for (int i = 0; i < iconArray.count; i++){
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
            [self addSubview:itemButton];
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(itemWidth*(i%2));
                make.top.equalTo(line1View).offset(55*(i/2));
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(55);
            }];
            itemButton.tag = i;
            [itemButton addTarget:self action:@selector(tapBlock:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *itemImage = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:iconArray[i]]];
            [itemButton addSubview:itemImage];
            [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemButton);
                make.left.equalTo(itemButton).offset(25);
                make.width.height.mas_equalTo(25);
            }];
            
            UILabel *itemLabel = [MYBaseView labelWithFrame:CGRectZero text:itemArray[i] textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
            [itemButton addSubview:itemLabel];
            [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemButton);
                make.left.equalTo(itemImage.mas_right).offset(11);
            }];
        }
    }
    return self;
}

- (void)tapBlock:(UIButton *)sender{
    if (self.tapBlock) {
        self.tapBlock(sender.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
