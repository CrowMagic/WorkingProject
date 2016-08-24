//
//  ActivityViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/28/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "ActivityViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "ActivityCollectionViewCell.h"
#import "TimeViewController.h"

#import "MXPullDownMenu.h"

#define  WIDTH (([UIScreen mainScreen].bounds.size.width - 30)/2)



@interface ActivityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout,UICollectionViewDelegateFlowLayout, MXPullDownMenuDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISegmentedControl *topSelectSegmentControl;
@property (nonatomic, strong) MXPullDownMenu *menu;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
//    _topSelectSegmentControl.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 40);

    NSArray *array = @[@[@"按类型",@"全部",@"满立减",@"满就送",@"积分兑换",@"限时折扣"], @[@"按时间",@"全部",@"三天内"]];
    self.menu = [[MXPullDownMenu alloc] initWithArray:array selectedColor:[UIColor greenColor]];
    self.menu.delegate = self;
    self.menu.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    [self.view addSubview:self.menu];
//    [self.view addSubview:self.topSelectSegmentControl];
    
    
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
    [super viewWillAppear:animated];
    
    //从屏幕左边滑动返回未到一版松手还停留到当前页面，但底部的tabBar会露出来，所以要隐藏
    self.tabBarController.tabBar.hidden = YES;

    //给导航条设置背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBarBg@2x.png"] forBarMetrics:UIBarMetricsDefault];
}



// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%ld -- %ld", (long)column, (long)row);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
          
            self.topSelectSegmentControl.alpha = 0;
            self.menu.alpha = 0;
            
        }];

    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.topSelectSegmentControl.alpha = 1;
            self.menu.alpha = 1;
            
        }];

    }
}

#pragma mark - UICollectionViewDelegateAndDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActivityCollectionViewCell" forIndexPath:indexPath];
    cell.activityImageView.image = [UIImage imageNamed:@"m.jpg"];
    if (indexPath.row == 5) {
        cell.activityImageView.image = [UIImage imageNamed:@"sp1.png"];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TimeViewController *tVC = [[TimeViewController alloc]init];
    [self.navigationController pushViewController:tVC animated:YES];
}
#pragma mark - UICollectionViewDelegateWaterfallLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //m.jpg 1024 * 683
    // sp1.png 205/310 = width /h
    if (indexPath.row == 5) {
        return WIDTH * 310 / 205 + 100;
    } else {
        return WIDTH * 683 / 1024 + 100;
    }
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//        UICollectionReusableView *aView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
//        aView.backgroundColor = [UIColor redColor];
//    aView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
//    return aView;
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
////    if (section>0) {
//        return CGSizeMake(0, 44);
////    }
////    return CGSizeZero;
//}

#pragma mark - lazyLoadUICollectionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewWaterfallLayout * layout = [[UICollectionViewWaterfallLayout alloc]init];
        //上、左、下、右  边距
        layout.sectionInset = UIEdgeInsetsMake(50, 10, 10, 10);
        //item 的宽度；item高度不一致，通过协议方法设置
        layout.itemWidth = WIDTH ;
        //列数目
        layout.columnCount = 2;
        //设置代理
        layout.delegate = self ;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        [_collectionView registerNib:[UINib nibWithNibName:@"ActivityCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ActivityCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - lazyLoadUISegmentedControl
         
- (UISegmentedControl *)topSelectSegmentControl {
    if (!_topSelectSegmentControl) {
        _topSelectSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"按类型", @"按时间"]];
    }
    _topSelectSegmentControl.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    _topSelectSegmentControl.tintColor = [UIColor clearColor];
    
    _topSelectSegmentControl.backgroundColor = [UIColor whiteColor];
    [_topSelectSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateNormal];
    _topSelectSegmentControl.selectedSegmentIndex = 0;
    if (_topSelectSegmentControl.selectedSegmentIndex == 0) {
        [_topSelectSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
    }
    
    [_topSelectSegmentControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];

    return _topSelectSegmentControl;
}

#pragma mark - UISegmentedControlClickEvent

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
