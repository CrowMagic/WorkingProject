//
//  PayView.m
//  结算购物车
//
//  Created by giikylee on 16/6/6.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import "PayView.h"
#define Kwith  self.frame.size.width
#define Kheight  self.frame.size.height
#define btnHeight  Kheight/14
@implementation PayView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView
{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];//透明背景
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.5;
    [self addSubview:_backView];
    _dataView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame), self.frame.size.width, self.frame.size.height - CGRectGetHeight(_backView.frame))];//付款详情背景
    _dataView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dataView];
    _dissmissBtn = [UIButton buttonWithType:UIButtonTypeSystem];//左边按钮  消失
    _dissmissBtn.frame = CGRectMake(Kwith/32, 7, 30, 30);
    [_dissmissBtn setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:UIControlStateNormal];
   // [_dissmissBtn addTarget:self action:@selector(dissBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_dataView addSubview:_dissmissBtn];
    _detailLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/2-50,5, 100, Kheight/16)];
    _detailLbl.text = @"付款详情";
    _detailLbl.textAlignment = NSTextAlignmentCenter;
    [self.dataView addSubview:_detailLbl];
    _questionBtn = [UIButton buttonWithType:UIButtonTypeSystem];//右边按钮  问题
    _questionBtn.frame = CGRectMake(Kwith-Kwith/32-30, 7, 30, 30);
    [_questionBtn setBackgroundImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
    [self.dataView addSubview:_questionBtn];
    _firstLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLbl.frame), Kwith, 1)];//付款详情  第一条横线
    _firstLbl.backgroundColor = [UIColor grayColor];
    [self.dataView addSubview:_firstLbl];
    //
    _userNameBtn = [UIButton buttonWithType:UIButtonTypeSystem];//支付账户
    _userNameBtn.frame = CGRectMake(0, CGRectGetMaxY(_firstLbl.frame), Kwith, btnHeight);
   // [_userNameBtn addTarget:self action:@selector(nameBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.dataView addSubview:_userNameBtn];
    _huLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/32, 0, Kwith/3.2, btnHeight)];
    _huLbl.text = @"支付账户";
    _huLbl.textColor = [UIColor grayColor];
    _huLbl.font = [UIFont systemFontOfSize:13];
    [_userNameBtn addSubview:_huLbl];
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith-Kwith/32-200, 0, 200, btnHeight)];
    _nameLbl.textColor = [UIColor grayColor];
    _nameLbl.textAlignment = NSTextAlignmentRight;
    _nameLbl.font = [UIFont systemFontOfSize:13];
    _nameLbl.text = @"my163@163.com";
    [_userNameBtn addSubview:_nameLbl];
    _secondLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/32, CGRectGetMaxY(_userNameBtn.frame), Kwith-Kwith/16, 1)];//第二条横线
    _secondLbl.backgroundColor = [UIColor grayColor];
    [self.dataView addSubview:_secondLbl];
    _payStyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _payStyBtn.frame = CGRectMake(0, CGRectGetMaxY(_secondLbl.frame), Kwith, CGRectGetHeight(_userNameBtn.frame));//付款方式
   // [_payStyBtn addTarget:self action:@selector(payStyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.dataView addSubview:_payStyBtn];
    _fuLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/32, 0, 100, CGRectGetHeight(_userNameBtn.frame))];
    _fuLbl.text = @"付款方式";
    _fuLbl.textColor = [UIColor grayColor];
    _fuLbl.font = [UIFont systemFontOfSize:13];
    [_payStyBtn addSubview:_fuLbl];
    _bankCarLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_fuLbl.frame), 0, Kwith-100-30, CGRectGetHeight(_userNameBtn.frame))];
    _bankCarLbl.textColor = [UIColor grayColor];
    _bankCarLbl.textAlignment = NSTextAlignmentRight;
    _bankCarLbl.text = @"交通银行储蓄卡（8888）";
    _bankCarLbl.font = [UIFont systemFontOfSize:13];
    [_payStyBtn addSubview:_bankCarLbl];
    _imageLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bankCarLbl.frame), 0, 20, CGRectGetHeight(_userNameBtn.frame))];
    _imageLbl.text = @">";
    _imageLbl.font = [UIFont systemFontOfSize:20];
    _imageLbl.textColor = [UIColor grayColor];
    [_payStyBtn addSubview:_imageLbl];
    _thiredLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/32, CGRectGetMaxY(_payStyBtn.frame), Kwith-Kwith/16, 1)];//第三条横线
    _thiredLbl.backgroundColor = [UIColor grayColor];
    [self.dataView addSubview:_thiredLbl];
    _needPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];//需付款
    _needPayBtn.frame = CGRectMake(0, CGRectGetMaxY(_thiredLbl.frame), Kwith, CGRectGetHeight(_userNameBtn.frame));
    //[_needPayBtn addTarget:self action:@selector(needPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.dataView addSubview:_needPayBtn];
    _needFuLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith/32, 0, 100, CGRectGetHeight(_needPayBtn.frame))];
    _needFuLbl.text = @"需付款";
    _needFuLbl.font = [UIFont systemFontOfSize:15];
    [_needPayBtn addSubview:_needFuLbl];
    _moneyLbl = [[UILabel alloc]initWithFrame:CGRectMake(Kwith-Kwith/32-200, 0, 200, CGRectGetHeight(_needPayBtn.frame))];
    _moneyLbl.textAlignment = NSTextAlignmentRight;
    _moneyLbl.text = @"433.00元";
    _moneyLbl.font = [UIFont systemFontOfSize:15];
    [_needPayBtn addSubview:_moneyLbl];
    _makePayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _makePayBtn.frame = CGRectMake(Kwith/32, CGRectGetMaxY(_needPayBtn.frame), Kwith-Kwith/16, CGRectGetHeight(_needPayBtn.frame)/2);
    _makePayBtn.layer.cornerRadius = 8;
    _makePayBtn.layer.masksToBounds = YES;
    _makePayBtn.backgroundColor = [UIColor colorWithRed:39/255.0 green:171/255.0 blue:236/255.0 alpha:1];
    [_makePayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_makePayBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [self.dataView addSubview:_makePayBtn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
