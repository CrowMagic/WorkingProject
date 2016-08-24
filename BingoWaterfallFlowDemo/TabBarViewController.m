//
//  TabBarViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/19.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "ViewController.h"

#import "ThirdViewController.h"
#import "LogisticsViewController.h"
#import "MineViewController.h"
#import "MyViewController.h"
//shopCarController
#import "ShoppingCartViewController.h"
@interface TabBarViewController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UIButton* button;
@property(nonatomic,strong)UILabel *redlabel;
@property(nonatomic,assign)NSInteger num;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*需求：我的项目的主要框架是tabbar
    自定义了我的tabbar，创建了一个类，继承自UITabBarController，然后就是一系列的我们写得不能在熟的代码了，引入viewcontroller的头文件，然后实例化，将viewcontroller都做成带导航的，在将这个数组赋给tabbar·像这样 */
    // Do any additional setup after loading the view.
    UINavigationController *firstNC = [[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
    // firstNC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:101];
    firstNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"shouye@2x"] tag:101];
    [firstNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"shouyeClick@2x"]];
    //firstNC.tabBarItem.title = @"首页";
   
    UINavigationController *viewNC = [[UINavigationController alloc]initWithRootViewController:[[ThirdViewController alloc]init]];
    //viewNC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:102];
    viewNC.tabBarItem.badgeValue = @"10";
    viewNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"fenlei@2x"] tag:102];
    //[viewNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"fenleiClick@2x"]];
    //viewNC.tabBarItem.title = @"分类";
    
    UINavigationController *secondNC = [[UINavigationController alloc]initWithRootViewController:[[ShoppingCartViewController alloc]init]];
    //secondNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:103];
    //secondNC.tabBarItem.title = @"产品";
    //secondNC.tabBarItem.badgeValue = @"99";
    
    UINavigationController *thirdNC = [[UINavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]];
    //thirdNC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:104];
    thirdNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"my@2x"] tag:103];
    [thirdNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"myClick@2x"]];
    //thirdNC.tabBarItem.title = @"我的";
    
    UINavigationController *fourNC = [[UINavigationController alloc]initWithRootViewController:[[LogisticsViewController alloc]init]];
    //fourNC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:105];
    fourNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"物流" image:[UIImage imageNamed:@"wuliu@2x"] tag:104];
    [fourNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"wuliuClick@2x"]];
    //fourNC.tabBarItem.title = @"物流";
    
    self.tabBar.tintColor = [UIColor colorWithRed:0 green:0.7 blue:0 alpha:1.0];
    self.viewControllers = @[firstNC,viewNC,secondNC,thirdNC,fourNC];
    self.selectedIndex = 0;
    //购物车tabbar突出效果
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 49, 49)];
    _button.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, 49/2);
    self.delegate = self;
    //_button.selected = YES;//换页和button的状态关联上
    [_button setImage:[UIImage imageNamed:@"carnomal"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"carselect"] forState:UIControlStateSelected];
    
    [_button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:_button];
    //购物车tabbar显示数字
    _num = 8;
    
        self.redlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.redlabel.center = CGPointMake(CGRectGetWidth(self.button.frame)/2, CGRectGetHeight(self.button.frame)/6);
        self.redlabel.backgroundColor = [UIColor redColor];
        self.redlabel.textColor = [UIColor whiteColor];
        self.redlabel.layer.masksToBounds = YES;
        self.redlabel.layer.cornerRadius = CGRectGetHeight(self.redlabel.frame)/2;
    if (_num > 0 && _num < 100) {
        
        self.redlabel.text = [NSString stringWithFormat:@"%ld",self.num];
        
    }
    if (_num > 99) {
        self.redlabel.text = [NSString stringWithFormat:@"99+"];
    }
    self.redlabel.textAlignment = UITextAlignmentCenter;
    self.redlabel.font = [UIFont systemFontOfSize:13.0];
    //[self.button addSubview:_redlabel];
    
        
  
    
    
   // [self.tabBar setShadowImage:(@"transparent")];
}


-(void)add:(UIButton *)sender
{
    self.selectedIndex = 2;
//    _button.selected = YES;
    if (_button.selected == YES) {
        [_button setImage:[UIImage imageNamed:@"carnomal"] forState:UIControlStateNormal];
    }
    else
    {
        [_button setImage:[UIImage imageNamed:@"carselect"] forState:UIControlStateSelected];
    }
    _button.selected = !_button.selected;
    
}
//换页和button的状态关联上
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex == 2) {
        _button.selected = YES;
    }
    else
    {
        _button.selected = NO;
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
