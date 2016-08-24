//
//  BottomView.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *allImage;
@property (nonatomic,strong)UIButton *allBtn;//全选
@property (nonatomic,strong)UILabel *allPriceLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,strong)UIButton *settlementButton;//结算
@property (nonatomic,strong)UILabel *settlementLabel;
@end
