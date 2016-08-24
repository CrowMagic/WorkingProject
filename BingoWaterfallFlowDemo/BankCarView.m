//
//  BankCarView.m
//  结算购物车
//
//  Created by giikylee on 16/6/6.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import "BankCarView.h"

@implementation BankCarView
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
    
    self.hyalineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    self.hyalineView.backgroundColor = [UIColor blackColor];
    self.hyalineView.alpha = 0.6;
    self.bankTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hyalineView.frame), self.frame.size.width, self.frame.size.height/2) style:UITableViewStylePlain];
    
    [self addSubview:self.hyalineView];
    [self addSubview:self.bankTableView];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
