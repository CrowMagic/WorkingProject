//
//  LikeCollectionViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/25.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LikeCollectionViewCell.h"

@implementation LikeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundLbl.layer.cornerRadius = 3;
    self.backgroundLbl.layer.borderWidth = 1;
    self.backgroundLbl.layer.borderColor = [UIColor grayColor].CGColor;
    self.backgroundLbl.layer.masksToBounds = YES;
    self.simpleBtn.layer.borderWidth = 1;
    self.simpleBtn.layer.cornerRadius = 8;
    self.simpleBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.simpleBtn.layer.masksToBounds = YES;
}

@end
