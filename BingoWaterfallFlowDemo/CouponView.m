//
//  CouponView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/27.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "CouponView.h"

@implementation CouponView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self set_up];
    }
    return self;
}
-(void)set_up
{
    UIView *ticketView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    [self addSubview:ticketView];
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.4;
    [ticketView addSubview:_alphaView];
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_alphaView.frame), wKscreen, 30)];
    titleLbl.backgroundColor = [UIColor whiteColor];
    titleLbl.text = @"优惠券";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor grayColor];
    [ticketView addSubview:titleLbl];
    UILabel *lineLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame), wKscreen, 1)];
    lineLbl.backgroundColor = [UIColor grayColor];
    [ticketView addSubview:lineLbl];
    _couponTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLbl.frame), wKscreen, hKscreen-CGRectGetMaxY(lineLbl.frame))];
    [ticketView addSubview:_couponTable];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
