//
//  StoreView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/20.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "StoreView.h"

@implementation StoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView
{
    self.firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 18, wKscreen, hKscreen/13.7)];
    self.firstView.backgroundColor = [UIColor colorWithRed:77/255.0 green:179/255.0 blue:108/255.0 alpha:1];
    [self addSubview:self.firstView];
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backButton.frame = CGRectMake(5, (CGRectGetHeight(self.firstView.frame)-hKscreen/19.2)/2, wKscreen/16, hKscreen/19.2);
    [self.backButton setTitle:@"<" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.backButton.font = [UIFont systemFontOfSize:24];
    [self.firstView addSubview:self.backButton];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.backButton.frame)+5, (CGRectGetHeight(self.firstView.frame)-hKscreen/16)/2, wKscreen/1.28, hKscreen/16)];
    self.searchBar.layer.cornerRadius = 8;
    //self.searchStoreBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.layer.masksToBounds = YES;
    [self.searchBar.layer setBorderWidth:1];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"searchBackg.jpg"]];
    [self.searchBar.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.firstView addSubview:self.searchBar];
    self.locaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.locaBtn.frame = CGRectMake(self.firstView.frame.size.width - hKscreen/19.2, (CGRectGetHeight(self.firstView.frame)-25)/2, 25, 25);
    [self.locaBtn setBackgroundImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    //[self.locaBtn addTarget:self action:@selector(locaAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview:self.locaBtn];
    self.locaview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstView.frame)+1, self.frame.size.width, CGRectGetHeight(self.firstView.frame))];
    self.locaview.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.locaview];
    self.posiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.posiBtn.frame = CGRectMake(5, (CGRectGetHeight(self.locaview.frame)-20)/2, 20, 20);
    [self.posiBtn setBackgroundImage:[UIImage imageNamed:@"newLoca"] forState:UIControlStateNormal];
    [self.locaview addSubview:self.posiBtn];
    self.nowLocaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.posiBtn.frame)+2, 0, wKscreen/3.6, CGRectGetHeight(self.locaview.frame))];
    self.nowLocaLabel.text = @"当前的位置:";
    self.nowLocaLabel.font = [UIFont systemFontOfSize:15];
    self.nowLocaLabel.textColor = [UIColor grayColor];
    [self.locaview addSubview:self.nowLocaLabel];
    self.locaFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nowLocaLabel.frame), 0, self.frame.size.width-self.locaBtn.frame.size.width-self.nowLocaLabel.frame.size.width-5, CGRectGetHeight(self.locaview.frame))];
    [self.locaview addSubview:self.locaFiled];
    NSArray *testArray;
    testArray = @[@[@"附近的店", @"1km",@"5km",@"10km",@"15km",@"20km"], @[@"智能排序", @"推荐", @"人气", @"销量", @"评价"]];
    self.menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    self.menu.frame = CGRectMake(0, CGRectGetMaxY(self.locaview.frame)+1, self.menu.frame.size.width, self.menu.frame.size.height);
    [self addSubview:self.menu];
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menu.frame)+1, wKscreen/3.8, self.frame.size.height - CGRectGetMaxY(self.menu.frame)-1)];
    [self addSubview:self.leftTableView];
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableView.frame)+1, CGRectGetMaxY(self.menu.frame)+1, self.frame.size.width - CGRectGetWidth(self.leftTableView.frame)-1, CGRectGetHeight(self.leftTableView.frame))];
    [self addSubview:self.rightTableView];
    
}
@end
