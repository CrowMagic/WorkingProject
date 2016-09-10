//
//  AppreciateViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/22/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "AppreciateViewController.h"
#import "AppreciateCell.h"
//#import "HeaderView.h"
#import "ZidingViewController.h"

//#import <QuartzCore/QuartzCore.h>




#import "AppreciateModel.h"
#import "AppreciateRequest.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"


@interface AppreciateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *appreciateTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *advImageView;//顶部广告位图片
@property (nonatomic, strong) UISegmentedControl *topSegmentSelect;//顶部的名玉鉴定和工艺赏析分段控制
@property (nonatomic, strong) UIButton *leftButton;//左边名玉鉴定按钮
@property (nonatomic, strong) UIButton *rightButton;//右边工艺赏析按钮
@end

@implementation AppreciateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.appreciateTableView];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"leftWhite@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
    /**
     *  设置此代理是为了让从屏幕左边缘返回的手势不失效
     */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
    #pragma mark - 鉴赏网络请求
    
    [AppreciateRequest ss_appreciateHTTPRequest:@"jade" page:@"1" request:^(NSMutableArray *object) {
        self.dataSource = object;
        
        debugLog(@"self.dataSource = %@", self.dataSource);
        
        [self.appreciateTableView reloadData];
    }];
    
    //      #pragma mark - 品牌网络请求
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [BrandRequest ss_brandHTTPRequestPara:@"news" request:^(NSMutableArray *object) {
//            self.dataSource = object;
//            [self.myTableView.header beginRefreshing];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.myTableView reloadData];
//            });
//            
//        }];
//    });
    
    
    //下拉刷新
    self.appreciateTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [AppreciateRequest ss_appreciateHTTPRequest:@"jade" page:@"1" request:^(NSMutableArray *object) {
            [self.dataSource removeAllObjects];
            self.dataSource = object;
            
//            debugLog(@"self.dataSource = %@", self.dataSource);
            
            [self.appreciateTableView reloadData];
            [self.appreciateTableView.header endRefreshing];
        }];
    }];
    
    // 上拉刷新
    self.appreciateTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      
        
        [AppreciateRequest ss_appreciateHTTPRequest:@"jade" page:@"1" request:^(NSMutableArray *object) {
            [self.dataSource addObjectsFromArray:object];
            [self.appreciateTableView reloadData];
            [self.appreciateTableView.footer endRefreshing];

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        [cell.contentView addSubview:self.advImageView];
        return cell;
    } else {
        AppreciateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppreciateCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (indexPath.row == 0) {
//            cell.appreciateImageView.image = [UIImage imageNamed:@"ss_fm.jpg"];
//
//        } else {
//            cell.appreciateImageView.image = [UIImage imageNamed:@"m.jpg"];
//        }
//        
        AppreciateModel *model = self.dataSource[indexPath.row];
        [cell.appreciateImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        cell.firstLineLabel.text = model.title;
        cell.secondLineLabel.text = model.propaganda;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl]];
        
        
        return cell;
    }
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        UIView *myView = [[UIView alloc] init];
        myView.backgroundColor = [UIColor whiteColor];
        [myView addSubview:self.leftButton];
        [myView addSubview:self.rightButton];
        return myView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0001;
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
//        if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                return [UIScreen mainScreen].bounds.size.width * 800/ 600 + 60;
//            } else {
//                
//                //1024 * 683
//                return [UIScreen mainScreen].bounds.size.width * 683 / 1024 + 60;
//            }
//        }
        
        AppreciateModel *model = self.dataSource[indexPath.row];
        return ([UIScreen mainScreen].bounds.size.width - 30) * model.imageHeight / model.imageWidth + 60;
        
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZidingViewController *zVC = [[ZidingViewController alloc]init];
    [self.navigationController pushViewController:zVC animated:YES];
    //self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - lazyLoadSubviews
/**
 *  整个鉴赏页面表的布局
 *
 *  @return 表的实例
 */
- (UITableView *)appreciateTableView {
    if (!_appreciateTableView) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        _appreciateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 64) style:UITableViewStylePlain];
        [_appreciateTableView registerNib:[UINib nibWithNibName:@"AppreciateCell" bundle:nil] forCellReuseIdentifier:@"AppreciateCell"];
        _appreciateTableView.delegate = self;
        _appreciateTableView.dataSource = self;
        _appreciateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _appreciateTableView;
}

/**
 *  顶部广告位图片
 *
 *  @return 图片实例
 */
- (UIImageView *)advImageView {
    if (!_advImageView) {
        _advImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth([UIScreen mainScreen].bounds) - 20, 80)];
        _advImageView.backgroundColor = [UIColor redColor];
    }
    return _advImageView;
}
/**
 *  名玉鉴定
 *
 *  @return 名玉鉴定按钮实例
 */
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(10, 0, ([UIScreen mainScreen].bounds.size.width-26)/2, 40);
        _leftButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];
        [_leftButton setTitle:@"名玉鉴定" forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAddEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
/**
 *  名玉鉴定按钮绑定事件
 *
 *  @param sender 名玉鉴定按钮
 */
- (void)leftButtonAddEvent:(UIButton *)sender {
    sender.backgroundColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];

    self.rightButton.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1];

}
/**
 *  工艺赏析
 *
 *  @return 工艺赏析按钮实例
 */
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(10+6+([UIScreen mainScreen].bounds.size.width-26)/2, 0, ([UIScreen mainScreen].bounds.size.width-26)/2, 40);
        _rightButton.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1];
        [_rightButton setTitle:@"工艺赏析" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAddEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
/**
 *  工艺赏析按钮绑定事件
 *
 *  @param sender 工艺赏析按钮
 */
- (void)rightButtonAddEvent:(UIButton *)sender {
    sender.backgroundColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];

    self.leftButton.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1];
    

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
