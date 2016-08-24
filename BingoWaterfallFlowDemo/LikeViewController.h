//
//  LikeViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeViewController : UIViewController
@property(nonatomic,strong)UIButton *usefullBtn;
@property(nonatomic,strong)UIButton *uselessBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *levelLbl;
@property(nonatomic,strong)UIButton *rubbishBtn;
@property(nonatomic,assign)BOOL isClick;
@end
