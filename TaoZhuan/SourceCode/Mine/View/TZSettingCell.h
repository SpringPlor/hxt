//
//  TZSettingCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSettingCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *infoLabel;;

- (void)setCellInfoWithIndex:(NSInteger)index;

@end
