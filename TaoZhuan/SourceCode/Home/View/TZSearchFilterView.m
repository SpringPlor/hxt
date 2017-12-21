//
//  TZSearchFilterView.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchFilterView.h"

@implementation TZSearchFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.couponIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"filterquan"]];
        [self addSubview:self.couponIcon];
        [self.couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(-2.5);
            make.width.mas_equalTo(14);
            make.height.mas_offset(12);
        }];
        
        self.textLabel = [MYBaseView labelWithFrame:CGRectZero text:@"仅显示优惠券商品" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couponIcon.mas_right).offset(5);
            make.centerY.equalTo(self.couponIcon);
        }];
        
        self.filterButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"filterwhitebg"] selectImage:nil];
        [self addSubview:self.filterButton];
        [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.couponIcon);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(23);
        }];
        [[self.filterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.filterCoupon = !self.filterCoupon;
            if (self.filterStatus) {
                self.filterStatus(self.filterCoupon);
            }
        }];
        
        self.filterIcon = [MYBaseView imageViewWithFrame:CGRectMake(1, 0.5, 22, 22) andImage:[UIImage imageNamed:@"filterround"]];
        [self.filterButton addSubview:self.filterIcon];
        @weakify(self);
        [RACObserve(self, filterCoupon) subscribeNext:^(id x) {
            @strongify(self);
            if ([x boolValue] == YES) {
                [self.filterButton setImage:[UIImage imageNamed:@"filterbg"] forState:UIControlStateNormal];
                [UIView animateWithDuration:0.1 animations:^{
                    self.filterIcon.frame = CGRectMake(45-23, 0.5, 22, 22);
                }];
            }else{
                [UIView animateWithDuration:0.1 animations:^{
                    self.filterIcon.frame = CGRectMake( 1, 0.5, 22, 22);
                }completion:^(BOOL finished) {
                    [self.filterButton setImage:[UIImage imageNamed:@"filterwhitebg"] forState:UIControlStateNormal];
                }];
            }
        }];
        
        UIView *lineView = [MYBaseView viewWithFrame:CGRectMake(0, 35, SCREEN_HEIGHT, 5) backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
        [self addSubview:lineView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
