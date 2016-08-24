//
//  Circle.m
//  DrawCircleBG
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 hehe. All rights reserved.
//

#import "Circle.h"
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * M_PI/180)
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 180/M_PI)

#define POINT_X self.frame.size.width/2
#define POINT_Y self.frame.size.height/2
#define BigCircleRadious (POINT_X - 10)
#define MiddleCircleRadious (POINT_X - POINT_X * 2 / 12.8)
#define SmallCircleRadious (POINT_X - POINT_X * 2 / 3.5)

@implementation Circle



- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawBigCircle];
    [self drawMiddleCircle];
    [self drawSmallCircle];
    [self drawLine];
    
    
    
}




- (void)drawBigCircle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextAddArc(context, POINT_X, POINT_Y, POINT_X-15, 0, M_PI*2, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
//    // 绘制颜色渐变
//    // 创建色彩空间对象
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//
//    
//    CGFloat colors[] = {0, 149/255.0, 50/255.0, 1,
//                        0, 149/255.0, 50/255.0, 1,
//                        0, 149/255.0, 50/255.0, 1,
//                        0, 149/255.0, 50/255.0, 1,
//                        0, 149/255.0, 50/255.0, 1,
//                        0, 149/255.0, 50/255.0, 0.8,
//                        0, 149/255.0, 50/255.0, 0.6,
//                        0, 149/255.0, 50/255.0, 0.4,
//                                        1, 1, 1, 0
//    
//    };
//    CGGradientRef asdd = CGGradientCreateWithColorComponents(colorSpaceRef, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
//    
//    
//   CGContextDrawRadialGradient(context, asdd, CGPointMake(POINT_X, POINT_Y), 0, CGPointMake(POINT_X, POINT_Y), BigCircleRadious, kCGGradientDrawsBeforeStartLocation);
//    
//    
//    // 释放渐变对象
//    CGGradientRelease(asdd);
//    // 释放色彩空间
//    CGColorSpaceRelease(colorSpaceRef);

    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
    

}

- (void)drawMiddleCircle {
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context1);
    CGContextAddArc(context1, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(5-2-1), CC_DEGREES_TO_RADIANS(55+2+1), 0);
    CGContextSetStrokeColorWithColor(context1, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context1, 1);
    CGContextDrawPath(context1, kCGPathStroke);
    CGContextRestoreGState(context1);
//    对于绘制的视图，如果旋转它，会发现有锯齿状的边缘。这是因为iOS出于性能的考虑，默认不开启边缘的反锯齿。
//    可以使用下面方法开启：
//    CGContextSetAllowsAntialiasing(context, YES);
//    CGContextSetShouldAntialias(context, YES);
//    如果你是直接生成的 UIImage ，然后把它作为视图的背景，则无法使用这种方法。这时有两种办法，一种是在Info.plist中开启全局的边缘反锯齿特性，或者给你的 UIImage 图像增加1px的transparent边，这样可以绕过这个问题。
    
    
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context2);
    CGContextAddArc(context2, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(65-2-1), CC_DEGREES_TO_RADIANS(115+2+1), 0);
    CGContextSetStrokeColorWithColor(context2, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context2, 1);
    CGContextDrawPath(context2, kCGPathStroke);
    CGContextRestoreGState(context2);
    
    CGContextRef context3 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context3);
    CGContextAddArc(context3, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(125-2-1), CC_DEGREES_TO_RADIANS(175+2+1), 0);
    CGContextSetStrokeColorWithColor(context3, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context3, 1);
    CGContextDrawPath(context3, kCGPathStroke);
    CGContextRestoreGState(context3);
    
    CGContextRef context4 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context4);
    CGContextAddArc(context4, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(185-2-1), CC_DEGREES_TO_RADIANS(235+2+1), 0);
    CGContextSetStrokeColorWithColor(context4, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context4, 1);
    CGContextDrawPath(context4, kCGPathStroke);
    CGContextRestoreGState(context4);
    
    CGContextRef context5 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context5);
    CGContextAddArc(context5, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(245-2-1), CC_DEGREES_TO_RADIANS(295+2+1), 0);
    CGContextSetStrokeColorWithColor(context5, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context5, 1);
    CGContextDrawPath(context5, kCGPathStroke);
    CGContextRestoreGState(context5);
    
    CGContextRef context6 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context6);
    CGContextAddArc(context6, POINT_X, POINT_Y, MiddleCircleRadious, CC_DEGREES_TO_RADIANS(305-2-1), CC_DEGREES_TO_RADIANS(355+2+1), 0);
    CGContextSetStrokeColorWithColor(context6, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context6, 1);
    CGContextDrawPath(context6, kCGPathStroke);
    CGContextRestoreGState(context6);

}

- (void)drawLine {
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context1);
    CGFloat x11 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(5-2-1));
    CGFloat y11 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(5-2-1));
    CGContextMoveToPoint(context1, x11, y11);
    CGFloat x21 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(5-2-1));
    CGFloat y21 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(5-2-1));
    CGContextAddLineToPoint(context1, x21, y21);
    CGContextSetStrokeColorWithColor(context1, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context1, 1);
    CGContextDrawPath(context1, kCGPathStroke);
    CGContextRestoreGState(context1);
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context2);
    CGFloat x12 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(55+2+1));
    CGFloat y12 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(55+2+1));
    CGContextMoveToPoint(context2, x12, y12);
    CGFloat x22 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(55+2+1));
    CGFloat y22 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(55+2+1));
    CGContextAddLineToPoint(context2, x22, y22);
    CGContextSetStrokeColorWithColor(context2, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context2, 1);
    CGContextDrawPath(context2, kCGPathStroke);
    CGContextRestoreGState(context2);
    
    CGContextRef context3 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context3);
    CGFloat x13 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(65-2-1));
    CGFloat y13 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(65-2-1));
    CGContextMoveToPoint(context3, x13, y13);
    CGFloat x23 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(65-2-1));
    CGFloat y23 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(65-2-1));
    CGContextAddLineToPoint(context3, x23, y23);
    CGContextSetStrokeColorWithColor(context3, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context3, 1);
    CGContextDrawPath(context3, kCGPathStroke);
    CGContextRestoreGState(context3);
    
    CGContextRef context4 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context4);
    CGFloat x14 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(115+2+1));
    CGFloat y14 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(115+2+1));
    CGContextMoveToPoint(context4, x14, y14);
    CGFloat x24 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(115+2+1));
    CGFloat y24 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(115+2+1));
    CGContextAddLineToPoint(context4, x24, y24);
    CGContextSetStrokeColorWithColor(context4, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context4, 1);
    CGContextDrawPath(context4, kCGPathStroke);
    CGContextRestoreGState(context4);
    
    CGContextRef context5 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context5);
    CGFloat x15 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(125-2-1));
    CGFloat y15 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(125-2-1));
    CGContextMoveToPoint(context5, x15, y15);
    CGFloat x25 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(125-2-1));
    CGFloat y25 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(125-2-1));
    CGContextAddLineToPoint(context5, x25, y25);
    CGContextSetStrokeColorWithColor(context5, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context5, 1);
    CGContextDrawPath(context5, kCGPathStroke);
    CGContextRestoreGState(context5);
    
    
    CGContextRef context6 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context6);
    CGFloat x16 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(175+2+1));
    CGFloat y16 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(175+2+1));
    CGContextMoveToPoint(context6, x16, y16);
    CGFloat x26 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(175+2+1));
    CGFloat y26 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(175+2+1));
    CGContextAddLineToPoint(context6, x26, y26);
    CGContextSetStrokeColorWithColor(context6, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context6, 1);
    CGContextDrawPath(context6, kCGPathStroke);
    CGContextRestoreGState(context6);
    
    CGContextRef context7 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context7);
    CGFloat x17 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(185-2-1));
    CGFloat y17 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(185-2-1));
    CGContextMoveToPoint(context7, x17, y17);
    CGFloat x27 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(185-2-1));
    CGFloat y27 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(185-2-1));
    CGContextAddLineToPoint(context7, x27, y27);
    CGContextSetStrokeColorWithColor(context7, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context7, 1);
    CGContextDrawPath(context7, kCGPathStroke);
    CGContextRestoreGState(context7);
    
    CGContextRef context8 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context8);
    CGFloat x18 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(235+2+1));
    CGFloat y18 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(235+2+1));
    CGContextMoveToPoint(context8, x18, y18);
    CGFloat x28 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(235+2+1));
    CGFloat y28 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(235+2+1));
    CGContextAddLineToPoint(context8, x28, y28);
    CGContextSetStrokeColorWithColor(context8, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context8, 1);
    CGContextDrawPath(context8, kCGPathStroke);
    CGContextRestoreGState(context8);
    
    CGContextRef context9 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context9);
    CGFloat x19 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(245-2-1));
    CGFloat y19 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(245-2-1));
    CGContextMoveToPoint(context9, x19, y19);
    CGFloat x29 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(245-2-1));
    CGFloat y29 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(245-2-1));
    CGContextAddLineToPoint(context9, x29, y29);
    CGContextSetStrokeColorWithColor(context9, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context9, 1);
    CGContextDrawPath(context9, kCGPathStroke);
    CGContextRestoreGState(context9);
    
    CGContextRef context10 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context10);
    CGFloat x110 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(295+2+1));
    CGFloat y110 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(295+2+1));
    CGContextMoveToPoint(context10, x110, y110);
    CGFloat x210 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(295+2+1));
    CGFloat y210 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(295+2+1));
    CGContextAddLineToPoint(context10, x210, y210);
    CGContextSetStrokeColorWithColor(context10, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context10, 1);
    CGContextDrawPath(context10, kCGPathStroke);
    CGContextRestoreGState(context10);
    
    CGContextRef context11 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context11);
    CGFloat x111 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(305-2-1));
    CGFloat y111 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(305-2-1));
    CGContextMoveToPoint(context11, x111, y111);
    CGFloat x211 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(305-2-1));
    CGFloat y211 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(305-2-1));
    CGContextAddLineToPoint(context11, x211, y211);
    CGContextSetStrokeColorWithColor(context11, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context11, 1);
    CGContextDrawPath(context11, kCGPathStroke);
    CGContextRestoreGState(context11);

    CGContextRef context12 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context12);
    CGFloat x112 = POINT_X + SmallCircleRadious * cos(CC_DEGREES_TO_RADIANS(355+2+1));
    CGFloat y112 = POINT_Y + SmallCircleRadious * sin(CC_DEGREES_TO_RADIANS(355+2+1));
    CGContextMoveToPoint(context12, x112, y112);
    CGFloat x212 = POINT_X + MiddleCircleRadious * cos(CC_DEGREES_TO_RADIANS(355+2+1));
    CGFloat y212 = POINT_Y + MiddleCircleRadious * sin(CC_DEGREES_TO_RADIANS(355+2+1));
    CGContextAddLineToPoint(context12, x212, y212);
    CGContextSetStrokeColorWithColor(context12, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context12, 1);
    CGContextDrawPath(context12, kCGPathStroke);
    CGContextRestoreGState(context12);
}


- (void)drawSmallCircle {
    
    
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context1);
    CGContextAddArc(context1, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(5-2), CC_DEGREES_TO_RADIANS(55+2), 0);
    CGContextSetStrokeColorWithColor(context1, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context1, 1);
    CGContextDrawPath(context1, kCGPathStroke);
    CGContextRestoreGState(context1);
    
    
    
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context2);
    CGContextAddArc(context2, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(65-2), CC_DEGREES_TO_RADIANS(115+2), 0);
    CGContextSetStrokeColorWithColor(context2, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context2, 1);
    CGContextDrawPath(context2, kCGPathStroke);
    CGContextRestoreGState(context2);
    
    CGContextRef context3 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context3);
    CGContextAddArc(context3, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(125-2), CC_DEGREES_TO_RADIANS(175+2), 0);
    CGContextSetStrokeColorWithColor(context3, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context3, 1);
    CGContextDrawPath(context3, kCGPathStroke);
    CGContextRestoreGState(context3);
    
    CGContextRef context4 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context4);
    CGContextAddArc(context4, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(185-2), CC_DEGREES_TO_RADIANS(235+2), 0);
    CGContextSetStrokeColorWithColor(context4, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context4, 1);
    CGContextDrawPath(context4, kCGPathStroke);
    CGContextRestoreGState(context4);
    
    CGContextRef context5 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context5);
    CGContextAddArc(context5, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(245-2), CC_DEGREES_TO_RADIANS(295+2), 0);
    CGContextSetStrokeColorWithColor(context5, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context5, 1);
    CGContextDrawPath(context5, kCGPathStroke);
    CGContextRestoreGState(context5);
    
    CGContextRef context6 = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context6);
    CGContextAddArc(context6, POINT_X, POINT_Y, SmallCircleRadious, CC_DEGREES_TO_RADIANS(305-2), CC_DEGREES_TO_RADIANS(355+2), 0);
    CGContextSetStrokeColorWithColor(context6, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context6, 1);
    CGContextDrawPath(context6, kCGPathStroke);
    CGContextRestoreGState(context6);

}


@end
