//
//  TZGuideViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/19.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZGuideViewController.h"
#import "MYTabBarViewController.h"
#import "TZLoginViewController.h"

@interface TZGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TZGuideViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray1 = @[@"1_640x1136",@"2_640x1136",@"3_640x1136"];
    NSArray *imageArray2 = @[@"1_750x1334",@"2_750x1334",@"3_750x1334"];
    NSArray *imageArray3 = @[@"1_1242x2208",@"2_1242x2208",@"3_1242x2208"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(imageArray1.count * SCREEN_WIDTH, 0);
    //设置属性
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    //添加图片
    for (int i = 0; i < imageArray1.count; i++) {
        UIImageView *imageView = [MYBaseView imageViewWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:nil];
        [self.scrollView addSubview:imageView];
        if (SCREEN_WIDTH < 375) {
            imageView.image = [UIImage imageNamed:imageArray2[i]];
        }else if(SCREEN_WIDTH == 375){
            imageView.image = [UIImage imageNamed:imageArray2[i]];
        }else{
            imageView.image = [UIImage imageNamed:imageArray3[i]];
        }
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        if (i == imageArray1.count - 1) {
            imageView.userInteractionEnabled = YES;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    kWindow.rootViewController = [[MYTabBarViewController alloc] init];
    UserDefaultsSFK(@"", Login_Status);
    UserDefaultsSFK(@{}, User_Info);
    /*if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
        kWindow.rootViewController = [[MYTabBarViewController alloc] init];
    }else{
        TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
        loginVC.isRoot = YES;
        kWindow.rootViewController = loginVC;
    }*/
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
