//
//  ZLScrolling.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/7.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLScrolling;
@protocol ZLScrollingDelegate <NSObject>

@optional
/**点击到的下标*/
- (void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index;

@end

@interface ZLScrolling : UIViewController
/**轮播的时间*/
//@property (nonatomic, assign) CGFloat timeInterval;
/**代理*/
@property (nonatomic, weak) id<ZLScrollingDelegate> delegate;
/**调整pageControl颜色*/
@property (nonatomic, strong,readonly) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *goodsArr;//商品名称的数组
@property (nonatomic, strong) UILabel *titleLbl;//商品的名称
- (instancetype)initWithCurrentController:(UIViewController *)viewcontroller frame:(CGRect)frame photos:(NSArray *)photos placeholderImage:(UIImage *)placeholderImage;
@end
