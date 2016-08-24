//
//  AppreciateCell.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/22/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "AppreciateCell.h"

@implementation AppreciateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.blackBorderView.layer.borderWidth = 1;
    self.blackBorderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width/2;
    self.iconImageView.clipsToBounds = YES;

}

- (void)layoutSubviews {
    [super layoutSubviews];
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    self.frame.size.width = width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
