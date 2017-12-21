//
//  TZNewAddressCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZNewAddressCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *defaultButton;

- (void)setCellTitleWithIndex:(NSInteger)index;

@end
