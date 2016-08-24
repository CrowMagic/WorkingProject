//
//  BuyShowView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "BuyShowView.h"

@implementation BuyShowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self set_up];
    }
    return self;
}
-(void)set_up
{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen)];
    _backScrollView.contentSize = CGSizeMake(wKscreen, hKscreen*1.5);
    [self addSubview:_backScrollView];
    _StoreBackLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, wKscreen-20, hKscreen/3*2)];
    _StoreBackLbl.layer.masksToBounds = YES;
    _StoreBackLbl.layer.borderWidth = 1;
    _StoreBackLbl.layer.borderColor = [UIColor grayColor].CGColor;
    _StoreBackLbl.layer.cornerRadius = 16;
    [self.backScrollView addSubview:_StoreBackLbl];
    _headPicImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    _headPicImage.layer.cornerRadius = self.headPicImage.frame.size.width/2;
    _headPicImage.layer.masksToBounds = YES;
    _headPicImage.image = [UIImage imageNamed:@"2.jpg"];
    [self.StoreBackLbl addSubview:_headPicImage];
    _StoreNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headPicImage.frame)+10, 10, 150, 50)];
    _StoreNameLbl.text = @"周大福旗舰店";
    _StoreNameLbl.font = [UIFont systemFontOfSize:20.f];
    _StoreNameLbl.textColor = [UIColor grayColor];
    [self.StoreBackLbl addSubview:_StoreNameLbl];
    _walkIntoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _walkIntoBtn.frame = CGRectMake(CGRectGetWidth(self.StoreBackLbl.frame)-10-70, 10, 70, 50);
    [_walkIntoBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    _walkIntoBtn.layer.borderColor = [UIColor greenColor].CGColor;
    _walkIntoBtn.layer.borderWidth = 1;
    _walkIntoBtn.layer.masksToBounds = YES;
    [self.StoreBackLbl addSubview:_walkIntoBtn];
    //
    
    //
    _goodsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headPicImage.frame)+10, CGRectGetWidth(self.StoreBackLbl.frame)-20, CGRectGetHeight(self.StoreBackLbl.frame)/3*2)];
    _goodsScrollView.backgroundColor = [UIColor yellowColor];
    [_StoreBackLbl addSubview:_goodsScrollView];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_goodsScrollView.frame)-40, CGRectGetWidth(_goodsScrollView.frame), 40)];
    _pageControl.backgroundColor = [UIColor blackColor];
    _pageControl.alpha = 0.4;
    _pageControl.numberOfPages = 5;
    [self.goodsScrollView addSubview:_pageControl];
    _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_goodsScrollView.frame)-20, CGRectGetWidth(_goodsScrollView.frame), 20)];
    _priceLbl.text = @"碧玉尊天然和田玉手镯           ¥2000";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"碧玉尊天然和田玉手镯          ¥2000"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 10)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(20,5)];
    _priceLbl.attributedText = str;
    [_goodsScrollView addSubview:_priceLbl];
    _lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_goodsScrollView.frame)+10, wKscreen, 1)];
    [self.StoreBackLbl addSubview:_lineImage];
    UIGraphicsBeginImageContext(_lineImage.frame.size);//开始虚线
    [_lineImage.image drawInRect:CGRectMake(0, 0, _lineImage.frame.size.width, _lineImage.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {10,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);
    CGContextMoveToPoint(line, 0.0, 1.0);
    CGContextAddLineToPoint(line, wKscreen, 1.0);
    CGContextStrokePath(line);
    _lineImage.image = UIGraphicsGetImageFromCurrentImageContext();
    _zanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _zanBtn.frame = CGRectMake(wKscreen/4-25, CGRectGetMaxY(_lineImage.frame)+10, 50, 50);
    _zanBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 7, 10, _zanBtn.titleLabel.frame.size.width);
    [_zanBtn setTitle:@"123" forState:UIControlStateNormal];
    
    [_zanBtn setImage:[[UIImage imageNamed:@"collection.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [_zanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _zanBtn.titleEdgeInsets = UIEdgeInsetsMake(35, -32, 0, 2);
    
    [self.StoreBackLbl addSubview:_zanBtn];
    _musicImage = [[UIImageView alloc]initWithFrame:CGRectMake(wKscreen/2-25, CGRectGetMaxY(_lineImage.frame)+10, 50, 50)];
    _musicImage.image = [UIImage imageNamed:@"music.jpg"];
    [self.StoreBackLbl addSubview:_musicImage];
    [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];//图片旋转
    _inforBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _inforBtn.frame = CGRectMake(wKscreen-wKscreen/4-25, CGRectGetMaxY(_lineImage.frame)+10, 50, 50);
    _inforBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 7, 10, _inforBtn.titleLabel.frame.size.width);
    [_inforBtn setTitle:@"123" forState:UIControlStateNormal];
    [_inforBtn setImage:[[UIImage imageNamed:@"xiaoxi.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [_inforBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _inforBtn.titleEdgeInsets = UIEdgeInsetsMake(35, -32, 0, 2);
    [self.StoreBackLbl addSubview:_inforBtn];
    _segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"品牌",@"详情",@"买家秀", nil]];
    _segmentControl.frame = CGRectMake(0, CGRectGetMaxY(self.StoreBackLbl.frame)+10, wKscreen, 40);
    _segmentControl.tintColor = [UIColor greenColor];
    _segmentControl.selectedSegmentIndex = 1;
    [self.backScrollView addSubview:_segmentControl];
    _pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.segmentControl.frame)+10, wKscreen-40, 160)];
    _pictureImage.image = [UIImage imageNamed:@"1.jpg"];
    [self.backScrollView addSubview:_pictureImage];
    
}
-(void)timerAction
{
    self.musicImage.layer.transform = CATransform3DRotate(self.musicImage.layer.transform, M_PI/30, 0, 0, 1);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
