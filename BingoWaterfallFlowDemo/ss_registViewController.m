//
//  ss_registViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/25/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_registViewController.h"
#import "ss_registRequest.h"
#import "ss_registModel.h"


#import "ss_drawCircle.h"

@interface ss_registViewController ()<UITextFieldDelegate>{
    int second;//倒计时总时间
    dispatch_source_t aTimer;//GCD版定时器
}

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;     //背景scrollView
@property (weak, nonatomic) IBOutlet UITextField *myPhoneTF;          //手机号
@property (weak, nonatomic) IBOutlet UITextField *myUsernameTF;       //用户名
@property (weak, nonatomic) IBOutlet UITextField *myPasswordTF;       //密码
@property (weak, nonatomic) IBOutlet UITextField *myRepeatPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *myEmailTF;
@property (weak, nonatomic) IBOutlet UIImageView *loginBGView;        //背景图片
@property (weak, nonatomic) IBOutlet UITextField *phoneVerifyNumberTF;//手机验证码
@property (weak, nonatomic) IBOutlet UIView *myFirstView;
@property (weak, nonatomic) IBOutlet UIView *mySecondView;
@property (weak, nonatomic) IBOutlet UIView *myThirdView;
@property (weak, nonatomic) IBOutlet UIButton *myRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *getPhoneVerifyButton;//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *myDidReadButton;
@property (nonatomic, strong) ss_drawCircle *drawCircle;





@property (nonatomic, assign) BOOL isDrawCircle;


@end

@implementation ss_registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    second = 60;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.bigScrollView addGestureRecognizer:recognizer];
    [self roundRectBorder];
    
    #pragma mark - TextField
    self.myPhoneTF.delegate = self;
    self.myUsernameTF.delegate = self;
//    self.myPasswordTF.delegate = self;
//    self.myRepeatPasswordTF.delegate = self;
    self.myEmailTF.delegate = self;
    
    #pragma mark - 画我已详细阅读的小圆圈
    ss_drawCircle *aView = [[ss_drawCircle alloc] initWithFrame:CGRectMake(0 , 0, 25, 25)];
    aView.center = self.myDidReadButton.center;
    aView.backgroundColor = [UIColor whiteColor];
    aView.userInteractionEnabled = NO;
    [self.myDidReadButton addSubview:aView];
    
    
    self.drawCircle = [[ss_drawCircle alloc] init];
    self.drawCircle.center = self.myDidReadButton.center;
    self.drawCircle.bounds = CGRectMake(0, 0, 22, 22);
    self.drawCircle.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
    self.drawCircle.layer.cornerRadius = 11;
    self.drawCircle.userInteractionEnabled = NO;
    
    
//    #pragma mark - 先设置获取验证码为不可点击的状态
    self.getPhoneVerifyButton.backgroundColor = [UIColor lightGrayColor];
    self.getPhoneVerifyButton.enabled = NO;
    
}

- (void)touchScrollView {
    [self.view endEditing:YES];
}







/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
- (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}





#pragma mark - UItextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    debugLog(@"编辑结束了");
    //判断手机号是否可用
    if (self.myPhoneTF.text.length == 11 && [self isMobile:self.myPhoneTF.text] == YES) {
        ss_registModel *model = [[ss_registModel alloc] init];
        model.phone = self.myPhoneTF.text;
        [ss_registRequest ss_registVerifyPhoneHTTPRequestModel:model request:^(NSDictionary *dictionary) {
            debugLog(@"dic == %@",dictionary);
            if ([dictionary[@"resultMessage"]  isEqual: @"手机已被注册"]) {
                self.myPhoneTF.text = nil;
                self.myPhoneTF.placeholder = @"手机号已被注册";
                [self shakeAnimationForView:self.myPhoneTF];
            }
            
        }];
        
        
    } else {
        self.myPhoneTF.text = nil;
        self.myPhoneTF.placeholder = @"请输入正确的手机号";
        [self shakeAnimationForView:self.myPhoneTF];
    }
    
    //判断用户名是否可用
    if (self.myUsernameTF.text.length != 0) {
        ss_registModel *model = [[ss_registModel alloc] init];
        model.username = self.myUsernameTF.text;
        
        [ss_registRequest ss_registVerifyUsernameHTTPRequestModel:model request:^(NSDictionary *dictionary) {
            if ([dictionary[@"resultMessage"]  isEqual: @"用户已名被注册"]) {
                self.myUsernameTF.text = nil;
                self.myUsernameTF.placeholder = @"用户已名被注册";
                [self shakeAnimationForView:self.myUsernameTF];
            }
        }];
    }
    //判断邮箱是否可用
    if (self.myEmailTF.text.length != 0) {
        ss_registModel *model = [[ss_registModel alloc] init];
        model.email = self.myEmailTF.text;
        [ss_registRequest ss_registVerifyEmailHTTPRequestModel:model request:^(NSMutableArray *object) {
            
        }];
    }
    
    
    if (self.myPhoneTF.text.length != 0 && self.myUsernameTF.text.length != 0 && self.myPasswordTF.text.length != 0 && self.myRepeatPasswordTF.text.length != 0 && self.myEmailTF.text.length != 0) {
        #pragma mark - 设置获取验证码为可点击的状态
        self.getPhoneVerifyButton.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
        self.getPhoneVerifyButton.enabled = YES;
    }
    
    
    
    
    
}





- (void)roundRectBorder {
    self.myFirstView.layer.cornerRadius = 8;
    self.mySecondView.layer.cornerRadius = 8;
    self.myThirdView.layer.cornerRadius = 8;
    self.mySecondView.layer.masksToBounds = YES;
    self.myRegistButton.layer.cornerRadius = 8;
}

/**
 *  获取验证码
 *
 *  @param sender <#sender description#>
 */
- (IBAction)getVerificationCodeButton:(UIButton *)sender {
    debugMethod();
    
    self.getPhoneVerifyButton.backgroundColor = [UIColor lightGrayColor];
    self.getPhoneVerifyButton.enabled = NO;
    
    
    
//    if (self.myPhoneTF.text.length != 11) {
//        self.myPhoneTF.text = nil;
//        self.myPhoneTF.placeholder = @"请输入正确的手机号";
//        [self shakeAnimationForView:self.myPhoneTF];
//    }
    
    aTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
      dispatch_source_set_timer(aTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(aTimer, ^{
        second--;
        if (second == 0) {
            dispatch_source_cancel(aTimer);
            aTimer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.getPhoneVerifyButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.getPhoneVerifyButton.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
                self.getPhoneVerifyButton.enabled = YES;
            });
            second = 60;
            
          

            return;
        }
        NSString *title = [NSString stringWithFormat:@"%2.d秒",second];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.getPhoneVerifyButton setTitle:title forState:UIControlStateNormal];
        });
    });
    dispatch_resume(aTimer);
}



/**
 *  我已阅读用户协议
 *
 *  @param sender <#sender description#>
 */
- (IBAction)IHaveReadButton:(UIButton *)sender {
    
   
    
    _isDrawCircle = !_isDrawCircle;
    if (_isDrawCircle) {
        [self.myDidReadButton addSubview:self.drawCircle];
    } else {
        [self.drawCircle removeFromSuperview];
    }
    
}
/**
 *  用户协议
 *
 *  @param sender <#sender description#>
 */
- (IBAction)userAgreementButton:(UIButton *)sender {
    
}
/**
 *  点击注册
 *
 *  @param sender <#sender description#>
 */
- (IBAction)registButton:(UIButton *)sender {
    
    debugMethod();
    ss_registModel *model = [[ss_registModel alloc] init];
    model.username = self.myUsernameTF.text;
    model.password = self.myRepeatPasswordTF.text;
    model.phone = self.myPhoneTF.text ;
    model.email = self.myEmailTF.text;
    model.valicationCode = self.phoneVerifyNumberTF.text;
    [ss_registRequest ss_registHTTPRequestModel:model request:^(NSMutableArray *object) {
        
    }];
    
    
    
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
