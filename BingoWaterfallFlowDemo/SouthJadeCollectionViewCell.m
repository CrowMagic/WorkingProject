//
//  SouthJadeCollectionViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "SouthJadeCollectionViewCell.h"

@implementation SouthJadeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.brandImageView.layer.cornerRadius = 20;
    self.brandImageView.backgroundColor = [UIColor yellowColor];
}

@end
