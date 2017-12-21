//
//  TZJHSViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJHSViewController.h"
#import "TZHomeItemModel.h"
#import "TZSearchProductCell.h"
#import "TZSearchHeaderView.h"
#import "TZJHSViewModel.h"
#import "TZSearchProductViewModel.h"
#import "TZProductDetailViewController.h"

@interface TZJHSViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UIScrollView *guideScrollView;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) NSInteger itemIndex;
@property (nonatomic,copy) NSString *order;//排序方式
@property (nonatomic,assign) BOOL resetHeader;//是否需要重置header
@property (nonatomic,strong) TZJHSViewModel *jhsViewModel;
@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;

@end

@implementation TZJHSViewController

//导购item
- (void)initGuideView{
    NSMutableArray *itemArray =  [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeItem" ofType:@"plist"]];//[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeItem" ofType:@"plist"]];
    [itemArray removeObjectAtIndex:0];//删除今日精选
    [itemArray insertObject:@{@"title":@"全部",@"type":@"all"} atIndex:0];//添加全部
    self.itemArray = [NSMutableArray array];
    for (int i = 0; i < itemArray.count; i++){
        TZHomeItemModel *itemModel = [TZHomeItemModel mj_objectWithKeyValues:itemArray[i]];
        itemModel.width = [NSString stringHightWithString:itemModel.title size:CGSizeMake(MAXFLOAT, 40) font:kFont(16) lineSpacing:defaultLineSpacing].width;
        [self.itemArray addObject:itemModel];
        NSLog(@"%f",itemModel.width);
    }
    
    self.guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.guideScrollView];
    self.guideScrollView.showsHorizontalScrollIndicator = NO;
    self.guideScrollView.delegate = self;
    
    CGFloat leftDistance = 0;
    for (int i = 0; i < itemArray.count; i ++){
        TZHomeItemModel *itemModel = self.itemArray[i];
        UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:itemModel.title titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(16)];
        [self.guideScrollView addSubview:itemButton];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.guideScrollView);
            make.left.equalTo(self.guideScrollView).offset(leftDistance);
            make.width.mas_equalTo(30+itemModel.width);
            make.height.mas_equalTo(40);
        }];
        leftDistance = leftDistance + 30 + itemModel.width;
        [itemButton setTitleColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] forState:UIControlStateSelected];
        itemButton.tag = 100+i;
        if (i == 0) {
            itemButton.selected = YES;
        }
        [itemButton addTarget:self action:@selector(switchItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.guideScrollView.contentSize = CGSizeMake(leftDistance, 40);
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        if ([self.title isEqualToString:@"9.9包邮"]) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) collectionViewLayout:_flowLayout];
        }else{
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
        }
        [self.view addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
        [_collectionView registerClass:[TZSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZSearchHeaderView class])];
        _collectionView.backgroundColor = rGB_Color(240, 240, 240);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 0;
            [self.modelArray removeAllObjects];
            [self loadDawanjiaDataWithModel:self.itemArray[self.itemIndex] start:_pageNo order:_order];
        }];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self loadMoreDawanjiaDataWithModel:self.itemArray[self.itemIndex] start:_pageNo order:_order];
        }];
    }
    return _collectionView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGuideView];
    [self collectionView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.modelArray = [NSMutableArray array];
    _pageNo = 0;//页数置0；
    _order = @"default";
    self.searchViewModel = [TZSearchProductViewModel new];
    @weakify(self)
    [[self.searchViewModel.searchCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *products) {
        @strongify(self)
        if (_pageNo == 0) {
            [self.modelArray removeAllObjects];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.modelArray addObjectsFromArray:[TZSearchProductModel mj_objectArrayWithKeyValuesArray:products]];
        [self.collectionView reloadData];
        if (_pageNo == 0) {
            self.collectionView.contentOffset=CGPointMake(0, 0);
        }
    }];
    [self loadDawanjiaDataWithModel:self.itemArray[0] start:_pageNo order:_order];
}

#pragma mark - Action
- (void)switchItem:(UIButton *)sender{
    if (_itemIndex == sender.tag - 100) {//点击与上次相同
        return;
    }
    _pageNo = 0;//页数置0；
    _order = @"default";
    _resetHeader = YES;
    _itemIndex = sender.tag - 100;
    for (int i = 0 ; i < self.itemArray.count; i++){
        UIButton *tempBtn = (UIButton *)[self.view viewWithTag:100+i];
        tempBtn.selected = NO;
    }
    sender.selected = YES;
    self.itemIndex = sender.tag -100;
    [self loadDawanjiaDataWithModel:self.itemArray[sender.tag-100] start:_pageNo order:_order];
}

- (void)loadDawanjiaDataWithModel:(TZHomeItemModel *)model start:(NSInteger)start order:(NSString *)order{
    if (order == nil) {
        order = @"default";
    }
    [self.searchViewModel.searchCommand execute:@{@"q":self.q,@"sort":model.type,@"order":order,@"start":[NSString stringWithFormat:@"%ld",start*20],@"limit":@"20"}];
}

- (void)loadMoreDawanjiaDataWithModel:(TZHomeItemModel *)model start:(NSInteger)start order:(NSString *)order{
    if (order == nil) {
        order = @"default";
    }
    [self.searchViewModel.searchCommand execute:@{@"q":self.q,@"sort":model.type,@"order":order,@"start":[NSString stringWithFormat:@"%ld",start*20],@"limit":@"20"}];
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        TZSearchHeaderView *headerView = (TZSearchHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZSearchHeaderView class]) forIndexPath:indexPath];
        if (self.resetHeader) {
            [headerView resetHeader];
            self.resetHeader = NO;
        }
        [headerView setTapBlcok:^(NSString *order){
            _pageNo = 0;
            _order = order;
            [_collectionView.mj_header beginRefreshing];
        }];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.modelArray.count) {
        [cell setCellInfoWithDWJModel:self.modelArray[indexPath.row]];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
    if (indexPath.row < self.modelArray.count) {
        detailVC.productModel = self.modelArray[indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
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
