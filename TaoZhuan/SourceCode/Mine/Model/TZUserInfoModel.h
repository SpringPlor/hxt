//
//  TZUserInfoModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@class AgentInfo;

@interface TZUserInfoModel : MYBaseModel

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
@property (nonatomic,assign) CGFloat integral;//积分
@property (nonatomic,assign) CGFloat totalIntegral;//历史总积分
@property (nonatomic,assign) CGFloat moneyToMaster;//给师傅的金额
@property (nonatomic,copy) NSString *lastSigninDate;//最后一次签到时间
@property (nonatomic,copy) NSString *keepSigninDays;//连续签到天数
@property (nonatomic,copy) NSString *isSigninToday;//今天是否签到
@property (nonatomic,copy) NSString *verifyCode;//验证码
@property (nonatomic,copy) NSString *verifyDate;//验证码时间
@property (nonatomic,copy) NSString *invitationCode;//邀请码
@property (nonatomic,copy) NSString *accessToken;//统一token
@property (nonatomic,assign) NSInteger type;//用户类型；1:注册用户 2:游客
@property (nonatomic,assign) CGFloat evaluationToday;//余额当日预估
@property (nonatomic,assign) CGFloat evaluationMonth;//余额今日预估
@property (nonatomic,copy) NSString *isAgent;//是否为agent
@property (nonatomic,strong) AgentInfo *agentInfo;//代理人信息

@end

/*
 agentInfo =     {
 accessToken = cefe88b6f2304810ba6a017eac6a799215129804302604729;
 account = aiqian;
 folkMasterId = 5711;
 id = 1;
 memberId = 120429037;
 profitToFolkMasterRate = "0.05";
 profitToSelfRate = "0.5";
 source = "\U540e\U53f0\U4e00";
 userId = 9;
 }
 */

@interface AgentInfo : NSObject

@property (nonatomic,copy) NSString * accessToken;
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * folkMasterId;
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * memberId;
@property (nonatomic,assign) CGFloat  profitToFolkMasterRate;
@property (nonatomic,assign) CGFloat  profitToSelfRate;
@property (nonatomic,copy) NSString * source;
@property (nonatomic,copy) NSString * userId;

@end
