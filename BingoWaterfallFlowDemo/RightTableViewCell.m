//
//  RightTableViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.height *.5f;
    
}
- (IBAction)disBtn:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
