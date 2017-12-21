//
//  TZThirdShare.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZThirdShare.h"
#import "TZKeyChain.h"

@implementation TZThirdShare

+ (void)shareAppRegister{
    //友盟分享
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMSDK_Key];
    //微信聊天、朋友圈
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wexin_Key appSecret:Wexin_Secret redirectURL:nil];
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106519248" appSecret:@"q2jFQm9pnUsqWU9O" redirectURL:nil];
    //QZone
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106519248" appSecret:@"q2jFQm9pnUsqWU9O" redirectURL:nil];
}

+ (void)shareRegisterToAppWith:(UMSocialPlatformType)platformType inviteCode:(NSString *)code{
    UMSocialMessageObject *messageObj = [UMSocialMessageObject messageObject];
    NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
    NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
    NSString *shareUrl = code;
    
    UMShareWebpageObject *objc = [UMShareWebpageObject shareObjectWithTitle:@"淘宝【优惠搜索】神器" descr:@"你还在不用优惠券就购买商品吗？惠享淘天猫淘宝优惠搜索神器，获得【高额】优惠，用的越多，省的越多！" thumImage:[UIImage imageNamed:@"80"]];
    objc.webpageUrl = shareUrl;
    messageObj.shareObject = objc;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObj currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialShareResponse *response = result;
        NSLog(@"success：%@  error：%@",result,error);
    }];
}

+ (void)shareQRCodeToAppWith:(UMSocialPlatformType)platformType image:(UIImage *)image{
    UMSocialMessageObject *messageObj = [UMSocialMessageObject messageObject];
    UMShareImageObject *imageObject = [UMShareImageObject shareObjectWithTitle:nil descr:nil thumImage:nil];
    imageObject.shareImage = image;
    messageObj.shareObject = imageObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObj currentViewController:nil completion:^(id result, NSError *error) {
        NSLog(@"success：%@  error：%@",result,error);
    }];
}


@end
