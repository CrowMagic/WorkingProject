//
//  TitleView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/31.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setview];
    }
    return self;
}
-(void)p_setview
{
    
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, wKscreen, 50)];
    [self addSubview:self.headerView];
    self.mainScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), wKscreen, hKscreen)];
    self.mainScrollView.contentSize = CGSizeMake(4*wKscreen, hKscreen);
    self.mainScrollView.pagingEnabled =YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.alwaysBounceVertical = NO;
    [self addSubview:self.mainScrollView];
    _defaultIndex=1;
    self.buttonTitleArr = [NSArray arrayWithObjects:@"店铺首页",@"全部宝贝",@"新品上架",@"微淘动态", nil];
    for (int i = 0; i < 4; i ++) {
        // 标题button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(wKscreen / 4 * i, 0, wKscreen/4, CGRectGetHeight(self.headerView.frame));
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [button setFont:[UIFont systemFontOfSize:16]];
        [button setTitle:self.buttonTitleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:button];
        [_btns addObject:button];
        if (i == 0) {
            _titleBtn = button;
            button.selected = YES;
        }
    }
    
}
- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=sender;
        _titleBtn.selected=YES;
        _defaultIndex=sender.tag;
    }
    [self.delegate ButtonActionToScrollTableViewWithIndex:sender.tag - 100];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
