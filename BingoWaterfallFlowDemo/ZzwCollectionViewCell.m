//
//  ZzwCollectionViewCell.m
//  瀑布流demo
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "ZzwCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZzwCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.shopImage.layer.cornerRadius = self.shopImage.frame.size.height/2;
//    self.shopImage.layer.masksToBounds = YES;
//    self.shopImage.backgroundColor = [UIColor yellowColor];
    self.shopName.numberOfLines = 0;
    self.shopName.lineBreakMode = NSLineBreakByCharWrapping;
//    NSLog(@"%f",self.shopImage.frame.size.height/2);
    
    UIGraphicsBeginImageContext(self.lineImage.frame.size);   //开始画线
    [self.lineImage.image drawInRect:CGRectMake(0, 0, self.lineImage.frame.size.width, self.lineImage.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {5,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor greenColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 1.0);    //开始画线
    CGContextAddLineToPoint(line, 310.0, 1.0);
    CGContextStrokePath(line);
    
    self.lineImage.image = UIGraphicsGetImageFromCurrentImageContext();
}
-(void)setShop:(shopModel *)shop
{
    _shop = shop;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:_shop.img]];
    self.shopName.text = _shop.price;
    
    
}
@end
