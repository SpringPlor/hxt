//
//  ZMUtils.m
//  ZebraLife_Merchant
//
//  Created by 彭佳伟 on 2017/8/2.
//  Copyright © 2017年 bm. All rights reserved.
//

#import "ZMUtils.h"

@implementation ZMUtils

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile {
    if (mobile.length == 0) {
        NSString *message = @"手机号码不能为空！";
        //[SVProgressHUD showWithStatus:message];
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符 ^1[3|4|5|7|8][0-9]\\d{8}$
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phoneTest evaluateWithObject:mobile]) {
        NSString *message = @"手机号码格式不正确！";
        //[SVProgressHUD showInfoWithStatus:message];
        return NO;
    }
    return YES;
}

//用户名
+ (BOOL) validateUserName:(NSString *)name {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

+ (BOOL)validateCharacter:(NSString *)string {
    const char *chars = [string cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i = 0; i < strlen(chars); i++) {
        if ((chars[i] > 64 && chars[i] < 91) || (chars[i] > 96 && chars[i] < 123) ) {
            return YES;
        }
    }
    return NO;
}

//判断是否有中文
+ (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)judgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5-_]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}


//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email {
    if (email.length == 0) {
        NSString *message = @"邮箱不能为空！";
        //[SVProgressHUD showWithStatus:message];
        return NO;
    }
    
    NSString *expression = [NSString stringWithFormat:@"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
    NSError *error = NULL;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:expression
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:email
                                                    options:0
                                                      range:NSMakeRange(0,[email length])];
    if (!match) {
        NSString *message = @"邮箱格式错误!";
        //[SVProgressHUD showErrorWithStatus:message];
        return NO;
    }
    return YES;
}

//验证密码是否含有特殊字符
+ (BOOL) validatePassword:(NSString *) password {
    NSString *expression = [NSString stringWithFormat:@"^[A-Za-z0-9_]{6,16}+$"];
    NSError *error = NULL;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:expression
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:password
                                                    options:0
                                                      range:NSMakeRange(0,[password length])];
    if (!match) {
        return NO;
    }
    
    return YES;
}

//获取当前时间
+ (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if ([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSString *)getHexByBinary:(NSString *)binary {
    
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSString*)getCurrentTimestamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

+ (NSString *)filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO){
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}


//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
