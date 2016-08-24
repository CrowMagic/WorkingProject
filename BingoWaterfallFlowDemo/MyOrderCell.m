//
//  MyOrderCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIGraphicsBeginImageContext(self.lineImageView.frame.size);
    //开始划线
    [self.lineImageView.image drawInRect:CGRectMake(0, 0, self.lineImageView.frame.size.width, self.lineImageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {3,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor blackColor].CGColor);
    CGContextSetLineDash(line, 0, lengths,2);
    CGContextMoveToPoint(line, 0.0, 6.0);
    CGContextAddLineToPoint(line, wKscreen, 6.0);
    CGContextStrokePath(line);
    self.lineImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    self.reminderBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.reminderBtn.layer.borderWidth = 1;
    self.reminderBtn.layer.cornerRadius = 5;
    self.reminderBtn.layer.masksToBounds = YES;
    self.checkBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.checkBtn.layer.borderWidth = 1;
    self.checkBtn.layer.cornerRadius = 5;
    self.checkBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.confirmBtn.layer.borderWidth = 1;
    self.confirmBtn.layer.cornerRadius = 5;
    self.confirmBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
