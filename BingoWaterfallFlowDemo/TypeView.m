
//
//  DianTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView
-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        lab.text = typename;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        BOOL  isLineReturn = NO;
        float upX = 10;
        float upY = 40;
        for (int i = 0; i<arr.count; i++) {
            NSString *str = [arr objectAtIndex:i] ;
          
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
            CGSize size = [str sizeWithAttributes:dic];
            /**
             *  iOS7以前，都用- (CGSize)sizeWithFont:(UIFont *)font方法得出字符串的宽和高，但时7以后这个方法被废除了，文档推荐使用- (CGSize)sizeWithAttributes:(NSDictionary *)attrs，但是经过最近使用，我发现对同一个字符串这两个方法求出的值竟然不一样。
             //利用sizeWithAttributes:计算
             CGSize titleSize = [middleBtn.titleLabel.text sizeWithAttributes:@{@"NSFontAttributeName" : middleBtn.titleLabel.font                                                                     }];
             CGFloat titleWidth1 = titleSize.width;
             CGFloat titleHeight1 = titleSize.height;
             
             ////利用sizeWithFont:计算
             CGFloat titleWidth2 = [middleBtn.titleLabel.text sizeWithFont:middleBtn.titleLabel.font].width;
             CGFloat titleHeight2 = [middleBtn.titleLabel.text sizeWithFont:middleBtn.titleLabel.font].height;
             
             //打印
             RAPLog(@"%.2f, %.2f, %.2f,%.2f",titleWidth1, titleHeight1, titleWidth2, titleHeight2 );
             @{@"NSFontAttributeName" : middleBtn.titleLabel.font}这里应该写成：
             
             @{NSFontAttributeName : middleBtn.titleLabel.font}
             */
            NSLog(@"%f",size.height);
            if ( upX > (self.frame.size.width-20 -size.width-35)) {
                
                isLineReturn = YES;
                upX = 10;
                upY += 30;
            }
            
            UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(upX, upY, size.width+30,25);
            [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitle:[arr objectAtIndex:i] forState:0];
            btn.layer.cornerRadius = 8;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0;
            [btn.layer setMasksToBounds:YES];
            
            [self addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            upX+=size.width+35;
        }

        upY +=30;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, upY+10, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        self.height = upY+11;
        
        self.seletIndex = -1;
    }
    return self;
}
-(void)touchbtn:(UIButton *)btn
{
    
    if (btn.selected == NO) {
        
        self.seletIndex = (int)btn.tag-100;
        btn.backgroundColor = [UIColor redColor];
        
        
//        for (UIView *view in self.subviews) {
//            if ([view class] == [UIButton class]) {
//                UIButton *bt = (UIButton *)view;
//                bt.selected = NO;
//                if (bt.tag == btn.tag) {
//                    bt.selected = YES;
//                }
//            }
//            
//        }
    }else
    {
        self.seletIndex = -1;
        btn.selected = NO;
        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    [self.delegate btnindex:(int)btn.tag-100];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
