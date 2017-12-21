//
//  TZQianDaoTitleCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZQianDaoTitleCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UIImageView *cycleImageView;

@property (nonatomic,strong) UILabel *qiandaoLabel;

@property (nonatomic,strong) UILabel *jifenLabel;

@property (nonatomic,strong) UILabel *jfValueLabel;

@property (nonatomic,strong) UILabel *jfExchangeLabel;

@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,strong) UILabel *jfDescribeLabel;

@property (nonatomic,strong) UILabel *qdDescribeLabel;

@property (nonatomic,copy) void (^signInBlock)();

@property (nonatomic,copy) void (^jfBlock)();


- (void)setCellInfoWithUserInfoModel;

@end
