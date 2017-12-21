//
//  TZKefuQQCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZKefuQQCell : UITableViewCell

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *QQLabel;
@property (nonatomic,strong) UIButton *QQButton;

- (void)setCellInfoWithIndex:(NSInteger)index;

@end
