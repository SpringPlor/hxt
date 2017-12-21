//
//  TZJiFenExchangeTitleCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#define SpaceWidth (SCREEN_WIDTH-80-48*4)/3


#import "TZJiFenExchangeTitleCell.h"

@implementation TZJiFenExchangeTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"积分兑换区间专区" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        
        NSArray *topArray = @[@"10",@"50",@"200",@"1000"];
        NSArray *bottomArray = @[@"50",@"200",@"1000",@"以上"];
        for (int i = 0; i < 4; i++){
            UIButton *jifenButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"yuan_default"] selectImage:[UIImage imageNamed:@"yuan_focus"]];
            [self.contentView addSubview:jifenButton];
            jifenButton.frame = CGRectMake(40+(48+SpaceWidth)*i, 43, 48, 48);
            UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
            [jifenButton addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(jifenButton).offset(8);
                make.center.equalTo(jifenButton);
                make.height.mas_equalTo(2);
            }];
            UILabel *topLabel = [MYBaseView labelWithFrame:CGRectZero text:topArray[i] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
            [jifenButton addSubview:topLabel];
            [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(lineView);
                make.bottom.equalTo(lineView.mas_bottom).offset(-2);
            }];
            
            UILabel *bottomLabel = [MYBaseView labelWithFrame:CGRectZero text:bottomArray[i] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
            [jifenButton addSubview:bottomLabel];
            [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(lineView);
                make.top.equalTo(lineView.mas_bottom);
            }];
            
            if (i == 0) {
                jifenButton.selected = YES;
                jifenButton.frame = CGRectMake(40+(48+SpaceWidth)*i, 43, 48, 53);
            }
            jifenButton.tag = 150+i;
            [jifenButton addTarget:self action:@selector(checkStatus:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        NSArray *imageArray = @[[UIImage imageNamed:@"10_50"],[UIImage imageNamed:@"50_200"],[UIImage imageNamed:@"200_1000"],[UIImage imageNamed:@"1000"]];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 150*kScale)];
        [self.contentView addSubview:self.scrollView];
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, 150*kScale);
        for (int i = 0; i < 4; i ++){
            UIImageView *imageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:imageArray[i]];
            [self.scrollView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.scrollView);
                make.left.equalTo(self.scrollView).offset(SCREEN_WIDTH*i);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(150*kScale);
            }];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 160+i;
            //[imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jfAction:)]];
        }
        self.arrowImageView = [MYBaseView imageViewWithFrame:CGRectMake(61, 109.5, 6, 7) andImage:[UIImage imageNamed:@"baise"]];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (void)setCellGuideTypeIndex:(NSInteger)index{
    for (int i = 0 ;i < 4; i ++){
        UIButton *button = (UIButton *)[self viewWithTag:150 + i];
        button.selected = NO;
        button.frame = CGRectMake(40+(48+SpaceWidth)*i, 43, 48, 48);
    }
    UIButton *sender = (UIButton *)[self viewWithTag:150+index];
    sender.selected = YES;
    sender.frame = CGRectMake(40+(48+SpaceWidth)*(sender.tag-150), 43, 48, 53);
    self.arrowImageView.frame = CGRectMake(61+(48+SpaceWidth)*(sender.tag-150), 109.5, 6, 7);
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(sender.tag-150), 0) animated:YES];
}

- (void)checkStatus:(UIButton *)sender{
    for (int i = 0 ;i < 4; i ++){
        UIButton *button = (UIButton *)[self viewWithTag:150 + i];
        button.selected = NO;
        button.frame = CGRectMake(40+(48+SpaceWidth)*i, 43, 48, 48);
    }
    sender.selected = YES;
    sender.frame = CGRectMake(40+(48+SpaceWidth)*(sender.tag-150), 43, 48, 53);
    self.arrowImageView.frame = CGRectMake(61+(48+SpaceWidth)*(sender.tag-150), 109.5, 6, 7);
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(sender.tag-150), 0) animated:YES];
    if (self.tapBlcok) {
        self.tapBlcok(sender.tag-150);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
