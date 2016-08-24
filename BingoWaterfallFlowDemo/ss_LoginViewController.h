//
//  ss_LoginViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/25/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ss_LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *myHeadImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;//用户名
@property (weak, nonatomic) IBOutlet UIButton *myLoginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码
- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)forgetPasswordButton:(UIButton *)sender;
- (IBAction)registNowButton:(UIButton *)sender;
@end
