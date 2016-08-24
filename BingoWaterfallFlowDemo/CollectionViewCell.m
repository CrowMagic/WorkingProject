//
//  CollectionViewCell.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/26/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    // Initialization code
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 1;
    
//    self.contentView.layer.masksToBounds = YES;
    self.dottedLineView.backgroundColor = [UIColor whiteColor];
    [self drawDashLine:self.dottedLineView lineLength:1 lineSpacing:2 lineColor:[UIColor grayColor]];
    
//    self.selected =
//    [UIScreen mainScreen].bounds.size
    self.artPicture.layer.cornerRadius = 65;

    if ([UIScreen mainScreen].bounds.size.width > 400) {
        self.artPictureWidth.constant = 160;
        self.artPictureHeight.constant = 160;
        self.artPicture.layer.cornerRadius = 80;
    } else if ([UIScreen mainScreen].bounds.size.width > 350) {
        self.artPictureWidth.constant = 150;
        self.artPictureHeight.constant = 150;
        self.artPicture.layer.cornerRadius = 75;
    }
    
}


-(void)config:(NSInteger)index andData:(NSMutableArray*)flagArr;
{
    //给需要 点击cell改变的状态的控件设置tag
    //为了能在外面取到  然后通过点击cell给控件改变状态和属性
    //赋值判断:如果在index位置的值为0  就是未被选中  1就是被选中
    if ([flagArr[index] intValue]){
        debugLog(@"1");
        self.thumbUpCount.text = @"124";
        self.isThumbUpButton.selected = YES;
        
    }else {
        self.thumbUpCount.text = @"123";
        self.isThumbUpButton.selected = NO;

        debugLog(@"0");
    }
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
