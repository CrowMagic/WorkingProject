//
//  ModifyPasswordViewController.m
//  NSURLSession
//
//  Created by 李 宇亮 on 5/26/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//


#import "ModifyPasswordViewController.h"


#import "ss_modifyPasswordModel.h"
#import "ss_modifyPasswordRequest.h"



@interface ModifyPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPassworldTF;
@property (weak, nonatomic) IBOutlet UITextField *myNewPasswordTF;

@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *ensureButton;

@property (nonatomic, assign) BOOL isSelectedOld;
@property (nonatomic, assign) BOOL isSelectedNew;
@property (nonatomic, assign) BOOL isSelectedRepeat;



@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.ensureButton.layer.cornerRadius = 8;
    
}


- (IBAction)hideOrShowPasswordButton:(UIButton *)sender {
    
//    switch (sender.tag) {
//        case 101:{
//            NSLog(@"旧密码");
//            self.isSelectedOld = !self.isSelectedOld;
//            [sender setImage:[UIImage imageNamed:self.isSelectedOld?@"showSecret.png":@"hideSecret.png"] forState:UIControlStateNormal];
//            self.oldPassworldTF.secureTextEntry = !self.isSelectedOld;
//        }
//            break;
//        case 102:{
//            NSLog(@"新密码");
//            self.isSelectedNew = !self.isSelectedNew;
//            [sender setImage:[UIImage imageNamed:self.isSelectedNew?@"showSecret.png":@"hideSecret.png"] forState:UIControlStateNormal];
//            self.myNewPasswordTF.secureTextEntry = !self.isSelectedNew;
//        }
//            break;
//        case 103:{
//            NSLog(@"重复密码");
//            self.isSelectedRepeat = !self.isSelectedRepeat;
//            [sender setImage:[UIImage imageNamed:self.isSelectedRepeat?@"showSecret.png":@"hideSecret.png"] forState:UIControlStateNormal];
//            self.repeatPasswordTF.secureTextEntry = !self.isSelectedRepeat;
//        }
//            break;
//        case 104:{
//            NSLog(@"确认");
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    
    ss_modifyPasswordModel *model = [[ss_modifyPasswordModel alloc] init];
    model.password = self.oldPassworldTF.text;
    model.aNewPassword = self.repeatPasswordTF.text;
    [ss_modifyPasswordRequest ss_modifyPasswordByEmailHTTPRequestModel:model request:^{
        
    }];
    
       
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
