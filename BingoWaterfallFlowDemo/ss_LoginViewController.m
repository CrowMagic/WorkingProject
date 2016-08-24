//
//  ss_LoginViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/25/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_LoginViewController.h"

#import "ss_registViewController.h"

#import "ss_FindPasswordBackViewController.h"

#import "ss_loginModel.h"
#import "ss_loginRequest.h"
#import "MBProgressHUD.h"



#import "AFNetworkReachabilityManager.h"

@interface ss_LoginViewController ()<UITextFieldDelegate>{
    BOOL theNetworkIsOK;
    BOOL theNetworkIsUnknown;
}

@end

@implementation ss_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self theNetworkIsOK];
    
    
    self.myLoginButton.layer.cornerRadius = 8;
    self.myHeadImageView.layer.cornerRadius = 50;
    self.myHeadImageView.layer.masksToBounds = YES;
    self.myHeadImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.myHeadImageView.layer.borderWidth = 1;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goToRegistVC)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goToRegistVC)];
    
    
    self.usernameTF.delegate = self;
    self.passwordTF.delegate = self;
    
    
    self.myLoginButton.enabled = NO;
    self.myLoginButton.backgroundColor = [UIColor lightGrayColor];
    
    
}






- (void)goToRegistVC {
    debugLog(@"返回");
    
    
//    
//    
//    ss_colorForNaviagtionBar *colorViewBar = [[ss_colorForNaviagtionBar alloc] initWithFrame:CGRectMake(0 , 20, [UIScreen mainScreen].bounds.size.width, 44)];
//    colorViewBar.backgroundColor = [UIColor whiteColor];
//    //    [self.view addSubview:colorViewBar];
//    UIGraphicsBeginImageContext(colorViewBar.bounds.size);
//    [colorViewBar.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *imageColorViewbar = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    
//    UIViewController *vc = self.navigationController.viewControllers[0];
//    id bar = vc.navigationController.navigationBar;
//    [bar setBackgroundImage:imageColorViewbar forBarMetrics:UIBarMetricsDefault];

    
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
   
    
    if ([UIScreen mainScreen].bounds.size.width < 350) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y += -80;
            self.view.frame = frame;
        }];
    }
    
  

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([UIScreen mainScreen].bounds.size.width < 350) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y += 80;
            self.view.frame = frame;
        }];
    }
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.usernameTF.text.length != 0 ) {
        self.myLoginButton.enabled = YES;
        self.myLoginButton.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  登录按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButton:(UIButton *)sender {
    debugLog(@"登录");
    
    
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    ss_loginModel *model = [[ss_loginModel alloc] init];
    model.username = self.usernameTF.text;
    model.password = self.passwordTF.text;
    [self theNetworkIsOK];
    if (theNetworkIsOK) {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        HUD.labelText = @"正在登陆...";
        HUD.labelFont = [UIFont systemFontOfSize:14];
        [ss_loginRequest ss_loginHTTPRequestModel:model request:^(NSDictionary *dic) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                sleep(1.0);
                if ([dic[@"resultMessage"] isEqual:@"登陆成功"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:model.username forKey:@"USERNAME"];
                    [[NSUserDefaults standardUserDefaults] setObject:model.password forKey:@"PASSWORD"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [HUD hide:YES];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                
            });

        }];

    }
    
    
 }
/**
 *  忘记密码
 *
 *  @param sender
 */
- (IBAction)forgetPasswordButton:(UIButton *)sender {
    debugLog(@"忘记密码？");
    ss_FindPasswordBackViewController *vc = [[ss_FindPasswordBackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)registNowButton:(UIButton *)sender {
    ss_registViewController *vc = [[ss_registViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



/**
 *  判断网络是否畅通
 */
- (void)theNetworkIsOK {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                debugLog(@"无网络");
                theNetworkIsOK = NO;
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.labelText = NSLocalizedString(@"正在搜索...", @"HUD loading title");
                hud.detailsLabelText = NSLocalizedString(@"无网络连接", @"HUD title");
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    sleep(1.5f);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hide:YES];
                    });
                });
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                debugLog(@"WiFi网络");
                theNetworkIsOK = YES;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                debugLog(@"无线网络");
                theNetworkIsOK = YES;
            }
                 break;
            case AFNetworkReachabilityStatusUnknown:{
                debugLog(@"未知网络");
                theNetworkIsUnknown = YES;
                theNetworkIsOK = YES;
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.labelText = NSLocalizedString(@"正在搜索...", @"HUD loading title");
                hud.detailsLabelText = NSLocalizedString(@"未知网络", @"HUD title");
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    sleep(1.5f);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hide:YES];
                    });
                });

            }
                
            default:
                break;
        }
        
          }];
    
    

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
