//
//  YishuViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/7.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YishuViewController : UIViewController
@property(nonatomic,strong)UIScrollView *backScrollow;
@property(nonatomic,strong)UILabel *backLbl;//
@property(nonatomic,strong)UIImageView *peopleImage;//头像
@property(nonatomic,strong)UILabel *nameLbl;//姓名
@property(nonatomic,strong)UILabel *jinaLbl;
@property(nonatomic,strong)UILabel *informationLbl;//简介
@property(nonatomic,strong)UILabel *sayLbl;//名言
@property(nonatomic,strong)UILabel *firLineLbl;
@property(nonatomic,strong)UILabel *hengLineLbl;//第一条横线
@property(nonatomic,strong)UILabel *sayingLbl;
@property(nonatomic,strong)UILabel *seconLbl;
@property(nonatomic,strong)UILabel *sHLineLbl;//第二条横线
@property(nonatomic,strong)UILabel *picLbl;//轮播背景
@property(nonatomic,strong)UILabel *titleLbel;//作品集
@end
