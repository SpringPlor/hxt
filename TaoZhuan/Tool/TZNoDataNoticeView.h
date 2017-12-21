//
//  TZNoDataNoticeView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/19.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZNoDataNoticeView : UIView

@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic,strong) UIButton *inviteButton;

@property (nonatomic,copy) void (^inviteBlock)();


- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image imageSize:(CGSize)imageSize title:(NSString *)title message:(NSString *)message;


@end
