//
//  ZiView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiView : UIView
@property(nonatomic,strong)UIScrollView *backScrollView;//背景
@property(nonatomic,strong)UISearchBar *apprSearchBar;//名玉鉴赏详情页面的搜索框
@property(nonatomic,strong)UILabel *mingyuLbl;//名玉鉴赏
@property(nonatomic,strong)UICollectionView *collectionView;//
@property(nonatomic,strong)UILabel *inforYuLbl;//介绍玉的详情
@end
