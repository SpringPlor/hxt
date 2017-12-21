//
//  TZNewAddressViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNewAddressViewController.h"
#import "TZNewAddressCell.h"
#import "TZAddressDetailCell.h"
#import "TZAddressManageViewController.h"

@interface TZNewAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TZNewAddressViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = rGB_Color(242, 242, 242);
    }
    return _tableView;
}

- (NSString *)title{
    return @"新建地址";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    // Do any additional setup after loading the view.
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 100;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        TZAddressDetailCell *cell = [[TZAddressDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZAddressDetailCell class])];
        return cell;
    }else{
        TZNewAddressCell *cell = [[TZNewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZNewAddressCell class])];
        [cell setCellTitleWithIndex:indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView =[MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) backgroundColor:rGB_Color(242, 242, 242)];
    UIButton *saveButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"保存" titleColor:[UIColor whiteColor] font:kFont(15)];
    [bgView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(15);
        make.top.equalTo(bgView).offset(30);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(40);
    }];
    [saveButton addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.backgroundColor = [UIColor redColor];
    return bgView;
}


#pragma mark - tableViewDelagate

- (void)saveAddress:(UIButton *)sender{
    
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
