//
//  MYTabBarViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYTabBarViewController.h"
#import "TZHomeViewController.h"
#import "TZCouponsViewController.h"
#import "TZMineViewController.h"
#import "MYNavigationViewController.h"
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>

@interface MYTabBarViewController ()

@property (nonatomic,strong) MYSingleton *singleton;

@end

@implementation MYTabBarViewController

- (MYSingleton *)singleton{
    if (_singleton == nil) {
        _singleton = [MYSingleton shareInstonce];
    }
    return _singleton;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    // Do any additional setup after loading the view.
    [self setupTabBarChildViews];
    [self initTabBar];
}

- (void)initTabBar{
    self.singleton.tabBarView = [MYBaseView imageViewWithFrame:CGRectMake(0, SCREEN_HEIGHT-61, SCREEN_WIDTH, 61) andImage:[UIImage imageNamed:@"tbbg1"]];
    [self.view addSubview:self.singleton.tabBarView];
    self.singleton.tabBarView.userInteractionEnabled = YES;
    
    NSArray *tittleArray = @[@"首页",@"搜优惠券",@"我的"];
    for (int i = 0 ; i < 3; i ++) {
        UIButton *button = [MYBaseView buttonWithFrame:CGRectMake(SCREEN_WIDTH/3*i, 12, SCREEN_WIDTH/3, 49) buttonType:UIButtonTypeCustom image:nil selectImage:nil];
        [self.singleton.tabBarView addSubview:button];
        [button addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 440+i;
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:tittleArray[i] textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(11)];
        [button addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.bottom.equalTo(button.mas_bottom).offset(-5);
        }];
        titleLabel.tag = 450+i;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [button addSubview:iconImageView];
        iconImageView.tag = 460+i;
        
        if (i == 0) {
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button);
                make.bottom.equalTo(titleLabel.mas_top).offset(-4);
                make.width.mas_equalTo(21);
                make.height.mas_equalTo(20);
            }];
            iconImageView.image = [UIImage imageNamed:@"homelight"];
            titleLabel.textColor = [UIColor colorWithHexString:@"#f47f39" alpha:1.0];
        }else if (i == 1){
            [iconImageView removeFromSuperview];
            FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectZero];
            [button addSubview:imageView];
            imageView.tag = 461;
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button);
                make.bottom.equalTo(titleLabel.mas_top).offset(-4);
                make.width.mas_equalTo(32);
                make.height.mas_equalTo(30);
            }];
            NSString *pathForFile = [[NSBundle mainBundle] pathForResource: @"tbsearchcpn@3x" ofType:@"gif"];
            NSData *dataOfGif = [NSData dataWithContentsOfFile: pathForFile];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:dataOfGif];
            imageView.animatedImage = image;
        }else{
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button);
                make.bottom.equalTo(titleLabel.mas_top).offset(-4);
                make.width.mas_equalTo(21);
                make.height.mas_equalTo(20);
            }];
            iconImageView.image = [UIImage imageNamed:@"me"];
        }
    }
}

- (void)itemSelected:(UIButton *)sender{
    self.selectedIndex = sender.tag - 440;
    for (int i = 0; i < 3; i++){
        UILabel *titleLable = (UILabel *)[self.view viewWithTag:450+i];
        titleLable.textColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
        if (i == 0) {
            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:460+i];
            imageView.image = [UIImage imageNamed:@"home"];
        }else if (i == 1){
            FLAnimatedImageView *imageView = (FLAnimatedImageView *)[self.view viewWithTag:460+i];
            NSString *pathForFile = [[NSBundle mainBundle] pathForResource: @"tbsearchcpn@3x" ofType:@"gif"];
            NSData *dataOfGif = [NSData dataWithContentsOfFile: pathForFile];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:dataOfGif];
            imageView.animatedImage = image;
        }else{
            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:460+i];
            imageView.image = [UIImage imageNamed:@"me"];
        }
    }
    UILabel *titleLabel = (UILabel *)[self.view viewWithTag:sender.tag+10];
    titleLabel.textColor = [UIColor colorWithHexString:@"#f47f39" alpha:1.0];
    
    if (sender.tag == 440) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:sender.tag+20];
        imageView.image = [UIImage imageNamed:@"homelight"];
    }else if (sender.tag == 441) {
        FLAnimatedImageView *imageView = (FLAnimatedImageView *)[self.view viewWithTag:sender.tag+20];
        NSString *pathForFile = [[NSBundle mainBundle] pathForResource: @"tbsearchcpnlight@3x" ofType:@"gif"];
        NSData *dataOfGif = [NSData dataWithContentsOfFile: pathForFile];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:dataOfGif];
        imageView.animatedImage = image;
    }else{
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:sender.tag+20];
        imageView.image = [UIImage imageNamed:@"melight"];
    }
    [MYSingleton shareInstonce].tabBarView.hidden = NO;
}

#pragma mark - 添加视图控件
/**
 *  设置TabBar的子视图
 */
- (void)setupTabBarChildViews {
    TZHomeViewController *homeVC = [[TZHomeViewController alloc] init];
    [self addChildWithViewController:homeVC title:@"首页" image:@"1shouye" selectImage:@"2shouye"];
    
    TZCouponsViewController *couponsVC = [[TZCouponsViewController alloc] init];
    [self addChildWithViewController:couponsVC title:@"搜优惠券" image:@"1souquan" selectImage:@"2souquan"];
    
    TZMineViewController *mineVC = [[TZMineViewController alloc] init];
    [self addChildWithViewController:mineVC title:@"我的" image:@"1wode" selectImage:@"2wode"];
}

- (void)addChildWithViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    /*
    viewController.title = title;
    
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];

    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];

    selectTextAttrs[NSForegroundColorAttributeName] = rGB_Color(241, 54, 54);//[UIColor colorWithHexString:TZ_RED alpha:1.0];
    [viewController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    */
    MYNavigationViewController *nav = [[MYNavigationViewController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
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
