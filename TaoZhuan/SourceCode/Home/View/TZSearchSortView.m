//
//  TZSearchSortView.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchSortView.h"

@implementation TZSearchSortView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        CGFloat itemWidth = SCREEN_WIDTH/4;
        NSArray *titleArray = @[@"综合",@"优惠券",@"券后价",@"销量"];
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
            [itemButton setTitleColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(tapAciton:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = 1220+i;
            if (i == 0) {
                self.zhButton = itemButton;
                self.zhButton.selected = YES;
            }
            if (i == 1) {
                self.yhlButton = itemButton;
            }
            if (i == 2) {
                self.xlButton = itemButton;
            }
            if (i == 3) {
                self.qhjButton = itemButton;
            }
        }
        UIView *topLine = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) backgroundColor:rGB_Color(230, 230, 230)];
        [self addSubview:topLine];
        self.redView = [MYBaseView viewWithFrame:CGRectMake(itemWidth/2-10, 37, 20, 3) backgroundColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0]];
        [self addSubview:self.redView];
    }
    return self;
}

- (void)tapAciton:(UIButton *)sender{
    self.zhButton.selected = NO;
    self.yhlButton.selected = NO;
    self.xlButton.selected = NO;
    self.qhjButton.selected = NO;
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

- (void)resetHeader{
    self.zhButton.selected = YES;
    self.yhlButton.selected = NO;
    self.xlButton.selected = NO;
    self.qhjButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.redView.frame = CGRectMake(SCREEN_WIDTH/4/2-10, 37, 20, 3);
    }];

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
