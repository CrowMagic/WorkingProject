//
//  ActivityCollectionViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/8/10.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ActivityCollectionViewCell.h"

@implementation ActivityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
}

@end
