//
//  TZJiFenStoreViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJiFenStoreViewController.h"
#import "TZJiFenStoreTitleCell.h"
#import "TZJiFenProductsCell.h"
#import "TZNewAddressViewController.h"
#import "TZJFSuccessViewController.h"
#import "TZJFViewModel.h"
#import "TZJFProductModel.h"
#import "TZLoginViewController.h"

@interface TZJiFenStoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZJFViewModel *viewModel;
@property (nonatomic,assign) NSInteger pageNo;

@end

@implementation TZJiFenStoreViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArray removeAllObjects];
            self.pageNo = 1;
            [self fetchProductsData];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self fetchProductsData];
        }];
    }
    return _tableView;
}

- (NSString *)title{
    return @"兑换商城";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self bindingCommand];
    [self fetchProductsData];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZJFViewModel new];
    @weakify(self);
    [[self.viewModel.jfProductCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.dataArray addObjectsFromArray:[TZJFProductModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.tableView reloadData];
        }
    }];
    
    [[self.viewModel.jfExchangeCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            @strongify(self);
            TZJFSuccessViewController *successVC = [[TZJFSuccessViewController alloc] init];
            [self.navigationController pushViewController:successVC animated:YES];
        }
    }];
}

- (void)fetchProductsData{
    NSString *from;
    NSString *to;
    switch (self.jfType) {
        case 0:{
            from = @"10";
            to = @"50";
        }
            break;
        case 1:{
            from = @"50";
            to = @"200";
        }
            break;
        case 2:{
            from = @"200";
            to = @"1000";
        }
            break;
        case 3:{
            from = @"1000";
            to = @"";
        }
            break;
        default:
            break;
    }
    [self.viewModel.jfProductCommand execute:@{@"from":from,@"to":to,@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.dataArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150*kScale;
    }
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TZJiFenStoreTitleCell *cell = [[TZJiFenStoreTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZJiFenStoreTitleCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.picImageView.image = self.titleImage;
        return cell;
    }else{
        TZJiFenProductsCell *cell = [[TZJiFenProductsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZJiFenProductsCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TZJFProductModel *model = self.dataArray[indexPath.row];
        [cell setExchangeBlock:^{
            if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
                if ([MYSingleton shareInstonce].userInfoModel.integral < model.integral) {
                    [SVProgressHUD showErrorWithStatus:@"您的积分不够兑换此商品~"];
                    return ;
                }
                [UIAlertController showAlertInViewController:self withTitle:nil message:@"领确定要兑换吗" cancelButtonTitle:@"点错了" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    if (buttonIndex == 0) {
                        
                    }else{
                        [self.viewModel.jfExchangeCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"integralCommodityId":model.id}];
                    }
                }];
            }else{
                TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
            }
        }];
        [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
}

#pragma mark - tableViewDelagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TZNewAddressViewController *addressVC = [[TZNewAddressViewController alloc] init];
//    [self.navigationController pushViewController:addressVC animated:YES];
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
