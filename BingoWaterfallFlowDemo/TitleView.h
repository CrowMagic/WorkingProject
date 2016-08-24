//
//  TitleView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/31.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TitleViewDelegate<NSObject>

// 代理 HeaderView 上面的 Button 点击方法
- (void)ButtonActionToScrollTableViewWithIndex:(NSInteger)index;

@end
@interface TitleView : UIView
@property(nonatomic ,strong)UIView *headerView;
@property (nonatomic,weak)id<TitleViewDelegate>delegate;
@property(nonatomic ,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)NSArray *buttonTitleArr;
@property (nonatomic,assign) NSInteger defaultIndex;//默认选中第一个
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) NSMutableArray *btns;
@end
