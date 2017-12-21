//
//  MYDefine.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYDefine : NSObject

//FontSize
#define kFont(size)         [UIFont systemFontOfSize:size]

#define rGB_Color(r,g,b)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0f]
#define TZ_RED                  @"#a24aef"
#define TZ_BLACK                @"#333333"
#define TZ_LIGHT_BLACK          @"#666666"
#define TZ_GRAY                 @"#999999"
#define TZ_LIGHT_RED            @"#f33535"
#define TZ_Main_Color           @"#e34747"
#define TZ_TableView_Color      @"#f2f2f2"

#define WeakSelf(self)      __weak typeof(self)weakSelf = self

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})


#define UserDefaults                [NSUserDefaults standardUserDefaults]
#define UserDefaultsOFK(key)        [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UserDefaultsSFK(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
#define UserDefaultsSynchronize     [[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefaultsRemove(key)     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

//基本属性
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define kAppDelegate    [[UIApplication sharedApplication] delegate]

#define kWindow          [[UIApplication sharedApplication].delegate window]

#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height==2436 : NO)

#define kTabbarHeight       49
#define kNavigationHeight   64

#define kScale  [[UIScreen mainScreen] bounds].size.width/375

//#define kServerPath          @"http://116.62.137.122:9000/" //正式环境
#define kServerPath          @"http://118.31.45.203:9000/" //测试环境


#define kInterfacePath       @""

//#define AliTradeSDK_Key      @"24645583"
#define AliTradeSDK_Key      @"24640356"
//#define AliTradeSDK_Secrect  @"56a286c3f9ca61a9e4b67b92bf344a58"
#define AliTradeSDK_Secrect  @"6833e79a54e2b9de9e941405aa272c17"
#define AliTradeSDK_PID      @"mm_118993079_37594786_138744610"

#define UMSDK_Key            @"59ee9f45f43e4815e4000044"
#define UMSDK_Secret         @""

#define Wexin_Key            @"wxe81b70f6d2910c34"
#define Wexin_Secret         @"81d2fedd719f276d799ece627d7334d6"

#define QQ_Key               @""
#define QQ_Sercrect          @""

#define Login_Status         @"loginStatus"//登录状态
#define User_Info            @"userInfo" //用户信息
#define User_Device_Info     @"userDeviceInfo"//设备号登录时返回信息
#define Page_Size            @"20"
#define LOGIN_INFO           @"loginInfo"//登录信息
#define Home_Item            @"homeItem"//首页顶部item点击记录
#define ZFB_Account          @"zfbAccount"//提现成功后保存支付宝账号

@end
