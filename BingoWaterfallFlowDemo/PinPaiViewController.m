//
//  PinPaiViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 5/4/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "PinPaiViewController.h"
#import "BrandTableViewCell.h"
#import "PinPaiDetailViewController.h"


#import "BrandModel.h"
#import "BrandRequest.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

#define brandWidth CGRectGetWidth([UIScreen mainScreen].bounds)


@interface PinPaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISegmentedControl *topSegmentedControl;

@property (nonatomic, copy) NSString *recordString;

@property (nonatomic, strong) NSMutableArray *imageArray;//


@end

@implementation PinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.topSegmentedControl];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"leftWhite@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
    /**
     *  设置此代理是为了让从屏幕左边缘返回的手势不失效
     */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
    #pragma mark - 品牌网络请求
    
   
    self.imageArray = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [BrandRequest ss_brandHTTPRequestPara:@"news" request:^(NSMutableArray *object) {
            self.dataSource = object;
            [self.myTableView.header beginRefreshing];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
        
        }];
    });
    
    
    self.recordString = @"news";
    //下拉刷新
    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [BrandRequest ss_brandHTTPRequestPara:self.recordString request:^(NSMutableArray *object) {
            debugLog(@"下拉刷新传递的参数为 = %@", self.recordString);

            [self.dataSource removeAllObjects];
            self.dataSource = object;
            [self.myTableView reloadData];
            [self.myTableView.header endRefreshing];
            
        }];
    }];
    
    // 上拉刷新
    self.myTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [BrandRequest ss_brandHTTPRequestPara:self.recordString request:^(NSMutableArray *object) {
            [self.dataSource addObjectsFromArray:object];
            [self.myTableView reloadData];
            [self.myTableView.footer endRefreshing];
        }];
    }];
    


    
}


- (void)popCurrentViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    //从屏幕左边滑动返回未到一版松手还停留到当前页面，但底部的tabBar会露出来，所以要隐藏
    self.tabBarController.tabBar.hidden = YES;
    //给导航条设置背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBarBg@2x.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}



#pragma mark - UITableViewDelegateAndDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BrandModel *model = self.dataSource[indexPath.row];
    CGFloat logoWidth = model.logoWidth ;
    CGFloat logoHeight = model.logoHeight;
    [cell.brandImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    cell.logoWidth.constant = logoWidth;
    cell.logoHeight.constant = logoHeight;
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandModel *model = self.dataSource[indexPath.row];
    //每个在cell内的图片都有一个10的内边距
    return  brandWidth * model.imageHeight / model.imageWidth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PinPaiDetailViewController *pinPaiVC = [[PinPaiDetailViewController alloc]init];
    [self.navigationController pushViewController:pinPaiVC animated:YES];
}

#pragma mark - lazyLoad

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 60) style:UITableViewStylePlain];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerNib:[UINib nibWithNibName:@"BrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"BrandTableViewCell"];
        _myTableView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - lazyLoadUISegmentControl

- (UISegmentedControl *)topSegmentedControl {
    if (!_topSegmentedControl) {
        _topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"推荐", @"最新", @"销量"]];
        _topSegmentedControl.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
        _topSegmentedControl.tintColor = [UIColor clearColor];
        _topSegmentedControl.backgroundColor = [UIColor whiteColor];
        [_topSegmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateNormal];
        _topSegmentedControl.selectedSegmentIndex = 1;
        if (_topSegmentedControl.selectedSegmentIndex == 1) {
            [_topSegmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
        }
        [_topSegmentedControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _topSegmentedControl;
}

- (void)segmentControlChange:(UISegmentedControl *)sender {
    [sender setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
    debugLog(@"我是第%ld个",(long)sender.selectedSegmentIndex);
    
    //para
    //like 推荐(默认）
    //news最新
    //sale销量
    
//    NSString *para = @"";
    if (sender.selectedSegmentIndex == 0) {//推荐
       self.recordString = @"like";
    } else if (sender.selectedSegmentIndex == 1) {//最新
        self.recordString = @"news";
    } else {//销量
        self.recordString = @"sale";
    }
    debugLog(@"切换页面传递的参数为 = %@", self.recordString);

    [BrandRequest ss_brandHTTPRequestPara:self.recordString request:^(NSMutableArray *object) {
        [self.dataSource removeAllObjects];
        self.dataSource = object;
        [self.myTableView reloadData];
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
