//
//  BuyShowViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "BuyShowViewController.h"
//#import "BuyShowView.h"
#import "ZLScrolling.h"
#import "ChoseView.h"
#import "MakeSureViewController.h"
#import "LinkStoreViewController.h"
@interface BuyShowViewController ()<ZLScrollingDelegate>
{
    ChoseView *choseView;//尺寸选择所需对象
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockdic;//商品库存量
}
@property(nonatomic,strong)NSDictionary *stockdic;//商品库存量
//@property(nonatomic,strong)BuyShowView *bView;
@end

@implementation BuyShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商品详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"queBac"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//    self.bView = [[BuyShowView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen-30)];
//    [self.view addSubview:self.bView];
    [self set_up];
    
    
    NSArray *url = @[@"http://e.hiphotos.baidu.com/lvpics/h=800/sign=61e9995c972397ddc97995046983b216/35a85edf8db1cb134d859ca8db54564e93584b98.jpg", @"http://e.hiphotos.baidu.com/lvpics/h=800/sign=1d1cc1876a81800a71e5840e813533d6/5366d0160924ab185b6fd93f33fae6cd7b890bb8.jpg", @"http://f.hiphotos.baidu.com/lvpics/h=800/sign=8430a8305cee3d6d3dc68acb73176d41/9213b07eca806538d9da1f8492dda144ad348271.jpg", @"http://d.hiphotos.baidu.com/lvpics/w=1000/sign=81bf893e12dfa9ecfd2e521752e0f603/242dd42a2834349b705785a7caea15ce36d3bebb.jpg", @"http://f.hiphotos.baidu.com/lvpics/w=1000/sign=4d69c022ea24b899de3c7d385e361c95/f31fbe096b63f6240e31d3218444ebf81a4ca3a0.jpg"];
    NSMutableArray *urlarr = [NSMutableArray array];
    for (NSString *str in url) {
        NSURL *imurl = [NSURL URLWithString:str];
        [urlarr addObject:imurl];
    }
    ZLScrolling *zl = [[ZLScrolling alloc]initWithCurrentController:self frame:CGRectMake(20, CGRectGetMaxY(self.headPicImage.frame)+10+10+10, CGRectGetWidth(self.StoreBackLbl.frame)-20, CGRectGetHeight(self.StoreBackLbl.frame)/3*2) photos:urlarr placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
    zl.pageControl.pageIndicatorTintColor = [UIColor redColor];
    zl.pageControl.backgroundColor = [UIColor yellowColor];
    
    _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(zl.view.frame)-40, CGRectGetWidth(zl.view.frame), 40)];
    _priceLbl.backgroundColor = [UIColor whiteColor];
    _priceLbl.text = @"碧玉尊天然和田玉手镯           ¥2000";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"碧玉尊天然和田玉手镯          ¥2000"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 10)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(20,5)];
    _priceLbl.attributedText = str;
    [zl.view addSubview:_priceLbl];
    [self.backScrollView addSubview:zl.view];
    zl.delegate = self;
    
    //立即购买  plist文件
    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
    NSString *strPlist = [[NSBundle mainBundle] pathForResource:@"stock" ofType:@"plist"];
   // NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
    stockdic = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strPlist]];
    //NSLog(@"dict = %@",stockdic);
}
-(void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index
{
    NSLog(@"点击到＝＝＝＝＝＝＝＝%ld",index);
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)set_up
{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen-30)];
    _backScrollView.contentSize = CGSizeMake(wKscreen, hKscreen*1.5);
    [self.view addSubview:_backScrollView];
    _StoreBackLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, wKscreen-20, hKscreen/4*3)];
    _StoreBackLbl.layer.masksToBounds = YES;
    _StoreBackLbl.layer.borderWidth = 1;
    _StoreBackLbl.layer.borderColor = [UIColor grayColor].CGColor;
    _StoreBackLbl.layer.cornerRadius = 16;
    _StoreBackLbl.userInteractionEnabled = YES;
    [self.backScrollView addSubview:_StoreBackLbl];
    _headPicImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _headPicImage.layer.cornerRadius = self.headPicImage.frame.size.width/2;
    _headPicImage.layer.masksToBounds = YES;
    _headPicImage.image = [UIImage imageNamed:@"2.jpg"];
    [self.StoreBackLbl addSubview:_headPicImage];
    _StoreNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headPicImage.frame)+10, 5, 150, 50)];
    _StoreNameLbl.text = @"周大福旗舰店";
    _StoreNameLbl.font = [UIFont systemFontOfSize:20.f];
    _StoreNameLbl.textColor = [UIColor grayColor];
    [self.StoreBackLbl addSubview:_StoreNameLbl];
    _walkIntoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _walkIntoBtn.frame = CGRectMake(CGRectGetWidth(self.StoreBackLbl.frame)-10-70, 15, 70, 30);
    [_walkIntoBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    _walkIntoBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [_walkIntoBtn addTarget:self action:@selector(putinStore) forControlEvents:UIControlEventTouchUpInside];
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
//    _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_goodsScrollView.frame)-20, CGRectGetWidth(_goodsScrollView.frame), 20)];
//    _priceLbl.text = @"碧玉尊天然和田玉手镯           ¥2000";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"碧玉尊天然和田玉手镯          ¥2000"];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 10)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(20,5)];
//    _priceLbl.attributedText = str;
//    [_goodsScrollView addSubview:_priceLbl];
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
    [_zanBtn addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
    [_zanBtn setImage:[[UIImage imageNamed:@"collection.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [_zanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _zanBtn.titleEdgeInsets = UIEdgeInsetsMake(35, -32, 0, 2);
    
    [self.StoreBackLbl addSubview:_zanBtn];
    _musicImage = [[UIImageView alloc]initWithFrame:CGRectMake(wKscreen/2-25, CGRectGetMaxY(_lineImage.frame)+10, 50,50)];
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
    _pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.segmentControl.frame)+10, wKscreen-40, 230)];
    _pictureImage.image = [UIImage imageNamed:@"1.jpg"];
    [self.backScrollView addSubview:_pictureImage];
    //加入购物车
    self.addToCarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addToCarBtn.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-50, wKscreen/2, 50);
    self.addToCarBtn.backgroundColor = [UIColor orangeColor];
    [self.addToCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addToCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addToCarBtn setBackgroundImage:[UIImage imageNamed:@"addbasket"] forState:UIControlStateNormal];
    [self.addToCarBtn addTarget:self action:@selector(addToCarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addToCarBtn];
    //立即购买
    self.determineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.determineBtn.frame = CGRectMake(wKscreen/2, hKscreen-50, wKscreen/2, 50);
    self.determineBtn.backgroundColor = [UIColor redColor];
    [self.determineBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.determineBtn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.determineBtn];
    
}
-(void)putinStore
{
    LinkStoreViewController *lVC = [[LinkStoreViewController alloc] init];
    [self.navigationController pushViewController:lVC animated:YES];
}
-(void)timerAction
{
    self.musicImage.layer.transform = CATransform3DRotate(self.musicImage.layer.transform, M_PI/30, 0, 0, 1);
}
-(void)addCount:(UIButton *)sender
{
    NSInteger count = 123;
    count = count +1;
    [_zanBtn setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
}
-(void)addToCarBtnAction
{
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [choseView initTypeView:sizearr :colorarr :stockdic];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
}
-(void)dismiss
{
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
}
-(void)sure
{
    [self  dismiss];
    //[self showAlert:@"已经加入购物车"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经加入购物车" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];//显示消息框
    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2.0f];//2秒后执行
}
/**
 *  移除弹框
 */
-(void)dismissAlert:(UIAlertView *)alert
{
    if (alert) {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}
-(void)actionBtn
{
    MakeSureViewController *vc = [[MakeSureViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
