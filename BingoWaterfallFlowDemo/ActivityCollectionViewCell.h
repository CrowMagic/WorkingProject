//
//  ActivityCollectionViewCell.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/8/10.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;//活动商品图片
@property (weak, nonatomic) IBOutlet UILabel *activityGoodsNameLabel;//活动商品名字
@property (weak, nonatomic) IBOutlet UILabel *activityVIPPriceLabel;//活动会员价格
@property (weak, nonatomic) IBOutlet UILabel *activityIntegralExchangeLabel;//活动积分兑换

@end
