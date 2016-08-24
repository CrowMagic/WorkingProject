//
//  PinPaiDetailViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 5/16/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "PinPaiDetailViewController.h"
#import "TitleView.h"
#import "DetailTableViewController.h"
@interface PinPaiDetailViewController ()<TitleViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)TitleView *titleView;

@property (nonatomic,strong)UIViewController *currentVC;

@property (nonatomic,assign)NSInteger lastIndex;
@end

@implementation PinPaiDetailViewController
-(void)loadView
{
    self.titleView = [[TitleView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _titleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentIndex = 0;
    self.titleView.delegate = self;
    self.titleView.mainScrollView.delegate = self;
    //UIButton *button = (UIButton *)[self.titleView.headerView viewWithTag:100];
    //button.transform = CGAffineTransformScale(button.transform, 1.2, 1.2);
    //[button setTintColor:[UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]];
    [self addChildVC];
}
- (void)addChildVC
{
    for (int i = 0; i < 4; i ++) {
        DetailTableViewController *childVC = [[DetailTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        childVC.index = i;
        [self addChildViewController:childVC];
    }
    DetailTableViewController *firstVC = self.childViewControllers[0];
    self.currentVC = firstVC;
    firstVC.view.frame = CGRectMake(0, 0, wKscreen, CGRectGetHeight(self.titleView.mainScrollView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame) - 64);
    [self.titleView.mainScrollView addSubview:firstVC.view];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = self.titleView.mainScrollView.contentOffset.x / wKscreen;
    [self getMainScrollViewOffestWithIndex:index];
}
-(void)ButtonActionToScrollTableViewWithIndex:(NSInteger)index
{
    self.titleView.mainScrollView.contentOffset = CGPointMake(index * wKscreen, 0);
    [self getMainScrollViewOffestWithIndex:index];
}
// 小标题Button字体颜色变化
- (void)getMainScrollViewOffestWithIndex:(NSInteger)index
{
    if (index == self.currentIndex) {
        return;
    }
    // Button按钮效果
    /*for (int i = 100; i < 104; i ++) {
        UIButton *button = (UIButton *)[self.titleView.headerView viewWithTag:i];
        if (i == 100 + index) {
            [UIView animateWithDuration:0.3f animations:^{
                
                [button setTintColor:[UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]];
                button.transform = CGAffineTransformScale(button.transform, 1.2, 1.2);
            }];
        }
        if (i == 100 + self.lastIndex) {
            [UIView animateWithDuration:0.3f animations:^{
                
                button.transform = CGAffineTransformScale(button.transform, 1/1.2,1/1.2);
                
            }];
        }
    }*/
    self.lastIndex = index;
    // 切换当前ChildController
    [self transitionFromViewController:self.currentVC toViewController:self.childViewControllers[index] duration:0.5f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            [self.currentVC.view removeFromSuperview];
            DetailTableViewController *childVC = self.childViewControllers[index];
            childVC.view.frame = CGRectMake(wKscreen *index, 0, wKscreen, CGRectGetHeight(self.titleView.mainScrollView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame) - 64);
            [self.titleView.mainScrollView addSubview:childVC.view];
            self.currentVC = childVC;
        }
    }];
    
    self.currentIndex = index;
    
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
