//
//  MyViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/2.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyViewController.h"
#import "MyCouponController.h"
#import "MyOrderTableViewController.h"
#import "SelectViewController.h"
#import "LikeViewController.h"
#import "ss_settingViewController.h"
#import "FavoriteViewController.h"

#import "OrderViewController.h"

#import "MyAddressViewController.h"
#import "MyGoldViewController.h"
#import "AfterServiceViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的";
    self.baLbl.layer.cornerRadius = self.baLbl.frame.size.width / 2;
    self.baLbl.layer.borderWidth = 1;
    self.baLbl.backgroundColor = [UIColor whiteColor];
    self.baLbl.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.baLbl.layer.masksToBounds = YES;
    self.peopleImage.layer.cornerRadius = self.peopleImage.frame.size.width/2;
    self.peopleImage.layer.masksToBounds = YES;
    self.nameLbl.textColor = [UIColor colorWithRed:150.0/255 green:160.0/255 blue:168.0/255 alpha:1];
    self.detailLbl.textColor = [UIColor colorWithRed:150.0/255 green:160.0/255 blue:168.0/255 alpha:1];
    self.moneyLbl.text = @"可使用余额:0:00元";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"可使用余额:0:00元"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1] range:NSMakeRange(0, 5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 5)];
    self.moneyLbl.attributedText = str;
    self.setupBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 7, 10, self.setupBtn.titleLabel.frame.size.width);
    [self.setupBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.setupBtn setImage:[[UIImage imageNamed:@"30.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self.setupBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.setupBtn.titleEdgeInsets = UIEdgeInsetsMake(28, -32, 0, 2);
    
    self.orderBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 7, 10, self.orderBtn.titleLabel.frame.size.width);
    [self.orderBtn setTitle:@"订单" forState:UIControlStateNormal];
    [self.orderBtn setImage:[[UIImage imageNamed:@"order"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self.orderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.orderBtn.titleEdgeInsets = UIEdgeInsetsMake(29, -32, 0, 2);
    
    self.myCopuBtn.layer.borderWidth = 1;
    self.myCopuBtn.layer.cornerRadius = 4;
    self.myCopuBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.myCopuBtn.layer.masksToBounds = YES;
    self.selecBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.selecBtn.layer.borderWidth = 1;
    self.selecBtn.layer.cornerRadius = 4;
    self.selecBtn.layer.masksToBounds = YES;
    self.likeBtn.layer.borderWidth = 1;
    self.likeBtn.layer.cornerRadius = 4;
    self.likeBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.likeBtn.layer.masksToBounds = YES;
    self.adressBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.adressBtn.layer.borderWidth = 1;
    self.adressBtn.layer.cornerRadius = 4;
    self.adressBtn.layer.masksToBounds = YES;
    self.moneyBtn.layer.borderWidth = 1;
    self.moneyBtn.layer.cornerRadius = 4;
    self.moneyBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.moneyBtn.layer.masksToBounds = YES;
    self.severBtn.layer.borderColor = [UIColor colorWithRed:34.0/255 green:131.0/255 blue:31.0/255 alpha:1].CGColor;
    self.severBtn.layer.borderWidth = 1;
    self.severBtn.layer.cornerRadius = 4;
    self.severBtn.layer.masksToBounds = YES;
    
}

- (IBAction)oederBtn:(id)sender {
    ss_settingViewController *setVC = [[ss_settingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}
- (IBAction)myOrderBtn:(id)sender {
    //MyOrderTableViewController *MyOrderVC = [[MyOrderTableViewController alloc]init];
    //[self.navigationController pushViewController:MyOrderVC animated:YES];
    OrderViewController *ordervc = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:ordervc animated:YES];
}
- (IBAction)myCopBtn:(id)sender {
    MyCouponController *couVC = [[MyCouponController alloc]init];
    [self.navigationController pushViewController:couVC animated:YES];
}
- (IBAction)selectBtn:(id)sender {
    SelectViewController *selectVC = [[SelectViewController alloc]init];
    [self.navigationController pushViewController:selectVC animated:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)likeBtn:(id)sender {
    FavoriteViewController *likeVC = [[FavoriteViewController alloc]init];
    [self.navigationController pushViewController:likeVC animated:YES];
}
- (IBAction)adressBtn:(id)sender {
    MyAddressViewController *addressVC = [[MyAddressViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
}
- (IBAction)moneyBtn:(id)sender {
    MyGoldViewController *goldVC = [[MyGoldViewController alloc]init];
    [self.navigationController pushViewController:goldVC animated:YES];
}
- (IBAction)severBtn:(id)sender {
    AfterServiceViewController *serviceVC = [[AfterServiceViewController alloc]init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}
- (IBAction)erweimaBtn:(id)sender {
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
