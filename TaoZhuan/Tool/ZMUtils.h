//
//  ZMUtils.h
//  ZebraLife_Merchant
//
//  Created by 彭佳伟 on 2017/8/2.
//  Copyright © 2017年 bm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface ZMUtils : NSObject

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile;

//验证用户名的合法性
+ (BOOL) validateUserName:(NSString *)name;

//验证是否包含字母
+ (BOOL) validateCharacter:(NSString *)string;

+ (BOOL)containChinese:(NSString *)str;

+ (BOOL)judgeTheillegalCharacter:(NSString *)content;

//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email;

//验证密码
+ (BOOL) validatePassword:(NSString *) password;

//获取当前时间
+ (NSString *)currentDateStr;

+ (NSString *)md5:(NSString *)str;

+ (NSString *)hexStringFromString:(NSString *)string;

+ (NSString *)getHexByBinary:(NSString *)binary;

//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//获取当前时间戳
+ (NSString *)getCurrentTimestamp;

//过滤字符串
+ (NSString *)filterHTML:(NSString *)html;

//判断是否为整形
+ (BOOL)isPureInt:(NSString*)string;

//判断是否为浮点型
+ (BOOL)isPureFloat:(NSString*)string;

@end
