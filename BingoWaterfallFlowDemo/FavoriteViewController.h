//
//  FavoriteViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/25.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstSemTableViewController;
@class LikeViewController;
@interface FavoriteViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)UISegmentedControl *segmentControl;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIButton *usefullBtn;
@property(nonatomic,strong)UIButton *uselessBtn;
@property(nonatomic,strong)UIButton *rubbishBtn;
@property(nonatomic,strong)UIViewController *currentVC;
@property(nonatomic,strong)FirstSemTableViewController *vc;
@property(nonatomic,strong)LikeViewController *lVC;
@property(nonatomic,strong)UIScrollView *sv;
@end
