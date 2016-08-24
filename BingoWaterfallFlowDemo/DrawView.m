//
//  DrawView.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/28/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, 20, 0, M_PI*2, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);

}


@end
