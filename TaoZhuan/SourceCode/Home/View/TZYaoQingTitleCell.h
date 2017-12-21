//
//  TZYaoQingTitleCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZYaoQingTitleCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *yqImageView;
@property (nonatomic,strong) UILabel *yqCodeLabel;
@property (nonatomic,strong) UILabel *noticeLabel;
@property (nonatomic,copy) void (^shareBlock)(NSInteger index);

- (void)setInviteCode:(NSString *)code;

@end
