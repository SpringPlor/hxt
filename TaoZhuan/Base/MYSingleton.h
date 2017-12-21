//
//  MYSingleton.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZLoginModel.h"
#import "TZUserInfoModel.h"

@interface MYSingleton : NSObject

@property (nonatomic,strong) UIImageView *tabBarView;
@property (nonatomic,strong) TZLoginModel *loginModel;
@property (nonatomic,strong) TZUserInfoModel *userInfoModel;

+ (MYSingleton *)shareInstonce;

- (void)setLoginInfo;

- (void)setUserInfo;

@end
