//
//  TZBuyGuideViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBuyGuideViewController.h"
#import <UIImage+GIF.h>

@interface TZBuyGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *lineImage;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *showImage;

@end

@implementation TZBuyGuideViewController

- (NSString *)title{
    return @"购买教程";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    NSArray *titleArray = @[@"购买流程",@"积分说明"];
    for (int i = 0; i < 2; i ++){
        UIButton *titleButton = [MYBaseView buttonWithFrame:CGRectMake(i*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40) buttonType:UIButtonTypeCustom title:titleArray[i] titleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] font:kFont(16)];
        [self.view addSubview:titleButton];
        [titleButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateSelected];
        if (i == 0) {
            titleButton.selected = YES;
        }
        titleButton.tag = 1230+i;
        [titleButton addTarget:self action:@selector(switchGuide:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.lineImage = [MYBaseView imageViewWithFrame:CGRectMake(SCREEN_WIDTH/2/2-18, 32, 36, 2.5) andImage:[UIImage imageNamed:@"goumailiuc"]];
    [self.view addSubview:self.lineImage];
    
    UIView *lineView = [MYBaseView viewWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1.0) backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.view addSubview:lineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-64)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 784*kScale+10);
    self.scrollView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    
    self.showImage = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 784*kScale) andImage:[UIImage imageNamed:@"1goumai"]];
    [self.scrollView addSubview:self.showImage];
    
}

- (void)switchGuide:(UIButton *)sender{
    NSArray *imageStrings = @[@"1goumai",@"2jifensm"];
    self.showImage.image = [UIImage imageNamed:imageStrings[sender.tag-1230]];
    for (int i = 0 ;i < 2; i++){
        UIButton *button = (UIButton *)[self.view viewWithTag:1230+i];
        button.selected = NO;
    }
    sender.selected = YES;
    switch (sender.tag-1230) {
        case 0:{
            self.lineImage.image = [UIImage imageNamed:@"goumailiuc"];
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 784*kScale+10);
            self.showImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 784*kScale);
        }
            break;
        case 1:
            self.lineImage.image = [UIImage imageNamed:@"jifenshoum"];
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 630*kScale+10);
            self.showImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 630*kScale);
            break;
        case 2:
            self.lineImage.image = [UIImage imageNamed:@"yueshuom"];
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 557*kScale+10);
            self.showImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 557*kScale);
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.lineImage.frame = CGRectMake((sender.tag-1230)*SCREEN_WIDTH/2+SCREEN_WIDTH/2/2-18, 32, 36, 2.5);
    }];
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
