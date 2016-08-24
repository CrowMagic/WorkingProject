//
//  StoreView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/20.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"
@interface StoreView : UIView
@property (nonatomic,strong)UITableView *leftTableView;//店家
@property (nonatomic,strong)UITableView *rightTableView;//
@property (nonatomic,strong)UIView *locaview;//当前的位置
@property (nonatomic,strong)UILabel *nowLocaLabel;//当前的位置：
@property (nonatomic,strong)UITextField *locaFiled;//当前地址
@property (nonatomic,strong)UIButton *backButton;//返回
@property (nonatomic,strong)UIView *firstView;//顶部背景
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *locaBtn;//定位
@property (nonatomic,strong)UIButton *posiBtn;//当前位置前面的Btn;
@property (nonatomic,strong)MXPullDownMenu *menu;//下拉菜单
@end
