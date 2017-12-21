//
//  TZSearchSortView.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouOrderSortView.h"

@implementation TZTaoYouOrderSortView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        CGFloat itemWidth = SCREEN_WIDTH/4;
        NSArray *titleArray = @[@"全部",@"预估",@"失效",@"结算"];
        for (int i = 0; i < 4 ; i++) {
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:titleArray[i] titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(14)];
            [self addSubview:itemButton];
            itemButton.backgroundColor = [UIColor whiteColor];
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(itemWidth*i);
                make.top.equalTo(self);
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(40);
            }];
            [itemButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(tapAciton:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = 1220+i;
            if (i == 0) {
                itemButton.selected = YES;
            }
        }
        UIView *topLine = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) backgroundColor:rGB_Color(230, 230, 230)];
        [self addSubview:topLine];
        self.redView = [MYBaseView viewWithFrame:CGRectMake(itemWidth/2-10, 37, 22, 3) backgroundColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0]];
        [self addSubview:self.redView];
        self.redView.layer.cornerRadius = 1.5;
    }
    return self;
}

- (void)tapAciton:(UIButton *)sender{
    for (int i = 0; i < 4; i ++) {
        UIButton *button = (UIButton *)[self viewWithTag:1220+i];
        button.selected = NO;
    }
    sender.selected = YES;
    CGFloat itemWidth = SCREEN_WIDTH/4;
    [UIView animateWithDuration:0.3 animations:^{
        self.redView.frame = CGRectMake((sender.tag - 1220)*itemWidth+itemWidth/2-10, 37, 20, 3);
    }];
    if (self.tapBlcok) {
        NSString *order;
        switch (sender.tag - 1220) {
            case 0:
                order = @"default";
                break;
            case 1:
                order = @"cpnprice";
                break;
            case 2:
                order = @"pdtbuy";
                break;
            case 3:
                order = @"pdtsell";
                break;
            default:
                break;
        }
        self.tapBlcok(sender.tag-1220, order);
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
