//
//  SelectView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView
-(UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(40, 44, wKscreen-40, hKscreen-44-64-100)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        _backGroundView.layer.cornerRadius = 6;
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}
-(UIImageView *)shopImageView
{
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.backGroundView.frame), CGRectGetHeight(self.backGroundView.frame))];
        _shopImageView.backgroundColor = [UIColor redColor];
        [self.backGroundView addSubview:_shopImageView];
    }
    return _shopImageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
