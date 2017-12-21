//
//  TZKefuViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZKefuViewController.h"
#import "TZKefuHeaderCell.h"
#import "TZKefuQQCell.h"
#import "TZKefuCourseCell.h"
#import "TZKefuCourseModel.h"

@interface TZKefuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *courseArray;
@property (nonatomic,copy) NSArray *qqArray;

@end

@implementation TZKefuViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(242, 242, 242);
    }
    return _tableView;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    
}

- (NSString *)title{
    return @"客服与帮助";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillData];
    [self tableView];
    // Do any additional setup after loading the view.
}

- (void)fillData{
    self.courseArray = [NSMutableArray array];
    NSArray *titleArray = @[@"关于惠享淘",@"邀请朋友下载获得收益",@"积分订单"];
    NSArray *contentArray = @[@"惠享淘，一个专门找优惠券的省钱利器。我们与淘宝天猫商家合作，独家获取内部优惠券。在平台搜索任意商品，都可以获得高额优惠券进行购买",@"朋友使用您的邀请码下载并注册app，当他购买商品时，您可以返回一定数量的余额，并可以提现到支付宝",@"在平台上购买的商品，当结算完成后，都可以反还积分，可以在积分商城里兑换喜欢的礼品。"];
    for (int i = 0 ; i < 3 ; i++){
        TZKefuCourseModel *model = [[TZKefuCourseModel alloc] init];
        model.title = titleArray[i];
        model.content = contentArray[i];
        model.isSpread = NO;
        model.height = 55+[NSString stringHightWithString:model.content size:CGSizeMake(SCREEN_WIDTH-30-20, MAXFLOAT) font:kFont(14) lineSpacing:defaultLineSpacing].height;
        [self.courseArray addObject:model];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 38;
        }
        return 65;
    }else{
        if (indexPath.row == 0) {
            return 38;
        }else{
            TZKefuCourseModel *model = self.courseArray[indexPath.row-1];
            if (model.isSpread) {
                NSLog(@"%f",model.height);
                return model.height;
            }
            return 67;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TZKefuHeaderCell *cell = [[TZKefuHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZKefuHeaderCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            TZKefuQQCell *cell = [[TZKefuQQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZKefuQQCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setCellInfoWithIndex:indexPath.row];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            TZKefuHeaderCell *cell = [[TZKefuHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZKefuHeaderCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.iconImageView.image = [UIImage imageNamed:@"bangzhujiaocheng"];
            cell.titleLabel.text = @"帮助教程";
            return cell;
        }else{
            TZKefuCourseCell *cell = [[TZKefuCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZKefuCourseCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __block TZKefuCourseModel *model = self.courseArray[indexPath.row-1];
            [cell setCellInfoWithModel:model];
            [cell setSpreadBlock:^(BOOL isSpread){
                model.isSpread = isSpread;
                [self.courseArray replaceObjectAtIndex:indexPath.row-1 withObject:model];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            return cell;
        }
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
