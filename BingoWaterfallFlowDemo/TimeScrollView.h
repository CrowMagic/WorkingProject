//
//  TimeScrollView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeScrollView : UIScrollView
@property(nonatomic,strong)UIView *myFirstView;//“把最美的礼物”的view
@property(nonatomic,strong)UIImageView *goodsImageView;//商品
@property(nonatomic,strong)UILabel *contentLabel;//'把最美的礼物'
@property(nonatomic,strong)UILabel *detailLabel;//'送给最伟大的母亲'

@property(nonatomic,strong)UIView *backView;//背景
@property(nonatomic,strong)UIButton *zanButton;//赞
@property(nonatomic,strong)UIButton *musicButton;//旋转音乐
@property(nonatomic,strong)UIButton *deZanButton;//减赞
@property(nonatomic,strong)UILabel *activeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *backLabel;
@property(nonatomic,strong)UIImageView *beautyImageView;

@property(nonatomic,strong)UIButton *zanCountBtn;//点赞数量
@property(nonatomic,strong)UILabel *countZanLabel;
@property(nonatomic,strong)UIButton *commentBtn;//评论数量
@property(nonatomic,strong)UILabel *numCommentLabel;
@property(nonatomic,strong)UILabel *surplusLabel;//库存量
@property(nonatomic,strong)UILabel *lastLabel;//线条

@property(nonatomic,strong)UILabel *priceLabel;//原价299
@property(nonatomic,strong)UILabel *nextPriceLabel;
@property(nonatomic,strong)UILabel *joinLabel;//参与方法
@property(nonatomic,strong)UILabel *attionLabel;//需要注意的事项
@property(nonatomic,strong)UILabel *severLabel;//
@property(nonatomic,strong)UILabel *contactLabel;
@property(nonatomic,strong)UILabel *phoneLabel;//联系方式

@property(nonatomic,strong)UILabel *custumerLabel;//顾客评论区
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *numberPeopLabel;
@property(nonatomic,strong)UIButton *talkBtn;//我来说几句
@property(nonatomic,strong)UIButton *moreInfoLabel;//查看更多
@property(nonatomic,strong)UITableView *MyTableView;//折叠
@property(nonatomic,strong)UILabel *linLabel;//线条
@property(nonatomic,strong)UILabel *promiseLabel;//售后承诺
@property(nonatomic,strong)UILabel *outLabel;//外边框
@property(nonatomic,strong)UILabel *inLabel;//内边框
@property(nonatomic,strong)UILabel *aliveLabel;
@property(nonatomic,strong)UIImageView *logoImageView;
@end
