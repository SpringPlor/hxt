//
//  TZKefuCourseCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZKefuCourseModel.h"

@interface TZKefuCourseCell : UITableViewCell

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *arrowButton;
@property (nonatomic,copy) void (^spreadBlock)(BOOL isSpread);

- (void)setCellInfoWithModel:(TZKefuCourseModel *)model;

@end
