//
//  ss_FindPasswordBackViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/27/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_FindPasswordBackViewController.h"
#import "ss_findBackRequest.h"
#import "ss_findBackModel.h"



#import "ModifyPasswordViewController.h"

#import "ss_newPasswordViewController.h"


#import "ss_drawCircle.h"




@interface ss_FindPasswordBackViewController ()<UITextFieldDelegate> {
    int second;//倒计时总时间
    dispatch_source_t aTimer;//GCD版定时器

}

@property (nonatomic, strong) UIImageView *myMyselectImageView;

@property (nonatomic, strong) UILabel *alertLabel;
@end

@implementation ss_FindPasswordBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    
    second = 60;
    
    // Do any additional setup after loading the view from its nib.
    self.myFirstView.layer.cornerRadius = 8;
    self.mySecondView.layer.cornerRadius = 8;
    self.myFirstView.layer.masksToBounds = YES;
    self.mySecondView.layer.masksToBounds = YES;
    self.myNextStepButton.layer.cornerRadius = 8;

    
    self.myPhoneTF.delegate = self;
    self.myEmailTF.delegate = self;
//    self.myVerifyCodeTF.delegate = self;
    
    //初始状态获取验证码不可点击
    self.getVerifyCode.enabled = NO;
    self.getVerifyCode.backgroundColor = [UIColor grayColor];

    
  //记录是选择的手机还是邮箱
    self.myFirstButton.selected = YES;//选择的是手机
    self.mySecondButton.selected = NO;//选择的是邮箱
    
    self.myEmailTF.backgroundColor = [UIColor lightGrayColor];
    self.myEmailTF.userInteractionEnabled = NO;
    
    //画选择手机或邮箱的两个小圆
    [self initWithFirstCircle];
    [self inintWithSecondCircle];

}

- (void)initWithFirstCircle {
    ss_drawCircle *aView  = [[ss_drawCircle alloc] initWithFrame:CGRectMake(0 , 0, 40, 40)];
    aView.backgroundColor = [UIColor whiteColor];
    aView.userInteractionEnabled = NO;
    [self.myFirstButton addSubview:aView];
    
    self.myMyselectImageView = [[UIImageView alloc]init];
    self.myMyselectImageView.center = aView.center;
    self.myMyselectImageView.bounds = CGRectMake(0, 0, 25, 25);
    self.myMyselectImageView.image = [UIImage imageNamed:@"选择.png"];
    [self.myFirstButton addSubview:self.myMyselectImageView];
}

- (void)inintWithSecondCircle {
    ss_drawCircle *aView = [[ss_drawCircle alloc] initWithFrame:CGRectMake(0 , 0, 40, 40)];
    aView.backgroundColor = [UIColor whiteColor];
    aView.userInteractionEnabled = NO;
    [self.mySecondButton addSubview:aView];
}





- (void)textFieldDidEndEditing:(UITextField *)textField {
    //通过手机获取验证码并且获取验证码按钮可用
    if (self.myPhoneTF.text.length == 11 && self.myFirstButton.selected == YES ) {
        debugLog(@"手机号已输入,等待获取验证码");
        
            self.getVerifyCode.enabled = YES;
            self.getVerifyCode.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
        
    }
//        else {
//        self.myPhoneTF.text = nil;
//        self.myPhoneTF.placeholder = @"请输入正确的手机号";
//        [self shakeAnimationForView:self.myPhoneTF];
//    }
    //通过邮箱获取验证码并且获取验证码按钮可用
    if (self.myEmailTF.text.length != 0 && self.mySecondButton.selected == YES) {
        debugLog(@"邮箱已输入，等待获取验证码");
        self.getVerifyCode.enabled = YES;
        self.getVerifyCode.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
    }
}


- (IBAction)getVerifyCodeButton:(UIButton *)sender {
    
    #pragma mark - 验证码倒计时代码开始
    self.getVerifyCode.enabled = NO;
    self.getVerifyCode.backgroundColor = [UIColor lightGrayColor];
    aTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(aTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(aTimer, ^{
        
        if ( self.myFirstButton.selected == YES) {
           
            self.mySecondButton.selected = NO;//选择的是邮箱
        } else if (self.myFirstButton.selected == NO) {
            self.mySecondButton.selected = YES;//选择的是邮箱

        }
        
        second--;
        if (second == 0) {
            dispatch_source_cancel(aTimer);
            aTimer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.getVerifyCode setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.getVerifyCode.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
                self.getVerifyCode.enabled = YES;
            });
            second = 60;
            
            return;
        }
        NSString *title = [NSString stringWithFormat:@"%2.d秒",second];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.getVerifyCode setTitle:title forState:UIControlStateNormal];
        });
    });
    dispatch_resume(aTimer);
    
#pragma mark - 验证码倒计时代码结束

    
    //说明是通过手机来获取验证码
    if (self.myFirstButton.selected == YES) {
        debugLog(@"通过手机获取验证码");
      
    }
    //说明是通过邮箱来获取验证码
    if (self.mySecondButton.selected == YES) {
        debugLog(@"通过邮箱获取验证码");
        ss_findBackModel *model = [[ss_findBackModel alloc] init];
        model.email = self.myEmailTF.text;
        
        [ss_findBackRequest ss_sendEmailVerifyCodeHTTPRequestModel:model request:^(NSMutableArray *object) {
            
        }];
    }
   
    
    
    
}



- (IBAction)myNextStepButton:(UIButton *)sender {
    
    ss_findBackModel *model = [[ss_findBackModel alloc] init];
    model.valnum = self.myVerifyCodeTF.text;
    
    
    [ss_findBackRequest ss_checkTheEmailVerifyCodeHTTPRequest:model request:^(NSDictionary *dictionary) {
        debugLog(@"dictionary == %@",dictionary);
        if ([dictionary[@"resultMessage"] isEqual:@"验证码正确"]) {
            ss_newPasswordViewController *vc = [[ss_newPasswordViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            debugLog(@"验证码错误");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
   
    
}

- (IBAction)myFirstCircleButton:(UIButton *)sender {
    if (self.myFirstButton.subviews.count == 2) {
        debugLog(@"有图片，不用添加");
        return;
    } else {
        [self.myMyselectImageView removeFromSuperview];
        [self.myFirstButton addSubview:self.myMyselectImageView];
        debugLog(@"没图片，用添加");
        self.myPhoneTF.backgroundColor = [UIColor whiteColor];
        self.myPhoneTF.userInteractionEnabled = YES;
        self.myEmailTF.backgroundColor = [UIColor lightGrayColor];
        self.myEmailTF.userInteractionEnabled = NO;
        self.myFirstButton.selected = YES;//选择的是手机
        self.mySecondButton.selected = NO;//选择的是邮箱
    }
}

- (IBAction)mySecondCircleButton:(UIButton *)sender {
    [self.myMyselectImageView removeFromSuperview];
    [self.mySecondButton addSubview:self.myMyselectImageView];
    self.myFirstButton.selected = NO;//选择的是手机
    self.mySecondButton.selected = YES;//选择的是邮箱
    self.myPhoneTF.backgroundColor = [UIColor lightGrayColor];
    self.myPhoneTF.userInteractionEnabled = NO;
    self.myEmailTF.backgroundColor = [UIColor whiteColor];
    self.myEmailTF.userInteractionEnabled = YES;


}

#pragma mark - lazyLoad

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 180, 50)];
        _alertLabel.backgroundColor = [UIColor darkGrayColor];
    }
    return _alertLabel;
}






/**
 *  抖动特效
 *
 *  @param view 抖动的视图
 */
- (void)shakeAnimationForView:(UIView *) view

{
    
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
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
