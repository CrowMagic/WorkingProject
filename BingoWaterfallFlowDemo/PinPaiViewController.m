//
//  PinPaiViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 5/4/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "PinPaiViewController.h"
#import "PinPaiDetailViewController.h"
@interface PinPaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) UISegmentedControl *topSegmentedControl;
@end

@implementation PinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:[self topSelectSegmentControl]];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"leftWhite@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
    /**
     *  设置此代理是为了让从屏幕左边缘返回的手势不失效
     */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
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


- (UISegmentedControl *)topSelectSegmentControl {
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"推荐",@"最新",@"销量"]];
    segmentControl.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    segmentControl.tintColor = [UIColor clearColor];
    
    segmentControl.backgroundColor = [UIColor whiteColor];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateNormal];
    segmentControl.selectedSegmentIndex = 0;
    if (segmentControl.selectedSegmentIndex == 0) {
        [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    }
    
    [segmentControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    return segmentControl;
}

- (void)segmentControlChange:(UISegmentedControl *)sender {
    [sender setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    debugLog(@"我是第%ld个",(long)sender.selectedSegmentIndex);
}


#pragma mark - UITableViewDelegateAndDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cyanColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 160)];
    image.backgroundColor = [UIColor redColor];
    image.image = [UIImage imageNamed:@"brands_bg.jpg"];
    [cell.contentView addSubview:image];

    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UILabel *alabel = [[UILabel alloc] init];
//    alabel.text = @"品牌";
//     alabel.textAlignment = NSTextAlignmentCenter;
//    return alabel;
//    
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 60;
//}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return @"品牌";
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - lazyLoad
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 114) style:UITableViewStylePlain];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
       
//        [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerView"];
        _myTableView.rowHeight = 180;
//        _myTableView.separatorInset = UIEdgeInsetsMake(30, 0, 30, 0);
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PinPaiDetailViewController *pinPaiVC = [[PinPaiDetailViewController alloc]init];
    [self.navigationController pushViewController:pinPaiVC animated:YES];
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
