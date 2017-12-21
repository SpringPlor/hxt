//
//  TZCouponsViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZCouponsViewController.h"
#import "TZHomeSearchView.h"
#import "TZSearchProductViewController.h"
#import "TZHomeItemModel.h"
#import "HomeItemDropView.h"
#import "TZHomeCategoryViewController.h"

@interface TZCouponsViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) TZHomeSearchView *searchView;
@property (nonatomic,strong) UIImageView *guideImageView;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) UIScrollView *guideScrollView;
@property (nonatomic,strong) UIButton *allButton;
@property (nonatomic,strong) HomeItemDropView *dropView;

@end

@implementation TZCouponsViewController

- (TZHomeSearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[TZHomeSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [kWindow addSubview:_searchView];
        _searchView.alpha = 0;
        _searchView.hidden = YES;
        WeakSelf(self);
        [_searchView setCancelBlock:^{
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.searchView.alpha = 0;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];
            } completion:^(BOOL finished) {
                weakSelf.searchView.hidden = YES;
            }];
        }];
        [_searchView setSearchBlock:^(NSString *keyWord){
            weakSelf.searchView.alpha = 0;
            weakSelf.searchView.hidden = YES;
            weakSelf.navigationController.navigationBarHidden = NO;
            TZSearchProductViewController *searchVC = [[TZSearchProductViewController alloc] init];
            searchVC.searchKeyword = keyWord;
            searchVC.autSearchTB = YES;
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
        }];
    }
    return _searchView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MYSingleton shareInstonce].tabBarView.hidden = NO;
    [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [MYSingleton shareInstonce].tabBarView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rGB_Color(241, 242, 243);
    [self searchView];
    [self initView];
    //[self guideView];
    // Do any additional setup after loading the view.
}

- (void)guideView{
    NSString *guide = [[NSUserDefaults standardUserDefaults] objectForKey:@"couponSearchGuide"];
    if (guide == nil) {
        self.guideImageView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:[UIImage imageNamed:@"couponSearchGuide"]];
        [kWindow addSubview:self.guideImageView];
        self.guideImageView.userInteractionEnabled = YES;
        WeakSelf(self);
        [self.guideImageView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
            [weakSelf.guideImageView removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setObject:@"couponSearchGuide" forKey:@"couponSearchGuide"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }]];
    }
}

- (void)initView{
    
    CGFloat itemWidth = (SCREEN_WIDTH-30-20)/3;
    CGFloat itemHeight = itemWidth*150/216;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 192*kScale+58+30+itemHeight*2+10+(SCREEN_WIDTH-30)*1339/347+7);
    
    UIImageView *blackBgView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 192*kScale) andImage:[UIImage imageNamed:@"di"]];
    [self.scrollView addSubview:blackBgView];
    blackBgView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝天猫海量优惠券等你拿" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(18)];
    [blackBgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blackBgView);
        make.top.equalTo(blackBgView).offset(57*kScale);
    }];
    
    UIImageView *searchBgView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"sousuok"]];
    [blackBgView addSubview:searchBgView];
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blackBgView);
        make.top.equalTo(titleLabel.mas_bottom).offset(8*kScale);
        make.left.equalTo(blackBgView).offset(15);
        make.height.mas_equalTo(47*kScale);
    }];
    searchBgView.userInteractionEnabled = YES;
    [searchBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchProduct)]];
    
    UIImageView *searchIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"sous"]];
    [searchBgView addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBgView);
        make.left.equalTo(searchBgView).offset(24);
        make.width.height.mas_equalTo(15.5);
    }];
    
    UILabel *placeholderLabel = [MYBaseView labelWithFrame:CGRectZero text:@"输入商品或粘贴淘宝标题" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
    [blackBgView addSubview:placeholderLabel];
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchIcon.mas_right).offset(7);
        make.centerY.equalTo(searchBgView);
    }];
    
    UILabel *searchLabel = [MYBaseView labelWithFrame:CGRectZero text:@"搜索" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight andFont:kFont(14)];
    [searchBgView addSubview:searchLabel];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBgView);
        make.right.equalTo(searchBgView.mas_right).offset(-22*kScale);
    }];
    
    self.guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 192*kScale-50, SCREEN_WIDTH-60, 40)];
    [blackBgView addSubview:self.guideScrollView];
    self.guideScrollView.showsHorizontalScrollIndicator = NO;
    self.guideScrollView.delegate = self;
    
    CGFloat leftDistance = 0;
    NSArray *itemArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeItem" ofType:@"plist"]];
    self.itemArray = [NSMutableArray array];
    for (int i = 0; i < itemArray.count; i++){
        TZHomeItemModel *itemModel = [TZHomeItemModel mj_objectWithKeyValues:itemArray[i]];
        itemModel.width = [NSString stringHightWithString:itemModel.title size:CGSizeMake(MAXFLOAT, 40) font:kFont(16) lineSpacing:defaultLineSpacing].width;
        [self.itemArray addObject:itemModel];
    }
    [self.itemArray removeObjectAtIndex:0];
    
    for (int i = 0; i < self.itemArray.count; i ++){
        TZHomeItemModel *itemModel = self.itemArray[i];
        UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:itemModel.title titleColor:[UIColor whiteColor] font:kFont(16)];
        [self.guideScrollView addSubview:itemButton];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.guideScrollView);
            make.left.equalTo(self.guideScrollView).offset(leftDistance);
            make.width.mas_equalTo(30+itemModel.width);
            make.height.mas_equalTo(40);
        }];
        leftDistance = leftDistance + 30 + itemModel.width;
        itemButton.tag = 100+i;
        if (i == 0) {
            itemButton.selected = YES;
        }
        [itemButton addTarget:self action:@selector(switchItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.guideScrollView.contentSize = CGSizeMake(leftDistance, 40);
    
    UIView *coverView = [MYBaseView viewWithFrame:CGRectMake(SCREEN_WIDTH-70, 192*kScale-50, 25, 40) backgroundColor:nil];
    [self.scrollView addSubview:coverView];
    CAGradientLayer*layer = [CAGradientLayer layer];
    UIColor* inputColor0 =  [UIColor colorWithRed:241/255.0 green:77/255.0 blue:85/255.0 alpha:0];
    UIColor* inputColor1 = [UIColor colorWithRed:241/255.0 green:77/255.0 blue:85/255.0 alpha:1];
    layer.colors = @[(id)inputColor0.CGColor,(id)inputColor1.CGColor];
    CGPoint inputPoint0 = CGPointMake(0,0);
    CGPoint inputPoint1 = CGPointMake(1.0,0);
    layer.startPoint= inputPoint0;
    layer.endPoint= inputPoint1;
    layer.frame = coverView.bounds;
    [coverView.layer addSublayer:layer];
    
    
    self.allButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"leimu"] selectImage:nil];
    [self.scrollView addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.guideScrollView);
        make.width.height.mas_equalTo(15);
    }];
    self.allButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -20);
    [self.allButton addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView *searchIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"sous"]];
//    [blackBgView addSubview:searchIcon];
//    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(searchBgView);
//        make.right.equalTo(placeholderLabel.mas_left).offset(-6);
//    }];
    
    UIView *whiteBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:whiteBgView];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(blackBgView.mas_bottom).offset(-7);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(58+30+itemHeight*2+10);
    }];
    whiteBgView.layer.cornerRadius = 5;
    whiteBgView.clipsToBounds = YES;
    
    UIImageView *hotImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"resou"]];
    [whiteBgView addSubview:hotImageView];
    [hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBgView).offset(15);
        make.top.equalTo(whiteBgView).offset(20);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(14);
    }];
    
    UILabel *hotLabel = [MYBaseView labelWithFrame:CGRectZero text:@"正在热搜" textColor:[UIColor redColor] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
    [whiteBgView addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotImageView.mas_right).offset(5);
        make.centerY.equalTo(hotImageView);
    }];

    NSArray *colorArray = @[@"#e0eaf3",@"#ffefd1",@"#fedee1",@"#f9eef5",@"#dce5e4",@"#f3f0e8"];
    NSArray *nameArray = @[@"长裤",@"零食",@"洗护",@"手机壳",@"数码家电",@"休闲鞋"];
    NSArray *desArray = @[@"精选挑选",@"吃货必备",@"特价销售",@"带壳更美",@"品质生活",@"舒适生活"];
    NSArray *imageArray = @[@"ku",@"lingshi",@"xihu",@"shoujike",@"jiadian",@"xie"];
    for (int i = 0; i < 6; i ++){
        UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
        [whiteBgView addSubview:itemButton];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteBgView).offset(15+((itemWidth+10)*(i%3)));
            make.top.equalTo(whiteBgView).offset(48+(itemHeight+10)*(i/3));
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
        }];
        itemButton.backgroundColor = [UIColor colorWithHexString:colorArray[i] alpha:1.0];
        itemButton.layer.cornerRadius = 5;
        [itemButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag = 2500+i;
        
        UILabel *nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nameArray[i] textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11*kScale)];
        [itemButton addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(itemButton).offset(6*kScale);
            make.centerY.equalTo(itemButton.mas_centerY).offset(-8);
        }];
        
        UILabel *desLabel = [MYBaseView labelWithFrame:CGRectZero text:desArray[i] textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11*kScale)];
        [itemButton addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.centerY.equalTo(itemButton.mas_centerY).offset(8);
        }];
        
        UIImageView *picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:imageArray[i]]];
        [itemButton addSubview:picImageView];
        if (i == 0) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemButton).offset(-5*kScale);
                make.bottom.equalTo(itemButton.mas_bottom);
                make.width.mas_equalTo(35*kScale);
                make.height.mas_equalTo(59*kScale);
            }];
        }
        if (i == 1) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemButton.mas_centerY).offset(5);
                make.right.equalTo(itemButton).offset(-5*kScale);
                make.width.mas_equalTo(40*kScale);
                make.height.mas_equalTo(52*kScale);
            }];
        }
        if (i == 2) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemButton);
                make.right.equalTo(itemButton).offset(-5*kScale);
                make.width.mas_equalTo(40*kScale);
                make.height.mas_equalTo(49*kScale);
            }];
        }
        if (i == 3) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemButton).offset(-5*kScale);
                make.bottom.equalTo(itemButton.mas_bottom);
                make.width.mas_equalTo(33*kScale);
                make.height.mas_equalTo(58*kScale);
            }];
        }
        if (i == 4) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemButton.mas_right);
                make.centerY.equalTo(itemButton);
                make.width.mas_equalTo(49*kScale);
                make.height.mas_equalTo(51*kScale);
            }];
        }
        if (i == 5) {
            [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemButton.mas_right);
                make.centerY.equalTo(itemButton);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(43);
            }];
        }
    }
    
    UIView *longBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(241, 242, 243)];
    [self.scrollView addSubview:longBgView];
    [longBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteBgView.mas_bottom).offset(-5);
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo((SCREEN_WIDTH-30)*1339/347+7);
    }];
    longBgView.layer.cornerRadius = 7;
    longBgView.clipsToBounds = YES;
    
    UIImageView *longImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"zhinan"]];
    [self.scrollView addSubview:longImageView];
    [longImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(15);
        make.top.equalTo(longBgView).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo((SCREEN_WIDTH-30)*1339/347);
    }];
}

- (void)searchProduct{
    [MobClick event:souyouhuiquan];
    [self.searchView loadSearchRecord];
    self.searchView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 1;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];
    }];
}

- (void)switchItem:(UIButton *)sender{
    TZHomeItemModel *itemModel = self.itemArray[sender.tag-100];
    TZHomeCategoryViewController *categoryVC = [[TZHomeCategoryViewController alloc] init];
    categoryVC.title = itemModel.title;
    categoryVC.sort = itemModel.type;
    [self.navigationController pushViewController:categoryVC animated:YES];
}

//展开全部
- (void)showAll:(UIButton *)sender{
    self.dropView = [[HomeItemDropView alloc] initWithFrame:CGRectMake(0, 192*kScale-7, SCREEN_WIDTH, 180)];
    [kWindow addSubview:self.dropView];
    WeakSelf(self);
    [self.dropView setTapBlock:^(TZHomeItemModel *itemModel){
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.dropView.whiteBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            [weakSelf.dropView.bgView removeFromSuperview];
            [weakSelf.dropView  removeFromSuperview];
            if (itemModel) {
            }
        }];
        if (itemModel) {
            UserDefaultsSFK([itemModel mj_keyValues], Home_Item);
            //改变滚动视图上item颜色
            TZHomeCategoryViewController *categoryVC = [[TZHomeCategoryViewController alloc] init];
            categoryVC.title = itemModel.title;
            categoryVC.sort = itemModel.type;
            [weakSelf.navigationController pushViewController:categoryVC animated:YES];
        }
    }];
}

- (void)searchAction:(UIButton *)sender{
    NSArray *nameArray = @[@"长裤",@"零食",@"洗护",@"手机壳",@"数码",@"休闲鞋"];
    TZSearchProductViewController *searchVC = [[TZSearchProductViewController alloc] init];
    searchVC.searchKeyword = nameArray[sender.tag-2500];
    searchVC.autSearchTB = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    switch (sender.tag - 2500) {
        case 0:
            [MobClick event:changku];
            break;
        case 1:
            [MobClick event:lingshi];
            break;
        case 2:
            [MobClick event:xihu];
            break;
        case 3:
            [MobClick event:shoujike];
            break;
        case 4:
            [MobClick event:jingjiezhipin];
            break;
        case 5:
            [MobClick event:xiuxiasnxie];
            break;
        default:
            break;
    }
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
