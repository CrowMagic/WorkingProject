//
//  TitleCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TitleCell.h"

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backLabel.layer.borderWidth = 0.5f;
    self.backLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.backLabel.layer.masksToBounds = YES;
    self.backLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.backLabel.numberOfLines = 0;
}

@end
