//
//  TZOrderCollectionView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZOrderCollectionView : UIView

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *submitLabel;
@property (nonatomic,strong) void (^orderNumBlock)(NSString *orderNum);

@end
