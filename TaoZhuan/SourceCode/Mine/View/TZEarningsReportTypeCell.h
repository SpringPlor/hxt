//
//  TZEarningsReportTypeCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZEarningsReportTypeCell : UITableViewCell

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;

- (void)setCellInfoWithIndex:(NSInteger)index;

@end
