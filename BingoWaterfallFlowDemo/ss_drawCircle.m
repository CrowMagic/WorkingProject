//
//  ss_drawCircle.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_drawCircle.h"

@implementation ss_drawCircle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, 10, 0, M_PI*2, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
//        CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);

    
}


@end
