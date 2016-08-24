//
//  MasterViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/26/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "MasterViewController.h"
#import "CollectionViewCell.h"
#import "YishuViewController.h"
#import "ss_MasterSearchViewController.h"

//网络请求
#import "ss_MasterModel.h"
#import "ss_MasterRequest.h"



@interface MasterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate> {
//    [BOOL] 
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *recordCellStateArray;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISegmentedControl *topSegmentSelect;//顶部分段控制
//@property (nonatomic, strong) UISearchController *searchController;//导航条的搜索

@property (nonatomic, strong) UISearchBar *topSearchBar;//导航条搜索

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topSegmentSelect];
    self.navigationItem.titleView = self.topSearchBar;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"leftWhite@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
    /**
     *  设置此代理是为了让从屏幕左边缘返回的手势不失效
     */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"消息@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goToChatMessage)];
  
#pragma mark - 大师网络请求
    ss_MasterModel *model = [[ss_MasterModel alloc] init];
    model.pageNumber = 0;
    [ss_MasterRequest ss_MasterHTTPRequestModel:model request:^(NSDictionary *dic) {
        
    }];
    
    self.recordCellStateArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [self.recordCellStateArray addObject:@0];
    }

}

- (void)popCurrentViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToChatMessage {
  
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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    debugLog(@"我是searchBar代理,只是实现了一下跳转,并没有称为第一响应者");
    ss_MasterSearchViewController *vc = [[ss_MasterSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

    return NO;
}




#pragma mark - UICollectionViewDelegateAndDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
//    if ([cell.contentView.subviews lastObject] != nil) {
//        [cell.contentView.subviews.lastObject removeFromSuperview];
//    }
 
//    [self.recordCellStateArray addObject:cell];
    [cell config:indexPath.row andData:self.recordCellStateArray];
    cell.isThumbUpButton.tag = indexPath.row;
    [cell.isThumbUpButton addTarget:self
                             action:@selector(isThumbUpButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    cell.artPicture.image = [UIImage imageNamed:@"artMaster.jpg"];
    cell.artPicture.clipsToBounds = YES;
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30)/2, 250);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"我是第%ld个item",(long)indexPath.item);
    YishuViewController *vc = [[YishuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - lazyLaodUICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:240/255.0 alpha:1];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - 点赞按钮绑定事件

- (void)isThumbUpButtonClick:(UIButton *)sender {
    debugLog(@"我是第%ld个item的点赞按钮",(long)sender.tag);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    sender.selected = !sender.selected;
   
    if (sender.selected == YES) {
        [self.recordCellStateArray setObject:@"0" atIndexedSubscript:indexPath.row];

        cell.thumbUpCount.text = @"123";
        cell.thumbUpCount.textColor = [UIColor blackColor];
        sender.selected = NO;
    } else  {
        [self.recordCellStateArray setObject:@"1" atIndexedSubscript:indexPath.row];

        cell.thumbUpCount.text = @"124";
        cell.thumbUpCount.textColor = [UIColor colorWithRed:251/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        sender.selected = YES;
    }
  
}

#pragma mark - lazyLoadUISearchBar

- (UISearchBar *)topSearchBar {
    if (!_topSearchBar) {
        _topSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
        _topSearchBar.backgroundImage = [UIImage new];
        _topSearchBar.placeholder = @"与大师相遇";
        _topSearchBar.delegate = self;
    }
    return _topSearchBar;
}

#pragma mark - lazyLoadUISegmentedControl

- (UISegmentedControl *)topSegmentSelect {
    if (!_topSegmentSelect) {
        _topSegmentSelect = [[UISegmentedControl alloc] initWithItems:@[@"推荐",@"名气",@"新近"]];
          _topSegmentSelect.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 46);
          _topSegmentSelect.tintColor = [UIColor clearColor];
          [_topSegmentSelect setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateNormal];
          _topSegmentSelect.selectedSegmentIndex = 1;
          if (_topSegmentSelect.selectedSegmentIndex == 1) {
            [_topSegmentSelect setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
          }
        
          [_topSegmentSelect addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _topSegmentSelect;
}

- (void)segmentControlChange:(UISegmentedControl *)sender {
  [sender setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
  debugLog(@"我是第%ld个",(long)sender.selectedSegmentIndex);
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
