//
//  ss_FindPasswordBackViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/27/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ss_FindPasswordBackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *myFirstView;

@property (weak, nonatomic) IBOutlet UIButton *myFirstButton;
@property (weak, nonatomic) IBOutlet UIButton *mySecondButton;

@property (weak, nonatomic) IBOutlet UIView *mySecondView;
@property (weak, nonatomic) IBOutlet UITextField *myPhoneTF;//输入手机号
@property (weak, nonatomic) IBOutlet UITextField *myEmailTF;//输入邮箱
@property (weak, nonatomic) IBOutlet UITextField *myVerifyCodeTF;//得到的验证码
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCode;//获取验证码

@property (weak, nonatomic) IBOutlet UIButton *myNextStepButton;

//获取验证码按钮
- (IBAction)getVerifyCodeButton:(UIButton *)sender;

- (IBAction)myNextStepButton:(UIButton *)sender;


- (IBAction)myFirstCircleButton:(UIButton *)sender;
- (IBAction)mySecondCircleButton:(UIButton *)sender;


@end
