//
//  TZPartnerModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZPartnerModel : MYBaseModel

/*
account - String : 合伙人账号
phoneNumber - String : 合伙人电话号码
price - Double : 合伙人贡献佣金
creationTime - String : 合伙人入驻时间
*/
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) NSString *creationTime;

@end
