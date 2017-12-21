//
//  TZMineHeadCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineHeadCell.h"

@implementation TZMineHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.blackBgView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 187*kScale) andImage:[UIImage imageNamed:@"wodedi"]];
        [self.contentView addSubview:self.blackBgView];
        self.blackBgView.userInteractionEnabled = YES;
        
        self.iconBgButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"dise"] selectImage:nil];
        [self.blackBgView addSubview:self.iconBgButton];
        [self.iconBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.blackBgView).offset(50*kScale);
            make.left.equalTo(self.blackBgView).offset(30);
            make.width.height.mas_equalTo(45);
        }];
        self.iconBgButton.userInteractionEnabled = YES;
        
        self.headImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"weidenglu"]];
        [self.iconBgButton addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.iconBgButton);
            make.width.height.mas_equalTo(40);
        }];
        
        self.phoneLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#f6f6f6" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.blackBgView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconBgButton.mas_right).offset(10);
            make.centerY.equalTo(self.iconBgButton);
        }];
        self.phoneLabel.userInteractionEnabled = YES;
        [self.phoneLabel addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
            if (self.headBlock) {
                self.headBlock();
            }
        }]];
        
        self.qdButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"1qiandao"] selectImage:nil];
        [self.blackBgView addSubview:self.qdButton];
        [self.qdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.phoneLabel);
            make.right.equalTo(self.blackBgView).offset(-15);
            make.width.mas_equalTo(78);
            make.height.mas_equalTo(29);
        }];
        self.qdButton.userInteractionEnabled = YES;
        [[self.qdButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.qiandaoBlcok) {
                self.qiandaoBlcok();
            }
        }];
        
        if ([UserDefaultsOFK(Login_Status) intValue] == 1 && [MYSingleton shareInstonce].userInfoModel.agentInfo.id){
            CGFloat itemWidth = SCREEN_WIDTH/3;
            NSArray *desArray = @[@"积分>",@"我的余额>",@"已省钱"];
            for (int i = 0; i < 3; i ++){
                UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
                [self.blackBgView addSubview:itemButton];
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    //make.top.equalTo(self.iconBgButton.mas_bottom).offset(20*kScale);
                    make.bottom.equalTo(self.blackBgView.mas_bottom).offset(-15*kScale);
                    make.left.equalTo(self.blackBgView).offset(i*itemWidth);
                    make.height.mas_equalTo(44);
                    make.width.mas_equalTo(itemWidth);
                }];
                itemButton.userInteractionEnabled = YES;
                [[itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
                    if (self.itemBlock) {
                        self.itemBlock(sender.tag);
                    }
                }];
                itemButton.tag = 300+i;
                
                UILabel *itemLabel = [MYBaseView labelWithFrame:CGRectZero text:@"0" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(20)];
                [itemButton addSubview:itemLabel];
                [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemButton);
                    make.centerX.equalTo(itemButton);
                }];
                UILabel *desLabel = [MYBaseView labelWithFrame:CGRectZero text:desArray[i] textColor:[UIColor colorWithHexString:@"#ffd4d4" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
                [itemButton addSubview:desLabel];
                [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(itemButton.mas_bottom);
                    make.centerX.equalTo(itemButton);
                }];
                UIImageView *lineImage = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"fengexian"]];
                [itemButton addSubview:lineImage];
                [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(itemButton.mas_right);
                    make.centerY.equalTo(itemButton);
                    make.width.mas_equalTo(0.5);
                    make.height.mas_equalTo(36);
                }];
                if (i == 0) {
                    self.integralLabel = itemLabel;
                }else if (i == 1){
                    self.balanceLabel = itemLabel;
                }else{
                    self.sqNumLabel = itemLabel;
                    [lineImage removeFromSuperview];
                }
            }
        }else{
            NSArray *desArray = @[@"积分>",@"已省钱"];
            for (int i = 0; i < 2; i ++){
                UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
                [self.blackBgView addSubview:itemButton];
                if (i == 0) {
                    [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.blackBgView.mas_bottom).offset(-15*kScale);
                        make.right.equalTo(self.blackBgView.mas_centerX);
                        make.height.mas_equalTo(44);
                        make.width.mas_equalTo(130);
                    }];
                }else{
                    [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.blackBgView.mas_bottom).offset(-15*kScale);
                        make.left.equalTo(self.blackBgView.mas_centerX);
                        make.height.mas_equalTo(44);
                        make.width.mas_equalTo(130);
                    }];
                }
                itemButton.tag = 300+i;
                itemButton.userInteractionEnabled = YES;
                [[itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
                    if (self.itemBlock) {
                        self.itemBlock(sender.tag);
                    }
                }];
                
                UILabel *itemLabel = [MYBaseView labelWithFrame:CGRectZero text:@"0" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(20)];
                [itemButton addSubview:itemLabel];
                [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemButton);
                    make.centerX.equalTo(itemButton);
                }];
                UILabel *desLabel = [MYBaseView labelWithFrame:CGRectZero text:desArray[i] textColor:[UIColor colorWithHexString:@"#ffd4d4" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
                [itemButton addSubview:desLabel];
                [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(itemButton.mas_bottom);
                    make.centerX.equalTo(itemButton);
                }];
                if (i == 0) {
                    self.integralLabel = itemLabel;
                }else {
                    self.sqNumLabel = itemLabel;
                }
            }
            UIImageView *lineImage = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"fengexian"]];
            [self.blackBgView addSubview:lineImage];
            [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.blackBgView.mas_centerX);
                make.bottom.equalTo(self.blackBgView.mas_bottom).offset(-19*kScale);
                make.width.mas_equalTo(0.5);
                make.height.mas_equalTo(36);
            }];
        }

        self.garyBgView = [MYBaseView viewWithFrame:CGRectMake(0, 187*kScale-5, SCREEN_WIDTH, 15*4+10+115*kScale+138*3+152+20+55+(138+15)) backgroundColor:rGB_Color(241, 242, 243)];
        [self.contentView addSubview:self.garyBgView ];
        [self.garyBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.blackBgView.mas_bottom).offset(-5);
            make.height.mas_equalTo(115*kScale+15);
        }];
        self.garyBgView .layer.cornerRadius = 5;
        
        UIImageView *adImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"minebanner"]];
        [self.garyBgView  addSubview:adImageView];
        [adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.garyBgView ).offset(15);
            make.left.equalTo(self.contentView).offset(10);
            make.centerX.equalTo(self.contentView);
            make.height.mas_equalTo(115*kScale);
        }];
        adImageView.userInteractionEnabled = YES;
        [adImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inviteFriend:)]];
        if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
            self.headImageView.image = [UIImage imageNamed:@"denglu"];
            self.phoneLabel.text = [MYSingleton shareInstonce].userInfoModel.phoneNumber;//[[MYSingleton shareInstonce].userInfoModel.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.integralLabel.text = [NSString stringWithFormat:@"%d",(int)[MYSingleton shareInstonce].userInfoModel.integral];
            NSString *sqString =  [NSString stringWithFormat:@"%.2f元",[MYSingleton shareInstonce].userInfoModel.saveMoney];
            self.sqNumLabel.attributedText = [NSString stringWithString:sqString Range:NSMakeRange(sqString.length-1, 1) color:nil font:kFont(14)];
            NSString *balanceString = [NSString stringWithFormat:@"%.2f元",[MYSingleton shareInstonce].userInfoModel.money];
            self.balanceLabel.attributedText = [NSString stringWithString:balanceString Range:NSMakeRange(balanceString.length-1, 1) color:nil font:kFont(14)];
            if ([MYSingleton shareInstonce].userInfoModel.isSigninToday != nil && [[MYSingleton shareInstonce].userInfoModel.isSigninToday intValue] == 1) {
                [self.qdButton setImage:[UIImage imageNamed:@"2yiqiandao"] forState:UIControlStateNormal];
            }
        }else{
            self.headImageView.image = [UIImage imageNamed:@"weidenglu"];
            self.phoneLabel.text = @"未登录";
            self.integralLabel.text = @"0";
            self.sqNumLabel.text = @"0";
            self.balanceLabel.text = @"0";
            [self.qdButton setImage:[UIImage imageNamed:@"1qiandao"] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)inviteFriend:(UITapGestureRecognizer *)sender{
    if (self.inviteFriendBlock) {
        self.inviteFriendBlock();
    }
}

- (void)setCellInfo{
    if ([UserDefaultsOFK(Login_Status) intValue] == 1){
        if ([MYSingleton shareInstonce].userInfoModel.isSigninToday != nil && [[MYSingleton shareInstonce].userInfoModel.isSigninToday intValue] == 1) {
            [self.qdButton setImage:[UIImage imageNamed:@"2yiqiandao"] forState:UIControlStateNormal];
        }else{
            [self.qdButton setImage:[UIImage imageNamed:@"1qiandao"] forState:UIControlStateNormal];
        }
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
