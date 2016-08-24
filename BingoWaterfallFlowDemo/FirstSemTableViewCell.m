//
//  FirstSemTableViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/25.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "FirstSemTableViewCell.h"

@implementation FirstSemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
