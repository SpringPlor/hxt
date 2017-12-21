//
//  AppDelegate.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MYTabBarViewController.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import "TZMineViewModel.h"
#import "TZGuideViewController.h"
#import "TZKeyChain.h"
#import <UMSocialCore/UMSocialCore.h>
#import "TZThirdShare.h"
#import "TZLoginViewModel.h"
#import "TZDeviceModel.h"
#import "TZHomeViewModel.h"

@interface AppDelegate ()

@property (nonatomic,strong) TZLoginViewModel *viewModel;
@property (nonatomic,strong) TZHomeViewModel *homeViewModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    
    [self saveUUID];
    [self initUMSDK];
    [self initAliTradeSDK];
    [self fetchUserInfo];
    [self.window makeKeyAndVisible];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self switchRootVC];
    return YES;
}

- (void)initUMSDK{
    //友盟统计
    UMConfigInstance.appKey = UMSDK_Key;
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    //分享
    [TZThirdShare shareAppRegister];
}

- (void)initAliTradeSDK{
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    [[AlibcTradeSDK sharedInstance] setISVCode:AliTradeSDK_Key];
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = AliTradeSDK_PID;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        NSLog(@"init:Success");
    } failure:^(NSError *error) {
        NSLog(@"init:%@",error);
    }];
    //[[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//debug日志
   // [[AlibcTradeSDK sharedInstance] setIsForceH5:YES];
}

- (void)fetchUserInfo{
    if ([UserDefaultsOFK(Login_Status) intValue] == 1){//已登录，获取用户信息
        TZMineViewModel *viewModel = [TZMineViewModel new];
        [[viewModel.userInfoCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
            UserDefaultsSFK(model.data, User_Info);
            [MYSingleton shareInstonce].userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:model.data];
        }];
        if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
            [viewModel.userInfoCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken}];
        }else{
            if ([MYSingleton shareInstonce].userInfoModel.id) {
                [viewModel.userInfoCommand execute:@{@"u":[MYSingleton shareInstonce].userInfoModel.id,@"t":[MYSingleton shareInstonce].userInfoModel.accessToken}];
            }
        }
    }else{//未登录，使用设备号登录
        [[self.viewModel.deviceIdCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
            if (model) {
                UserDefaultsSFK([[TZDeviceModel mj_objectWithKeyValues:model.data] mj_keyValues], User_Device_Info);//保存登录信息
            }
        }];
        NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
        NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
        [self.viewModel.deviceIdCommand execute:@{@"deviceId":deviceUUID}];
    }
}

- (void)switchRootVC{
    NSString *key = @"CFBundleShortVersionString";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"last %@ current %@",lastVersion,currentVersion);
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        MYTabBarViewController *tabbarVC = [[MYTabBarViewController alloc] init];
        self.window.rootViewController = tabbarVC;
    } else { // 这次打开的版本和上一次不一样，显示新特性
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window.rootViewController = [[TZGuideViewController alloc] init];
    }
}

//保存设备UUID
- (void)saveUUID{
    NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
    NSLog(@"%@",[[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding]);
    if (UUID == nil) {
        NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [TZKeyChain save:kUUIDKeyChainKey data:[deviceUUID dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果百川处理过会返回YES
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        // 处理其他app跳转到自己的app
    }
    [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];;
    return YES;
}


//IOS9.0 系统新的处理openURL 的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    __unused BOOL isHandledByALBBSDK=[[AlibcTradeSDK sharedInstance] application:application openURL:url options:options];//处理其他app跳转到自己的app，如果百川处理过会返回YES
    [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
