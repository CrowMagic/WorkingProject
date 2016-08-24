//
//  LinkStoreCollectionViewCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LinkStoreCollectionViewCell.h"

@implementation LinkStoreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backLabel.layer.borderWidth = 0.5f;
    self.backLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.backLabel.layer.masksToBounds = YES;
    
    
}

@end
