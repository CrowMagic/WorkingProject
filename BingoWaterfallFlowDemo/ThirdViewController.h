//
//  ThirdViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/19.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
@property(nonatomic,strong)UITableView *rightTitleTableView;
@property(nonatomic,strong)UICollectionView *leftCollectionView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UISearchBar *kindSeacherBar;
@end
