//
//  MakeSureViewController.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeSureViewController : UIViewController
@property(nonatomic,strong)UITableView *sureOrderTableView;//结算 确认订单
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *priceLbl;//总金额
@property(nonatomic,strong)UILabel *allPriceLbl;//¥
@property(nonatomic,strong)UIButton *payBtn;

@property(nonatomic,strong)UIView *backView;//透明背景

@end
