//
//  MYNavigationViewController.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYNavigationViewController.h"
#import "UIBarButtonItem+MYExtension.h"

@interface MYNavigationViewController ()

@end

@implementation MYNavigationViewController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.tintColor = [UIColor blackColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [navBar setTitleTextAttributes:textAttrs];
    navBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = YES;
}


/**
 重写导航栏push方法

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //设置统一的返回按钮图标
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhuihuise"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];//[UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:@"fanhuihuise" hilightedImage:@"fanhuihuise"];
    }
    if (@available(iOS 11.0, *)){
        NSLog(@"%@",viewController);
    }else{
        
    }
    [super pushViewController:viewController animated:animated];
}


/**
 重写导航栏present方法

 @param viewControllerToPresent <#viewControllerToPresent description#>
 @param flag <#flag description#>
 @param completion <#completion description#>
 */
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.viewControllers.count > 0) {
        if ([viewControllerToPresent isKindOfClass:[MYNavigationViewController class]]) {
            MYNavigationViewController *nav = (MYNavigationViewController *)viewControllerToPresent;
            UIViewController *viewController = nav.viewControllers[0];
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(dismissAction) image:@"fanhui" hilightedImage:@"fanhui"];
        } /*else if ([viewControllerToPresent isKindOfClass:[UIImagePickerController class]]){
           UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
           button.frame = CGRectMake(0, 0, 40, 30);
           [button setTitle:@"完成" forState:UIControlStateNormal];
           [button setTitleColor:[UIColor colorWithHexString:Normal_Font_Color alpha:1.0] forState:UIControlStateNormal];
           UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
           viewControllerToPresent.navigationItem.rightBarButtonItem = item;
           }*/
        
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    
}

/**
 *  返回上一个控制器
 */
- (void)backAction {
    [self popViewControllerAnimated:YES];
}

- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
