//
//  TZThirdShare.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface TZThirdShare : NSObject

+ (void)shareAppRegister;

+ (void)shareRegisterToAppWith:(UMSocialPlatformType)platformType inviteCode:(NSString *)code;

+ (void)shareQRCodeToAppWith:(UMSocialPlatformType)platformType image:(UIImage *)image;

@end
