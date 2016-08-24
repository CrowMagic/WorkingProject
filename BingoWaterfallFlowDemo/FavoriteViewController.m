//
//  FavoriteViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/25.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FirstSemTableViewController.h"
#import "LikeViewController.h"
@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arr = [NSArray arrayWithObjects:@"宝贝",@"店铺", nil];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:self.arr];
    self.segmentControl.frame = CGRectMake(wKscreen/2-50, 10, 100, self.navigationController.navigationBar.frame.size.height-10);
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentControl;
    
    self.lVC = [[LikeViewController alloc]init];
    self.vc = [[FirstSemTableViewController alloc]init];
    
    _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hKscreen)];
    //_sv.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_sv];
    _sv.bounces = NO;
    //_sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //_sv.contentOffset = CGPointMake(0, 0);
    _sv.pagingEnabled = YES;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.scrollEnabled = YES;
    _sv.userInteractionEnabled = YES;
    _sv.delegate = self;
    
    
    self.lVC.view.frame = CGRectMake(0, 0, wKscreen, hKscreen-30);
    [_sv addSubview:self.lVC.view];
    
    self.vc.view.frame = CGRectMake(wKscreen, 0, wKscreen, hKscreen-30);
    [_sv addSubview:self.vc.view];
    
    
    _sv.contentSize = CGSizeMake(2 * wKscreen, 0);
    
    [self addChildViewController:self.lVC];
    [self addChildViewController:self.vc];
}
-(void)segmentAction:(id)sender
{
    CGPoint offset = self.sv.contentOffset;
    offset.x = self.view.frame.size.width * self.segmentControl.selectedSegmentIndex;
    [UIView animateWithDuration:0.3 animations:^{
        self.sv.contentOffset = offset;
    }];
}

-(void)leftAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
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
