//
//  FirstViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/19.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "FirstViewController.h"
#import "TimeViewController.h"
#import "MusicViewController.h"
#import "ss_LoginViewController.h"
#import "ss_loginRequest.h"
#import "StoreViewController.h"

//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "Circle.h"
#import "BigCircle.h"
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * M_PI/180)
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 180/M_PI)
#define ss_screenWidth [UIScreen mainScreen].bounds.size.width
#define ss_screenHeight [UIScreen mainScreen].bounds.size.height



//首页右上角消息类
#import "ss_MessageViewController.h"



//转盘六个按钮导航跳转
#import "SouthJadeViewController.h"
#import "PinPaiViewController.h"

#import "AppreciateViewController.h"
#import "MasterViewController.h"
#import "ActivityViewController.h"
//static float MAX_SPEED = 1.0;//最大的转动速度
//float MIN_SPEED = 0.05;//最小的转动速度
//float SMALL_ROTATE_DURATION = 0.2;//控制微动画的时间
//float TIMER_INVAL = 0.05;//控制定时器调用指定方法的时间


#import "ss_firstRequest.h"


@interface FirstViewController ()<NSURLConnectionDataDelegate>
{
    CGFloat _lastPointAngle;//上一个点相对于x轴角度
    CGPoint _centerPoint;
    CGFloat _deltaAngle;
    CGFloat _radius;
    CGFloat _lastImgViewAngle;
    
    BOOL updateEnable;
    float angleBig;
    NSTimer *timer;
    NSMutableData * _mutableData;

}
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@end

@implementation FirstViewController
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _mutableData = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mutableData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString * str = [[NSString alloc]initWithData:_mutableData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [ss_firstRequest ss_firstRequestModel:@"" request:^(NSDictionary *dic) {
//
//    }];
//    NSString *urlString = @"http://192.168.2.22:8090/wap/product/list";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setAllHTTPHeaderFields:@{@"appid":@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626", @"appsecret":@"capitalofsouthjadeinchina", @"sessionid":@"xxxxxxxxxxx"}];
//    NSString *paraStr = [NSString stringWithFormat:@"orderType=%@&start=%@&count=%@",@"news", @1, @10];
//    NSData *data = [paraStr dataUsingEncoding:NSUTF8StringEncoding];
//    [urlRequest setHTTPBody:data];
//    [urlRequest setHTTPMethod:@"post"];
//    NSURLConnection * urlConnection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self startImmediately:YES];
//    [urlConnection start];

    
    
    
    
#pragma mark - 点击进入消息页面
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"消息@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goToMessage)];

    
#pragma mark - 添加转盘相关代码开始
    //添加最底部的风景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ss_screenWidth, ss_screenHeight - 64 -49)];
    
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *picturePath = [NSString stringWithFormat:@"%@/bg.png",path];
    
    imageView.image = [UIImage imageWithContentsOfFile:picturePath];
    [self.view addSubview:imageView];
    
    //后来给的背景图片新加一个绿色渐变图片
    UIImageView *imageViewCircle = [[UIImageView alloc] init];
    
    imageViewCircle.center = CGPointMake(ss_screenWidth/2, ss_screenHeight/2 - 64);
    
    
    imageViewCircle.bounds = CGRectMake(0, 0, ss_screenWidth - 20, ss_screenWidth - 20);
    
    NSString *picturePathCircle = [NSString stringWithFormat:@"%@/圆盘.png",path];
    
    imageViewCircle.image = [UIImage imageWithContentsOfFile:picturePathCircle];
    
    [self.view addSubview:imageViewCircle];
    //    中间圆形的绘制（颜色透明）
    Circle *circle = [[Circle alloc] init];
    circle.bounds = CGRectMake(0, 0, ss_screenWidth - 20, ss_screenWidth - 20);
    circle.center = CGPointMake(ss_screenWidth * 0.5f, ss_screenHeight * 0.5f);
    
    debugLog(@"屏幕宽度 = %f 屏幕高度 = %f",ss_screenWidth, ss_screenHeight);
    circle.backgroundColor = [UIColor clearColor];
    //    把绘制的转化为图片
    UIGraphicsBeginImageContext(circle.bounds.size);
    [circle.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.bgImageView = [[UIImageView alloc] init];
    
    
    self.bgImageView.center = CGPointMake(ss_screenWidth/2, ss_screenHeight/2 - 64);
    
    
    self.bgImageView.bounds = circle.bounds;
    self.bgImageView.userInteractionEnabled = YES;
    self.bgImageView.image = image;
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        if (ss_screenWidth > 400) {//说明屏幕宽度为414
            //debugLog(@"1屏幕宽度为%f",ss_screenWidth);
            CGFloat btnW = 80;
            CGFloat btnH = 170;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.imageEdgeInsets = UIEdgeInsetsMake(20, 25, 120, 25);
            btn.titleEdgeInsets = UIEdgeInsetsMake(-50, -80, 0, 0);
        } else if (ss_screenWidth > 350) {//说明屏幕宽度为375
            //debugLog(@"2屏幕宽度为%f",ss_screenWidth);
            CGFloat btnW = 60;
            CGFloat btnH = 170 - 20;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 110, 15);
            btn.titleEdgeInsets = UIEdgeInsetsMake(-50, -80, 0, 0);
        } else {//说明屏幕宽度为320
            //debugLog(@"3屏幕宽度为%f",ss_screenWidth);
            CGFloat btnW = 60;
            CGFloat btnH = 170 - 50;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 90, 15);
            btn.titleEdgeInsets = UIEdgeInsetsMake(-35, -80, 0, 0);
        }
        
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake((ss_screenWidth - 20)/2, (ss_screenWidth - 20)/2);
        CGFloat angle = i * (M_PI * 2 / 6);
        
        
        
        switch (i) {
                
            case 0:{
                [btn setTitle:@"南玉" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"Southjade.png"] forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [btn setTitle:@"品牌" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"brand.png"] forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [btn setTitle:@"店铺" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"Thestore.png"] forState:UIControlStateNormal];
            }
                break;
            case 3:{
                [btn setTitle:@"鉴赏" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"appreciation.png"] forState:UIControlStateNormal];
            }
                break;
            case 4:{
                [btn setTitle:@"大师" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"Themaster.png"] forState:UIControlStateNormal];
            }
                break;
            case 5:{
                [btn setTitle:@"活动" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"activity.png"] forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(goToDetail:) forControlEvents:UIControlEventTouchUpInside];
        btn.transform = CGAffineTransformMakeRotation(angle);
        [self.bgImageView addSubview:btn];
    }
    
    [self.view addSubview:self.bgImageView];
    
    
    angleBig = 0;
    updateEnable = NO;
    /**
     *  添加一个定时器到runloop中，实时监测用户的触摸事件，滑动结束时updateEnable = YES并
     *  执行update方法，并逐渐减速
     */
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    timer =[ NSTimer timerWithTimeInterval:1.0f/60 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [timer fire];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    
    
    
    
    
    CGFloat centerX = ss_screenWidth * 0.5f;
    CGFloat centerY = ss_screenHeight * 0.5f - 64;
    _centerPoint = CGPointMake(centerX, centerY);//中心点
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 100);
    btn.center = _centerPoint;
    [btn addTarget:self action:@selector(backToStartState) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *smallView = [[UIView alloc] init];
    smallView.center = CGPointMake(centerX, centerY);
    smallView.backgroundColor = [UIColor whiteColor];
    
    self.centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.centerImageView.center = CGPointMake(centerX, centerY);
    
    if (ss_screenWidth > 400) {
        smallView.bounds = CGRectMake(0, 0, 124, 124);
        smallView.layer.cornerRadius = 62;
        self.centerImageView.bounds = CGRectMake(0, 0, 114, 114);
    } else if (ss_screenWidth > 350) {
        smallView.bounds = CGRectMake(0, 0, 112, 112);
        smallView.layer.cornerRadius = 56;
        self.centerImageView.bounds = CGRectMake(0, 0, 103, 103);
    }
    else if (ss_screenWidth < 350) {
        smallView.bounds = CGRectMake(0, 0, 96, 96);
        smallView.layer.cornerRadius = 48;
        self.centerImageView.bounds = CGRectMake(0, 0, 88, 88);
    }
    
    [self.view addSubview:smallView];
    [self.view addSubview:self.centerImageView];
    [self.view addSubview:btn];
    //添加中国南玉之都作为titleView
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    //    barView.backgroundColor = [UIColor redColor];
    UIImageView *barImageView = [[UIImageView alloc] init];
    barImageView.frame = barView.frame;
    barImageView.image = [UIImage imageNamed:@"标题.png"];
    [barView addSubview:barImageView];
    self.navigationItem.titleView = barView;
    
    
    
    
    
}


- (void)goToMessage {
    ss_MessageViewController *vc = [[ss_MessageViewController alloc] init];
    id bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  跳转至登录页面
 */
- (void)goToLogin {
    ss_LoginViewController *vc = [[ss_LoginViewController alloc] init];
    
    id bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goToLogout {
    debugLog(@"退出");
    
    
    
    
    UIAlertController *logoutVC = [UIAlertController alertControllerWithTitle:@"确认退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionNO = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionYES = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [ss_loginRequest ss_logoutHTTPRequest:^(NSDictionary *dic) {
            //回调请求成功
            if ([dic[@"resultMessage"] isEqual:@"已退出"]) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERNAME"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PASSWORD"];
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"登录@2x.png"]
                                                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                         style:UIBarButtonItemStylePlain
                                                                                        target:self
                                                                                        action:@selector(goToLogin)];
            }
        }];
        
        
    }];
    [logoutVC addAction:actionNO];
    [logoutVC addAction:actionYES];
    [self presentViewController:logoutVC animated:YES completion:nil];
    
    
    
}

//
//-(void)ButtonActionToCircleViewWithIndex:(NSInteger)index
//{
//    NSLog(@"index = %d",@(index));
//    if (index == 1) {
//        TimeViewController *tVC = [[TimeViewController alloc]init];
//        [self.navigationController pushViewController:tVC animated:YES];
//    }
//    NSLog(@"代理方法");
//    
//}
//-(void)bAction:(NSInteger)i
//{
//    NSLog(@"aaaaaaaaaaaaaaaaaa");
//}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    debugLog(@"我将要出现了");
    //给导航条设置背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条背景@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.tabBarController.tabBar.hidden = NO;

    
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
    if (username.length != 0 && password.length != 0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"退出@2x.png"]
                                                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(goToLogout)];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"登录@2x.png"]
                                                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(goToLogin)];
    }
}




- (void)viewWillDisappear:(BOOL)animated {
//    debugLog(@"我将要消失了");
    
    id bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    self.tabBarController.tabBar.hidden = YES;

}



/**
 *  点击转盘上的每一个相应的按钮跳转至详情页
 *
 *  @param sender 对应于每一个按钮
 */
- (void)goToDetail:(UIButton *)sender {
    //    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    self.tabBarController.tabBar.hidden = YES;

   
    

    switch (sender.tag) {
        case 100: {
            debugLog(@"我是南玉按钮");
            SouthJadeViewController *vc = [[SouthJadeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 101: {
            debugLog(@"我是品牌按钮");
            PinPaiViewController *vc = [[PinPaiViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 102: {
            self.navigationController.navigationBarHidden = YES;
            StoreViewController *Svc = [[StoreViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:YES];
        }
            break;
        case 103: {
            debugLog(@"我是鉴赏按钮");
            AppreciateViewController *vc = [[AppreciateViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 104: {
            debugLog(@"我是大师按钮");
            MasterViewController *vc = [[MasterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 105: {
            debugLog(@"我是活动按钮");
            ActivityViewController *vc = [[ActivityViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)setRotate:(float)degress
{
    //    NSLog(@"%f",degress);
    float rotate = CC_DEGREES_TO_RADIANS(degress);
    
    CGAffineTransform transform = self.bgImageView.transform;
    transform = CGAffineTransformRotate(transform, rotate);
    self.bgImageView.transform = transform;
    
}

/**
 *  滑动结束时旋转减速动画
 */
- (void)update
{
    if(updateEnable)
    {
        if(fabs(angleBig)>1)
        {
            [self setRotate:angleBig];
            angleBig = 0.935*angleBig;
        }
        else
        {
            angleBig = 0;
        }
    }
    
}

/**
 *  中间按钮绑定的事件
 */
- (void)backToStartState {
    debugLog(@"我是中间按钮,归位");
    [UIView animateWithDuration:0.5 animations:^{
        //        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.bgImageView.transform = CGAffineTransformMakeRotation(angleBig *M_PI/180 + M_PI * 2);
        
    }];
    
    
//    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//        self.bgImageView.transform = CGAffineTransformMakeRotation(angleBig *M_PI/180 + M_PI * 2);

//    } completion:nil];
    
    
    //    _recordAngle = 0;
    angleBig = 0;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    angleBig = 0;
    updateEnable = NO;
    self.bgImageView.userInteractionEnabled = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    //计算开始点相对于x轴的角度
    CGFloat lastPointRadius = sqrt(pow(point.y - _centerPoint.y, 2) + pow(point.x - _centerPoint.x, 2));
    if (lastPointRadius == 0) {
        return;
    }
    _lastPointAngle = acos((point.x - _centerPoint.x) / lastPointRadius);
    if (point.y > _centerPoint.y) {
        _lastPointAngle = 2 * M_PI - _lastPointAngle;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    angleBig = 0;
    updateEnable = NO;
    self.bgImageView.userInteractionEnabled = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    //1.计算当前点相对于x轴的角度
    CGFloat currentPointRadius = sqrt(pow(currentPoint.y - _centerPoint.y, 2) + pow(currentPoint.x - _centerPoint.x, 2));
    if (currentPointRadius == 0) {//当点在中心点时，被除数不能为0
        return;
    }
    CGFloat curentPointAngle = acos((currentPoint.x - _centerPoint.x) / currentPointRadius);
    if (currentPoint.y > _centerPoint.y) {
        curentPointAngle = 2 * M_PI - curentPointAngle;
    }
    //2.变化的角度
    CGFloat angle = _lastPointAngle - curentPointAngle;
    
    angleBig = 180/M_PI*angle;
    
    //    NSLog(@"变化的角度为 == %f",angleBig);
    
    
    self.bgImageView.transform = CGAffineTransformRotate(self.bgImageView.transform, angle);
    _lastImgViewAngle = fmod(_lastImgViewAngle + angle, 2 * M_PI);//对当前角度取模
    _lastPointAngle = curentPointAngle;
    
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    updateEnable = YES;
    self.bgImageView.userInteractionEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
