//
//  FenleiCollectionViewCell.m
//  分类界面
//
//  Created by giikylee on 16/7/6.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import "FenleiCollectionViewCell.h"

@implementation FenleiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backLbl.layer.cornerRadius = 3;
    self.backLbl.layer.borderWidth = 1;
    self.backLbl.layer.borderColor = [UIColor grayColor].CGColor;
    self.backLbl.layer.masksToBounds = YES;
    self.nameLbl.textAlignment = NSTextAlignmentCenter;
    self.nameLbl.text = @"衣服";
    
}

@end
