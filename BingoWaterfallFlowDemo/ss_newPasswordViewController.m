//
//  ss_newPasswordViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_newPasswordViewController.h"

#import "ss_findBackModel.h"
#import "ss_findBackRequest.h"

@interface ss_newPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myNewPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *myEyeButton1;
@property (weak, nonatomic) IBOutlet UITextField *myRepeatPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *myEyeButton2;

@end

@implementation ss_newPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)myEnsureButton:(UIButton *)sender {
    
    ss_findBackModel *model = [[ss_findBackModel alloc] init];
    model.password = self.myRepeatPasswordTF.text;
    
    [ss_findBackRequest ss_modifyPasswordByEmailHTTPRequestModel:model request:^{
        
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
