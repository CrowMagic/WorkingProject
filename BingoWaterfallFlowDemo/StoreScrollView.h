//
//  StoreScrollView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreScrollView : UIScrollView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UIView *storeView;
@property(nonatomic,strong)UIButton *youhuiBtn;
@property(nonatomic,strong)UIButton *collectionBtn;
@property(nonatomic,strong)UIButton *lingquanBtn;
@end
