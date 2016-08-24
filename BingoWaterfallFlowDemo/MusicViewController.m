//
//  MusicViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MusicViewController.h"
#import "LinkStoreViewController.h"
@interface MusicViewController ()<UIScrollViewDelegate,MusicScrollViewDelegate>
@property(nonatomic,strong)NSArray *arr;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.musicScrollView = [[MusicScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, 2*hKscreen)];
    self.musicScrollView.contentSize = CGSizeMake(wKscreen, 3*hKscreen);
    self.musicScrollView.backgroundColor = [UIColor whiteColor];
    self.musicScrollView.delegate = self;
    [self.view addSubview: self.musicScrollView];
    [self.view addSubview:self.musicScrollView.buyBtn];
    [self.view addSubview:self.musicScrollView.immeBuyBtn];
    self.navigationController.navigationBarHidden = YES;
    self.musicScrollView.userInteractionEnabled = YES;
    self.musicScrollView.showsVerticalScrollIndicator = NO;
    [self.musicScrollView.shipButton addTarget:self action:@selector(myAction ) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ButtonActionToSctollViewWithIndex:(NSInteger)index
{
    self.arr = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"1.jpg",@"2.jpg",@"1.jpg", nil];
    self.musicScrollView.bossImageView.image = [UIImage imageNamed:@"list"];
    
}
-(void)myAction
{
    LinkStoreViewController *vc = [[LinkStoreViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"controller点击");
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
