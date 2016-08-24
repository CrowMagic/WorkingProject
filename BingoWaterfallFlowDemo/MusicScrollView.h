//
//  MusicScrollView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理manButton的方法
@protocol MusicScrollViewDelegate <NSObject>

-(void)ButtonActionToSctollViewWithIndex:(NSInteger)index;

@end

@interface MusicScrollView : UIScrollView
//言记
@property(nonatomic,strong)UIView *buyView;//在言记界面的上半部分
@property(nonatomic,strong)UILabel *topicLabel;//题目
@property(nonatomic,strong)UILabel *describeLabel;//题目介绍
@property(nonatomic,strong)UIImageView *picImageView;//详情图片
//音乐图标
@property(nonatomic,strong)UIButton *zanButton;//点赞
@property(nonatomic,strong)UILabel *zanLabel;// 点赞
@property(nonatomic,strong)UIImageView *musicPicImage;//旋转音乐
@property(nonatomic,strong)UIButton *deButton;//减少赞
@property(nonatomic,strong)UILabel *deLabel;//减赞
//
@property(nonatomic,strong)UIButton *nowBuyButton;//现在购买
@property(nonatomic,strong)UIButton *shipButton;//品牌旗舰店
//买家秀
@property(nonatomic,strong)UIView *segmentView;// 买家秀
@property(nonatomic,weak)id<MusicScrollViewDelegate>delegate;
@property(nonatomic,strong)NSArray *menuArray;//菜单数组
@property(nonatomic,strong)UISegmentedControl *segmentedControl;//菜单栏
@property(nonatomic,strong)UIImageView *userImageView;//用户的头像
@property(nonatomic,strong)UILabel *nameLabel;//用户的名字
@property(nonatomic,strong)UILabel *backImageLabel;//背景
@property(nonatomic,strong)UIImageView *bossImageView;
@property(nonatomic,strong)UIButton *manButton;//所有人物的图片按钮
@property(nonatomic,strong)UILabel * introduceLabel;//这里是简介




@property(nonatomic,strong)UIButton *buyBtn;//加入购物车
@property(nonatomic,strong)UIButton *immeBuyBtn;//立即购买
@end
