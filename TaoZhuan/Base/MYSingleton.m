//
//  MYSingleton.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYSingleton.h"

@implementation MYSingleton

+ (MYSingleton *)shareInstonce{
    static MYSingleton *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[MYSingleton alloc] init];
    });
    return singleton;
}

- (TZLoginModel *)loginModel{
    if (_loginModel == nil) {
        NSLog(@"%@",UserDefaultsOFK(User_Info));
        _loginModel = [TZLoginModel mj_objectWithKeyValues:UserDefaultsOFK(User_Info)];
    }
    return _loginModel;
}

- (void)setLoginInfo{
    _loginModel = [TZLoginModel mj_objectWithKeyValues:UserDefaultsOFK(User_Info)];
}

- (TZUserInfoModel *)userInfoModel{
    if (_userInfoModel == nil) {
        _userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:UserDefaultsOFK(User_Info)];
    }
    return _userInfoModel;
}

- (void)setUserInfo{
    _userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:UserDefaultsOFK(User_Info)];
}


@end
