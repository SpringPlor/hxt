//
//  TZMinePartnerView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMinePartnerView.h"

@implementation TZMinePartnerView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title iconArray:(NSArray *)iconArray itemTitle:(NSArray *)itemArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.redView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"hongseyuanjiao"]];
        [self addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(17);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(16);
        }];
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:title textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.redView.mas_right).offset(8);
            make.centerY.equalTo(self.redView);
        }];
        
        self.numLabel = [MYBaseView labelWithFrame:CGRectZero text:title textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(5);
            make.centerY.equalTo(self.redView);
        }];
        
        self.arrowImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"youqiantou"]];
        [self addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self.redView);
            make.width.mas_equalTo(6);
            make.height.mas_equalTo(12);
        }];
        self.arrowImageView.hidden = YES;
        
        self.orderButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"查看全部订单" titleColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] font:kFont(13)];
        [self addSubview:self.orderButton];
        [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.redView);
            make.right.equalTo(self.arrowImageView.mas_left).offset(-4);
        }];
        self.orderButton.hidden = YES;
        [self.orderButton addTarget:self action:@selector(allOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(51);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *lineView2 = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
        [self addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(71);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(0.5);
        }];
        
        CGFloat itemWidth = (SCREEN_WIDTH-20)/iconArray.count;
        for (int i = 0; i < iconArray.count; i++){
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
            [self addSubview:itemButton];
            
            UIImageView *itemImage = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:iconArray[i]]];
            [itemButton addSubview:itemImage];
            
            if (i == 0) {
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(44*kScale);
                    make.right.equalTo(lineView2.mas_left);
                    make.top.equalTo(lineView);
                    make.height.mas_equalTo(87);
                }];
                
                [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(itemButton);
                    make.top.equalTo(itemButton).offset(20);
                    make.width.mas_equalTo(22);
                    make.height.mas_equalTo(25);
                }];

            }else{
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lineView2.mas_right);
                    make.right.equalTo(self).offset(-44*kScale);
                    make.top.equalTo(lineView);
                    make.height.mas_equalTo(87);
                }];
                
                [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(itemButton);
                    make.top.equalTo(itemButton).offset(20);
                    make.width.mas_equalTo(27);
                    make.height.mas_equalTo(22);
                }];

            }
            itemButton.tag = i;
            [itemButton addTarget:self action:@selector(tapBlock:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *itemLabel = [MYBaseView labelWithFrame:CGRectZero text:itemArray[i] textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
            [itemButton addSubview:itemLabel];
            [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(itemButton);
                make.top.equalTo(itemImage.mas_bottom).offset(10);
            }];
        }
    }
    return self;
}

- (void)allOrder:(UIButton *)sender{
    if (self.tapItemBlock) {
        self.tapItemBlock(0);
    }
}

- (void)tapBlock:(UIButton*)sender{
    if (self.tapItemBlock) {
        self.tapItemBlock(sender.tag);
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
