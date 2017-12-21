//
//  TZSettingQuitCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSettingQuitCell : UITableViewCell

@property (nonatomic,strong) UILabel *quitLabel;

@property (nonatomic,copy) void (^quitBlock)();

@end
