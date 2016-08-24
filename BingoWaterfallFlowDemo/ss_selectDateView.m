//
//  ss_selectDateView.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_selectDateView.h"

@implementation ss_selectDateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (instancetype)initWithView {
    return [[NSBundle mainBundle] loadNibNamed:@"ss_selectDateView" owner:nil options:nil][0];
}


@end
