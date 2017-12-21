//
//  TZMineHeadCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZMineHeadCell : UITableViewCell

@property (nonatomic,strong) UIImageView *blackBgView;
@property (nonatomic,strong) UIButton *iconBgButton;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UIButton *qdButton;
@property (nonatomic,strong) UILabel *integralLabel;
@property (nonatomic,strong) UILabel *balanceLabel;
@property (nonatomic,strong) UILabel *sqNumLabel;
@property (nonatomic,strong) UIView *garyBgView;
@property (nonatomic,strong) TZUserInfoModel *model;
@property (nonatomic,copy) void (^headBlock)();
@property (nonatomic,copy) void (^qiandaoBlcok)();
@property (nonatomic,copy) void (^inviteFriendBlock)();
@property (nonatomic,copy) void (^itemBlock)(NSInteger index);

- (void)setCellInfo;

@end
