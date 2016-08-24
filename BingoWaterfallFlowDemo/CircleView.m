//
//  CircleView.m
//  CircleAnimation
//
//  Created by PC-LiuChunhui on 16/4/12.
//  Copyright © 2016年 Mr.Wendao. All rights reserved.
//

#import "CircleView.h"
#import "StoreViewController.h"
#define kTag 100
//弧度转化为角度
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 180/M_PI)
//角度转化为弧度
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * M_PI/180)


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height




#import "PinPaiViewController.h"
#import "ActivityViewController.h"
//#import "JadeCollectionViewController.h"
#import "AppreciateViewController.h"
#import "MasterViewController.h"
#import "ZYSViewController.h"



@interface CircleView() {
    CGFloat _lastPointAngle;//上一个点相对于x轴角度
    CGPoint _centerPoint;
    CGFloat _deltaAngle;
    CGFloat _radius;
    CGFloat _lastImgViewAngle;
    
    BOOL updateEnable;
    float angleBig;
    NSTimer *timer;
    
    CGFloat _recordAngle;//记录一下旋转的角度
    
}
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIImageView *bgImageView;
@end
@implementation CircleView



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



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    
    angleBig = 0;
    updateEnable = NO;
    
    
    
    self.bgImageView = [[UIImageView alloc]init];
    _bgImageView.bounds = self.bounds;
    
    self.bgImageView.frame = CGRectMake(0, 0, kScreenWidth - 20, kScreenWidth - 20);
    _bgImageView.backgroundColor = GColor;
    
    self.bgImageView.layer.cornerRadius = (kScreenWidth - 20)/2;
    [self addSubview:self.bgImageView];
    
    /**
     *  添加一个定时器到runloop中，实时监测用户的触摸事件，滑动结束时updateEnable = YES并
     *  执行update方法，并逐渐减速
     */
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    timer =[ NSTimer timerWithTimeInterval:1.0f/60 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [timer fire];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    CGFloat centerX = CGRectGetWidth(self.frame) * 0.5f;
    CGFloat centerY = centerX;
    _centerPoint = CGPointMake(centerX, centerY);//中心点
    
    
    
    //    self.centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    //    self.centerImageView.bounds = CGRectMake(0, 0, 100, 100);
    //    self.centerImageView.center = _centerPoint;
    //    [self addSubview:self.centerImageView];
    /**
     *  中间的按钮
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 100);
    btn.center = _centerPoint;
    [btn addTarget:self action:@selector(backToStartState) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];//蓝色view
    _blueView.center = _centerPoint;
    _blueView.backgroundColor = [UIColor blueColor];
    //    [self addSubview:_blueView];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//红色view
    redView.backgroundColor = [UIColor redColor];
    //    [_blueView addSubview:redView];
    
    _deltaAngle = M_PI / 3.0f;//6个imgView的间隔角度
    CGFloat currentAngle = 0;
    CGFloat imgViewCenterX = 0;
    CGFloat imgViewCenterY = 0;
    CGFloat imgViewW = 80;
    CGFloat imgViewH =imgViewW;
    _radius = centerX - imgViewW * 0.5f;//imgView.center到self.center的距离
    for (int i = 0; i < 6; i++) {
        currentAngle = _deltaAngle * i;
        imgViewCenterX = centerX + _radius * sin(currentAngle);
        imgViewCenterY = centerY - _radius * cos(currentAngle);
        UIButton *imgView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imgViewW, imgViewH)];
        imgView.tag = kTag + i;
        imgView.center = CGPointMake(imgViewCenterX, imgViewCenterY);
        //        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"circle%d", i]];
        //[imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"circle%d", i]] forState:UIControlStateNormal];
//        UIImage *image = [UIImage imageNamed:@"nanyu"];
//        uiimq
        [imgView setImage:[UIImage imageNamed:@"nanyu"] forState:UIControlStateNormal];
        imgView.backgroundColor = [UIColor redColor];
        imgView.layer.cornerRadius = 40;
        imgView.layer.masksToBounds = YES;
        
        [imgView addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgImageView addSubview:imgView];
    }
}
/**
 *  转盘每一个按钮绑定事件
 *
 *  @param sender 每一个按钮的tag值
 */
- (void)gotoDetail:(UIButton *)sender {
    NSLog(@"我是第%ld按钮",(long)sender.tag);
    
    
    UITabBarController *nav = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController *vc = nav.viewControllers[0];

    switch (sender.tag) {
        case 100: {
//            JadeCollectionViewController*MVC = [[JadeCollectionViewController alloc] init];
//            //            AVC.navigationController.navigationBarHidden = YES;
//            MVC.navigationItem.hidesBackButton = YES;
//            [vc pushViewController:MVC animated:YES];
        }
            break;
            //品牌
        case 101: {
            PinPaiViewController *PVC = [[PinPaiViewController alloc] init];
            [vc pushViewController:PVC animated:YES];

        }
            break;
        case 102: {
            vc.navigationBarHidden = YES;
            StoreViewController *Svc = [[StoreViewController alloc]init];
            [vc pushViewController:Svc animated:YES];
            
        }
            break;
        case 103: {
            AppreciateViewController *AVC = [[AppreciateViewController alloc] init];
            //            AVC.navigationController.navigationBarHidden = YES;
            //        AVC.navigationItem.hidesBackButton = YES;
            [vc pushViewController:AVC animated:YES];

        }
            break;
        case 104: {
            ZYSViewController*MVC = [[ZYSViewController alloc] init];
            //            AVC.navigationController.navigationBarHidden = YES;
            //        AVC.navigationItem.hidesBackButton = YES;
            [vc pushViewController:MVC animated:YES];
        }
            break;
        case 105: {
            ActivityViewController *AVC = [[ActivityViewController alloc] init];
            [vc pushViewController:AVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}


/**
 *  中间按钮绑定的事件
 */
- (void)backToStartState {
    NSLog(@"我是中间按钮");
    NSLog(@"angleBig == %f",angleBig);
    [UIView animateWithDuration:0.5 animations:^{
        self.bgImageView.transform = CGAffineTransformMakeRotation(angleBig *M_PI/180);
        
    }];
    //    _recordAngle = 0;
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    angleBig = 0;
    updateEnable = NO;
    self.bgImageView.userInteractionEnabled = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
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
    CGPoint currentPoint = [touch locationInView:self];
    
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
    
    
    self.bgImageView.transform = CGAffineTransformRotate(_blueView.transform, angle);
    _blueView.transform = CGAffineTransformRotate(_blueView.transform, angle);
    _lastImgViewAngle = fmod(_lastImgViewAngle + angle, 2 * M_PI);//对当前角度取模
    //    CGFloat currentAngle = 0;
    //    CGFloat imgViewCenterX = 0;
    //    CGFloat imgViewCenterY = 0;
    //    for (int i = 0; i < 6; i++) {
    //        UIImageView *imgView = [self viewWithTag:kTag];
    //        currentAngle = _deltaAngle * i + _lastImgViewAngle;
    //        imgViewCenterX = _centerPoint.x + _radius * sin(currentAngle);
    //        imgViewCenterY = _centerPoint.x - _radius * cos(currentAngle);
    //        imgView = [self viewWithTag:kTag + i];
    //        imgView.center = CGPointMake(imgViewCenterX, imgViewCenterY);
    //    }
    
    _lastPointAngle = curentPointAngle;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    updateEnable = YES;
    //    NSLog(@"滑动结束了");
    self.bgImageView.userInteractionEnabled = YES;
    
}


@end
