//
//  TZAddressManageCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZAddressManageCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIButton *defaultButton;
@property (nonatomic,strong) UILabel *defaultLabel;
@property (nonatomic,strong) UIButton *editButton;
@property (nonatomic,strong) UIButton *deleteButton;

@end
