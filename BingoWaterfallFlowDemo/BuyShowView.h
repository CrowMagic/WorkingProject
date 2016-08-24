//
//  BuyShowView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyShowView : UIView
@property(nonatomic,strong)UIScrollView *backScrollView;//商品详情背景
@property(nonatomic,strong)UILabel *StoreBackLbl;//店铺的背景圆角
@property(nonatomic,strong)UIImageView *headPicImage;//头像
@property(nonatomic,strong)UILabel *StoreNameLbl;//店铺名字
@property(nonatomic,strong)UIButton *walkIntoBtn;//进入店铺
@property(nonatomic,strong)UIScrollView *goodsScrollView;//轮播效果
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UILabel *priceLbl;//商品的名字和价钱
@property(nonatomic,strong)UIImageView *lineImage;//虚线
@property(nonatomic,strong)UIButton *zanBtn;//赞
@property(nonatomic,strong)UIImageView *picZanImage;
@property(nonatomic,strong)UILabel *countLbl;//赞的数量
@property(nonatomic,strong)UIImageView *musicImage;//旋转的音乐
@property(nonatomic,strong)UIImageView *inforImage;//消息图片
@property(nonatomic,strong)UILabel *numLbl;//消息的数量
@property(nonatomic,strong)UIButton *inforBtn;//消息
@property(nonatomic,strong)UISegmentedControl *segmentControl;//买家秀
@property(nonatomic,strong)UIImageView *pictureImage;//
@end
