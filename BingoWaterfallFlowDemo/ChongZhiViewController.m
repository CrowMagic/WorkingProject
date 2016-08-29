//
//  ChongZhiViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/8/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()
@property (nonatomic, copy) NSString *recordNumber;

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self configStyle];
    
    self.leftSelectButton.selected = YES;
    self.rightSelectButton.selected = NO;
    
    
}

- (void)configStyle {
    
    UIColor *color = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];
    
    self.leftSelectView.layer.cornerRadius = 5;
    self.leftSelectView.layer.borderWidth = 1;
    self.leftSelectView.layer.borderColor = color.CGColor;
    self.leftSelectImageView.image = [UIImage imageNamed:@"select_green@2x.png"];

    self.leftJinBi.textColor = color;
    
    self.rightSelectView.layer.cornerRadius = 5;
    self.rightSelectView.layer.borderWidth = 1;
     self.rightSelectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}


//关闭按钮
- (IBAction)closeButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//选择金币充值
- (IBAction)leftSelectButton:(UIButton *)sender {
    [self configStyle];
   
    self.rightYue.textColor = [UIColor blackColor];
    self.rightSelectImageView.image = nil;

    self.leftSelectButton.selected = YES;
    self.rightSelectButton.selected = NO;
    
}

//选择积分充值
- (IBAction)rightSelectButton:(UIButton *)sender {
    UIColor *color = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];
    
    self.rightSelectView.layer.cornerRadius = 5;
    self.rightSelectView.layer.borderWidth = 1;
    self.rightSelectView.layer.borderColor = color.CGColor;
    self.rightSelectImageView.image = [UIImage imageNamed:@"select_green@2x.png"];
    self.rightYue.textColor = color;
    
    self.leftSelectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.leftJinBi.textColor = [UIColor blackColor];
    self.leftSelectImageView.image = nil;

    self.leftSelectButton.selected = NO;
    self.rightSelectButton.selected = YES;
    
}


//确认充值
- (IBAction)ensureChongZhi:(UIButton *)sender {
 
    //让键盘点击按钮时就下落，优化模态返回时键盘延时下落的效果
    [self.chongZhiTextField resignFirstResponder];

    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.leftSelectButton.selected == YES) {
            [strongSelf.delegate ensureButtonClickAndChangeCoutJinBi:strongSelf.recordNumber];
        }
        if (strongSelf.rightSelectButton.selected == YES) {
            [strongSelf.delegate ensureButtonClickAndChangeCoutJiFen:strongSelf.recordNumber];
        }
    }];

}



//textField根据是金币或者积分进行换算
- (IBAction)chnageMoney:(UITextField *)sender {
    
    
    if ( self.leftSelectButton.selected == YES) {
        if (sender.text.length > 8) {
            self.totalMoneyLabel.text = @"充值金额超过最大限制额度";
            self.totalMoneyLabel.textColor = [UIColor redColor];
        } else {
            
            float number = [sender.text floatValue];
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"总共：%.2f元",number/100];
            self.totalMoneyLabel.textColor = [UIColor blackColor];
            if (sender.text.length == 0) {
                self.totalMoneyLabel.text = @"总共：0.00元";
                
            }
            
        }
        
        self.recordNumber = sender.text;
        debugLog(@"金币获取到键盘的数据为 = %@", self.recordNumber);
    }
    
    if (self.rightSelectButton.selected == YES) {
        if (sender.text.length > 8) {
            self.totalMoneyLabel.text = @"充值金额超过最大限制额度";
            self.totalMoneyLabel.textColor = [UIColor redColor];
        } else {
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"总共：%@.00元",sender.text];
            self.totalMoneyLabel.textColor = [UIColor blackColor];
            if (sender.text.length == 0) {
                self.totalMoneyLabel.text = @"总共：0.00元";
                
            }
            
        }
        
        self.recordNumber = sender.text;
        debugLog(@"积分获取到键盘的数据为 = %@", self.recordNumber);

    }
    
    
   }


#pragma mark - UITextFieldDelegate




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
