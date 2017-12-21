//
//  TZLoginModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"
#import "TZUserInfoModel.h"

@interface TZLoginModel : MYBaseModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *weiXinNumber;
@property (nonatomic,copy) NSString *faceUrl;
@property (nonatomic,copy) NSString *masterId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *birthDay;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,assign) CGFloat money;//余额
@property (nonatomic,assign) CGFloat saveMoney;//已省钱
@property (nonatomic,assign) NSInteger disciples;//徒弟个数
@property (nonatomic,assign) CGFloat totalMoney;//历史总金额
@property (nonatomic,copy) NSString *integral;//积分
@property (nonatomic,assign) CGFloat totalIntegral;//历史总积分
@property (nonatomic,assign) CGFloat moneyToMaster;//给师傅的金额
@property (nonatomic,assign) CGFloat lastSigninDate;//最后一次签到时间
@property (nonatomic,assign) NSInteger keepSigninDays;//连续签到天数
@property (nonatomic,copy) NSString *verifyCode;//验证码
@property (nonatomic,copy) NSString *verifyDate;//验证码时间
@property (nonatomic,copy) NSString *invitationCode;//邀请码
@property (nonatomic,copy) NSString *accessToken;//统一token
@property (nonatomic,copy) NSString *type;//用户类型；1:注册用户 2:游客
@property (nonatomic,strong) AgentInfo *agentInfo;

@end
