//
//  CouponTableViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundLbl.layer.borderWidth = 1;
    self.backgroundLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backgroundLbl.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
