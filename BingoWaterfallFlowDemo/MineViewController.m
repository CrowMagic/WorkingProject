//
//  MineViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/26.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MineViewController.h"
#import "MyCouponController.h"
#import "MyOrderTableViewController.h"
#import "SelectViewController.h"
#import "LikeViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.backgroundLbl.layer.borderWidth = 1;
    self.backgroundLbl.layer.borderColor = [UIColor greenColor].CGColor;
    self.backgroundLbl.layer.masksToBounds = YES;
    self.backgroundLbl.layer.cornerRadius = self.backgroundLbl.frame.size.width / 2;
    self.peopleImageView.layer.cornerRadius = self.peopleImageView.frame.size.width / 2;
    self.couponbTN.layer.borderWidth = 1;
    self.couponbTN.layer.borderColor = [UIColor greenColor].CGColor;
    self.couponbTN.layer.masksToBounds = YES;
    self.selectBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.selectBtn.layer.borderWidth = 1;
    self.selectBtn.layer.masksToBounds = YES;
    self.likeBtn.layer.borderWidth = 1;
    self.likeBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.likeBtn.layer.masksToBounds = YES;
    self.myAdressBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.myAdressBtn.layer.borderWidth = 1;
    self.myAdressBtn.layer.masksToBounds = YES;
    self.moneyBtn.layer.borderWidth = 1;
    self.moneyBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.moneyBtn.layer.masksToBounds = YES;
    self.severBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.severBtn.layer.borderWidth = 1;
    self.severBtn.layer.masksToBounds = YES;
    
   
}
- (IBAction)myOrderBtn:(id)sender {
    MyOrderTableViewController *MyOrderVC = [[MyOrderTableViewController alloc]init];
    [self.navigationController pushViewController:MyOrderVC animated:YES];
}
- (IBAction)couponBtn:(id)sender {
    MyCouponController *couVC = [[MyCouponController alloc]init];
    [self.navigationController pushViewController:couVC animated:YES];
}
- (IBAction)selectBtn:(id)sender {
    SelectViewController *selectVC = [[SelectViewController alloc]init];
    [self.navigationController pushViewController:selectVC animated:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)favoriteBtn:(id)sender {
    LikeViewController *likeVC = [[LikeViewController alloc]init];
    [self.navigationController pushViewController:likeVC animated:YES];
}
- (IBAction)myAdressBtn:(id)sender {
}
- (IBAction)myMoenyBtn:(id)sender {
}
- (IBAction)severBtn:(id)sender {
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
