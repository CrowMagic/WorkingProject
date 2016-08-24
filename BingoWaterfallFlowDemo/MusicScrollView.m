//
//  MusicScrollView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MusicScrollView.h"
#import "LinkStoreViewController.h"
#define wScreen  CGRectGetWidth([UIScreen mainScreen].bounds)
#define hScreen  CGRectGetHeight([UIScreen mainScreen].bounds)
@implementation MusicScrollView
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
//    _buyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/4 * 3 -20)];
//    //_buyView.backgroundColor = [UIColor blueColor];
//    [self addSubview:_buyView];
    self.topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen/20)];
    self.topicLabel.textAlignment = NSTextAlignmentCenter;
    self.topicLabel.textColor = [UIColor grayColor];
    self.topicLabel.text = @"言记.初恋";
    [self addSubview:self.topicLabel];
    _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topicLabel.frame), wScreen, CGRectGetHeight(self.topicLabel.frame))];
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.textColor = [UIColor lightGrayColor];
    _describeLabel.text = @"不管人生有多少爱 你永远都是我的初恋";
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_describeLabel];
    
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.describeLabel.frame), wScreen-20, hScreen/3)];
    _picImageView.layer.cornerRadius = 6;
    _picImageView.backgroundColor = [UIColor purpleColor];
    [self addSubview:_picImageView];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];//图片旋转
    
    _zanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _zanButton.frame = CGRectMake(wKscreen/6, CGRectGetMaxY(self.picImageView.frame)+10, wKscreen/8, wKscreen/8);
    _zanButton.layer.cornerRadius = CGRectGetHeight(self.zanButton.frame)/2;
    _zanButton.backgroundColor = [UIColor greenColor];
    [_zanButton setTitle:@"zan" forState:UIControlStateNormal];
    [self addSubview:_zanButton];
    _zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.zanButton.frame)-5, CGRectGetMaxY(self.zanButton.frame), CGRectGetWidth(self.zanButton.frame)+10, 20)];
    _zanLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_zanLabel];
    _musicPicImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.zanButton.frame)+40, CGRectGetMaxY(self.picImageView.frame)+10, 50, 50)];
    _musicPicImage.layer.cornerRadius = CGRectGetHeight(self.musicPicImage.frame)/2;
    _musicPicImage.image = [UIImage imageNamed:@"list"];
    [self addSubview:_musicPicImage];
    _deButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deButton.frame = CGRectMake(CGRectGetMaxX(self.musicPicImage.frame)+40, CGRectGetMaxY(self.picImageView.frame)+10, CGRectGetWidth(self.zanButton.frame), CGRectGetHeight(self.zanButton.frame));
    _deButton.layer.cornerRadius = CGRectGetHeight(self.deButton.frame)/2;
    _deButton.backgroundColor = [UIColor greenColor];
    [self.deButton setTitle:@"jianzan" forState:UIControlStateNormal];
    [self addSubview:_deButton];
    _deLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.deButton.frame)-5, CGRectGetMaxY(self.deButton.frame), CGRectGetWidth(self.zanLabel.frame), CGRectGetHeight(self.zanLabel.frame))];
    _deLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_deLabel];
    _nowBuyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _nowBuyButton.frame = CGRectMake(CGRectGetMidX(self.zanLabel.frame), CGRectGetMaxY(self.zanLabel.frame)+10, wKscreen/2, wKscreen/16);
    _nowBuyButton.backgroundColor = [UIColor greenColor];
    _nowBuyButton.layer.cornerRadius = 8;
    [_nowBuyButton setTitle:@"现在购买：3000元" forState:UIControlStateNormal];
    _nowBuyButton.layer.borderWidth = 1;
    _nowBuyButton.layer.masksToBounds = YES;
    [self addSubview:_nowBuyButton];
    _shipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _shipButton.frame = CGRectMake(CGRectGetMinX(self.nowBuyButton.frame), CGRectGetMaxY(self.nowBuyButton.frame)+5, wKscreen/2, wKscreen/16);
    _shipButton.layer.borderWidth = 1;
    _shipButton.layer.masksToBounds = YES;
    [_shipButton setTitle:@"品牌旗舰店" forState:UIControlStateNormal];
 
    _shipButton.layer.cornerRadius = 8;
    [self addSubview:_shipButton];
//    _segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buyView.frame), wKscreen, 1.5*hKscreen)];
//    [self addSubview:_segmentView];
    _menuArray = [[NSArray alloc]initWithObjects:@"品牌",@"详情",@"买家秀", nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:_menuArray];
    _segmentedControl.frame = CGRectMake(0, CGRectGetMaxY(self.shipButton.frame)+10, wKscreen, 30);
    _segmentedControl.tintColor = [UIColor greenColor];
    _segmentedControl.selectedSegmentIndex = 0;
    [self addSubview:_segmentedControl];
    _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(wKscreen/2-20, CGRectGetMaxY(self.segmentedControl.frame)+10, CGRectGetWidth(self.musicPicImage.frame), CGRectGetHeight(self.musicPicImage.frame))];
    _userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2;
    _userImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_userImageView];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userImageView.frame)-5, CGRectGetMaxY(self.userImageView.frame), CGRectGetWidth(self.userImageView.frame)*2, CGRectGetHeight(self.userImageView.frame)/2)];
    _nameLabel.text = @"买家昵称";
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_nameLabel];
    _backImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(self.nameLabel.frame), wKscreen-6, hKscreen/3*2)];
    _backImageLabel.layer.borderWidth = 0.5f;
    _backImageLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _backImageLabel.layer.masksToBounds = YES;
    [self addSubview:_backImageLabel];
    _bossImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageLabel.frame)+2, CGRectGetMinY(self.backImageLabel.frame)+2, CGRectGetWidth(self.backImageLabel.frame)-4, CGRectGetHeight(self.backImageLabel.frame)-4)];
    _bossImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_bossImageView];
    NSArray *imageArray = [[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"1.jpg",@"2.jpg",@"1.jpg", nil];
    for (int i = 0; i < 5; i ++) {
        _manButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _manButton.frame = CGRectMake(i*wScreen/5, CGRectGetMaxY(self.backImageLabel.frame)+2, wScreen/5, wScreen/6);
        //[_manButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        [_manButton setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        _manButton.tag = 100 + i;
        [_manButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_manButton];
    }
    _introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backImageLabel.frame)+wKscreen/6, wKscreen/3, 20)];
    _introduceLabel.text = @"这里是简介";
    [self addSubview:_introduceLabel];
    
    
    
    
    
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _buyBtn.frame = CGRectMake(0, hKscreen-44-50, wKscreen/2, 50);
    [_buyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    _buyBtn.backgroundColor = [UIColor orangeColor];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _immeBuyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _immeBuyBtn.frame = CGRectMake(CGRectGetMaxX(self.buyBtn.frame), CGRectGetMinY(self.buyBtn.frame), wKscreen/2, 50);
    [_immeBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    _immeBuyBtn.backgroundColor = [UIColor redColor];
    [_immeBuyBtn setTintColor:[UIColor whiteColor]];
    
    
}
//图片旋转
-(void)timeAction
{
    //秒针 转动
    self.musicPicImage.layer.transform  = CATransform3DRotate(self.musicPicImage.layer.transform, M_PI/30, 0, 0, 1);
}
-(void)buttonAction:(UIButton *)sender
{
    NSLog(@"button");
    [self.delegate ButtonActionToSctollViewWithIndex:self.manButton.tag-100];
}

@end
