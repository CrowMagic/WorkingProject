//
//  MyGoldViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "MyGoldViewController.h"

@interface MyGoldViewController ()

@end

@implementation MyGoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImageView.image = [UIImage imageNamed:@"artMaster.jpg"];
    self.headImageView.layer.cornerRadius = 50;
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.masksToBounds = YES;
    
    
//    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    NSString *originalString = @"已有金币";
    NSString *insertString = @"200";
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:insertString];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:originalString];
    [str insertAttributedString:attString atIndex:2];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, insertString.length)];
    self.numberOfGoldLabel.attributedText = str;
//    [self.view addSubview:aLabel];

    
}

/**
 *  领取金币
 *
 *  @param sender <#sender description#>
 */
- (IBAction)getGoldButton:(UIButton *)sender {
    
}

/**
 *  金币提现
 *
 *  @param sender <#sender description#>
 */
- (IBAction)goldCashButton:(UIButton *)sender {
    
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
