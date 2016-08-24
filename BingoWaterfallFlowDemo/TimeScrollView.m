//
//  TimeScrollView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TimeScrollView.h"

@implementation TimeScrollView
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
    _myFirstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen/4*3)];
    //_myFirstView.backgroundColor = [UIColor blueColor];
    [self addSubview:_myFirstView];
    _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen/2)];
    _goodsImageView.image = [UIImage imageNamed:@"3.jpg"];
    _goodsImageView.backgroundColor = [UIColor redColor];
    [self.myFirstView addSubview:_goodsImageView];
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.goodsImageView.frame)+(CGRectGetHeight(self.myFirstView.frame)-CGRectGetHeight(self.goodsImageView.frame))/3, wKscreen, hKscreen/24)];
    _contentLabel.text = @"把最美的礼物";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.myFirstView addSubview:_contentLabel];
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame), wKscreen, CGRectGetHeight(self.contentLabel.frame))];
    _detailLabel.text = @"送给最伟大的母亲";
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.myFirstView addSubview:_detailLabel];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myFirstView.frame), wKscreen, hKscreen*1.1)];
    _backView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_backView];
    _zanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _zanButton.frame = CGRectMake(wKscreen/16, 30, wKscreen/6.4, wKscreen/6.4);
    [_zanButton setBackgroundImage:[UIImage imageNamed:@"zangay.jpg"] forState:UIControlStateNormal];
    _zanButton.layer.cornerRadius = self.zanButton.frame.size.height/2;
    _zanButton.backgroundColor = [UIColor greenColor];
    
    [self.backView addSubview:_zanButton];
    _musicButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _musicButton.frame = CGRectMake(CGRectGetMaxX(self.zanButton.frame)+wKscreen/4.92, 30, CGRectGetWidth(self.zanButton.frame), CGRectGetWidth(self.zanButton.frame));
    _musicButton.layer.cornerRadius = self.musicButton.frame.size.height/2;
    _musicButton.backgroundColor = [UIColor greenColor];
    [_musicButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [self.backView addSubview:_musicButton];
    //旋转图片
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(musicBtnAction) userInfo:nil repeats:YES];
    _deZanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deZanButton.frame = CGRectMake(CGRectGetMaxX(self.musicButton.frame)+wKscreen/4.92, 30, CGRectGetWidth(self.zanButton.frame), CGRectGetWidth(self.zanButton.frame));
    [_deZanButton setBackgroundImage:[UIImage imageNamed:@"qipaogay.jpg"] forState:UIControlStateNormal];
    _deZanButton.layer.cornerRadius = self.deZanButton.frame.size.height/2;
    _deZanButton.backgroundColor = [UIColor greenColor];
    [self.backView addSubview:_deZanButton];
    _activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/4, CGRectGetMaxY(self.musicButton.frame)+20, wKscreen/2, wKscreen/16)];
    _activeLabel.text = @"距离活动开始还有";
    _activeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:_activeLabel];
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/4, CGRectGetMaxY(self.activeLabel.frame), wKscreen/2, wKscreen/16)];
    _timeLabel.text = @"1天07时19分02秒";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor blueColor];
    _timeLabel.font = [UIFont systemFontOfSize:20];
    [self.backView addSubview:_timeLabel];
    _backLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/16, CGRectGetMaxY(self.timeLabel.frame)+20, wKscreen-wKscreen/8, hKscreen/2)];
    _backLabel.backgroundColor = [UIColor whiteColor];
    _backLabel.layer.cornerRadius = 6;
    //[self.backView addSubview:_backLabel];
    _beautyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(wKscreen/16, CGRectGetMaxY(self.timeLabel.frame)+20, wKscreen-wKscreen/8, hKscreen/2)];
    _beautyImageView.image = [UIImage imageNamed:@"2.jpg"];
    [self.backView addSubview:_beautyImageView];
    _zanCountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _zanCountBtn.frame = CGRectMake(wKscreen/16, CGRectGetMaxY(self.backLabel.frame)+wKscreen/16, wKscreen/6.4, wKscreen/6.4);
    _zanCountBtn.backgroundColor = [UIColor greenColor];
    _zanCountBtn.layer.cornerRadius = CGRectGetWidth(self.zanCountBtn.frame)/2;
    [self.backView addSubview:_zanCountBtn];
    _countZanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.zanCountBtn.frame)-20, 0, 60, 20)];
    _countZanLabel.text = @"00赞";
    _countZanLabel.font = [UIFont systemFontOfSize:13];
    _countZanLabel.textColor = [UIColor grayColor];
    [self.zanCountBtn addSubview:_countZanLabel];
    _surplusLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/3, CGRectGetMinY(self.zanCountBtn.frame), wKscreen/3, 20)];
    _surplusLabel.text = @"库存832件";
    [self.backView addSubview:_surplusLabel];
    _commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _commentBtn.frame = CGRectMake(wKscreen-wKscreen/16-wKscreen/6.4, CGRectGetMinY(self.zanCountBtn.frame), wKscreen/6.4, wKscreen/6.4);
    _commentBtn.backgroundColor = [UIColor greenColor];
    _commentBtn.layer.cornerRadius = CGRectGetWidth(self.commentBtn.frame)/2;
    [self.backView addSubview:_commentBtn];
    _numCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.commentBtn.frame)-60, CGRectGetMinY(self.commentBtn.frame), 60, 20)];
    _numCommentLabel.textAlignment = NSTextAlignmentRight;
    _numCommentLabel.textColor = [UIColor grayColor];
    _numCommentLabel.font = [UIFont systemFontOfSize:13];
    _numCommentLabel.text = @"00评论";
    [self.backView addSubview:_numCommentLabel];
    _lastLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.zanCountBtn.frame), CGRectGetMaxY(self.zanCountBtn.frame), wKscreen-wKscreen/8, 1)];
    _lastLabel.backgroundColor = [UIColor grayColor];
    [self.backView addSubview:_lastLabel];
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), wKscreen, 30)];
    _priceLabel.text = @"原价299元买一送一";
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:_priceLabel];
    _nextPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.priceLabel.frame), wKscreen-40, 100)];
    _nextPriceLabel.numberOfLines = 0;
    _nextPriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nextPriceLabel.text = @"母亲是伟大的园丁，每个母亲都应该收到最贴心的礼物。299RMB当598RMB用，5月6日00:00分开始；";
    [self addSubview:_nextPriceLabel];
    _joinLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.nextPriceLabel.frame), wKscreen, 30)];
    _joinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _joinLabel.text = @"参与方法:";
    [self addSubview:_joinLabel];
    _attionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.joinLabel.frame), wKscreen-40, 100)];
    _attionLabel.text = @"购买一套299元原价内衣即可赠送一套同尺码内衣，限量供应500组，送完为止！";
    _attionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _attionLabel.numberOfLines = 0;
    [self addSubview:_attionLabel];
    _severLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.attionLabel.frame), wKscreen, 50)];
    _severLabel.text = @"如有其它需要请注意备注或者联系客服处理!!";
    _severLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _severLabel.numberOfLines = 0;
    [self addSubview:_severLabel];
    _contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.severLabel.frame), wKscreen/3, 50)];
    _contactLabel.text = @"客服微信号：";
    [self addSubview:_contactLabel];
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactLabel.frame), CGRectGetMaxY(self.severLabel.frame), wKscreen-self.contactLabel.frame.size.width-20, 50)];
    _phoneLabel.text = @"Electrolux--77、Betty060919";
    _phoneLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _phoneLabel.numberOfLines = 0;
    _phoneLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:_phoneLabel];
    _custumerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneLabel.frame)+5, wKscreen, 1)];
//    _custumerLabel.layer.borderWidth = 1;
    _custumerLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_custumerLabel];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/3, CGRectGetMaxY(self.custumerLabel.frame)+3, wKscreen/3, 20)];
    _nameLabel.text = @"    客服|顾客";
    _nameLabel.textColor = [UIColor grayColor];
    [self addSubview:_nameLabel];
    _numberPeopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), wKscreen, 20)];
    _numberPeopLabel.textColor = [UIColor redColor];
    _numberPeopLabel.text = @"0";
    _numberPeopLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberPeopLabel];
    _talkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _talkBtn.frame = CGRectMake(wKscreen/4, CGRectGetMaxY(self.numberPeopLabel.frame), wKscreen/2, 20);
    _talkBtn.layer.cornerRadius = 8;
    _talkBtn.layer.borderWidth = 1;
    [_talkBtn setTitle:@"我来说几句" forState:UIControlStateNormal];
    [self addSubview:_talkBtn];

    _MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90+CGRectGetMaxY(self.phoneLabel.frame), wKscreen, hKscreen)];
    //_MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_MyTableView];
    _MyTableView.tableFooterView = [[UIView alloc]init];
    _linLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.MyTableView.frame), wKscreen, 1)];
    _linLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_linLabel];
    _promiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.linLabel.frame)+10, wKscreen, 20)];
    _promiseLabel.text = @"售后承诺";
    _promiseLabel.textColor = [UIColor blueColor];
    _promiseLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_promiseLabel];
    _outLabel = [[UILabel alloc]initWithFrame:CGRectMake(wKscreen/16, CGRectGetMaxY(self.promiseLabel.frame)+10, wKscreen-wKscreen/8, hKscreen/4)];
    _outLabel.layer.borderWidth = 2;
    _outLabel.layer.masksToBounds = YES;
    [self addSubview:_outLabel];
    _inLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 4, CGRectGetWidth(self.outLabel.frame)-8, CGRectGetHeight(self.outLabel.frame)-8)];
    _inLabel.layer.borderWidth = 1;
    _inLabel.layer.masksToBounds = YES;
    [self.outLabel addSubview:_inLabel];
    _aliveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.outLabel.frame)+10, wKscreen, 20)];
    _aliveLabel.textAlignment = NSTextAlignmentCenter;
    _aliveLabel.text = @"生活，不只是活着";
    _aliveLabel.textColor = [UIColor greenColor];
    [self addSubview:_aliveLabel];
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((wKscreen-50)/2, CGRectGetMaxY(self.aliveLabel.frame)+10, 50, 50)];
    _logoImageView.layer.cornerRadius = CGRectGetHeight(self.logoImageView.frame)/2;
    _logoImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_logoImageView];
    
    
}
-(void)musicBtnAction
{
    self.musicButton.layer.transform = CATransform3DRotate(self.musicButton.layer.transform, M_PI/30, 0, 0, 1);
}


@end
