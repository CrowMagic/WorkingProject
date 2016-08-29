//
//  MyGoldViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "MyGoldViewController.h"
#import "ChongZhiViewController.h"
@interface MyGoldViewController ()<ChongZhiViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *lingQuView;
@property (weak, nonatomic) IBOutlet UIView *jinBiView;
@property (weak, nonatomic) IBOutlet UIView *jiFenVIew;
@property (weak, nonatomic) IBOutlet UIView *xiaoFeiView;

@property (nonatomic, strong) ChongZhiViewController *chongZhiVC;

@end

@implementation MyGoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIColor *leftColor = [UIColor colorWithRed:110/255.0 green:205/255.0 blue:251/255.0 alpha:1];
    UIColor *rightColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    self.lingQuView.layer.borderWidth = 1;
    self.lingQuView.layer.borderColor = leftColor.CGColor;
    self.jiFenVIew.layer.borderWidth = 1;
    self.jiFenVIew.layer.borderColor = leftColor.CGColor;
    self.jinBiView.layer.borderWidth = 1;
    self.jinBiView.layer.borderColor = rightColor.CGColor;
    self.xiaoFeiView.layer.borderWidth = 1;
    self.xiaoFeiView.layer.borderColor = rightColor.CGColor;
    
    
    
    self.headImageView.image = [UIImage imageNamed:@"artMaster.jpg"];
    self.headImageView.layer.cornerRadius = 50;
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.masksToBounds = YES;
 
    self.numberOfGoldLabel.attributedText = [self originalString:@"金币" insertString:@"200"];
    self.numberOfJiFen.attributedText = [self originalString:@"积分" insertString:@"4000"];
    
    
    self.chongZhiVC = [[ChongZhiViewController alloc] init];
    self.chongZhiVC.delegate = self;
    
    
    
}


- (void)ensureButtonClickAndChangeCoutJinBi:(NSString *)countStringJinBi {
    debugLog(@"金币代理调用了");

    self.numberOfGoldLabel.attributedText = [self originalString:@"金币" insertString:countStringJinBi];

}

- (void)ensureButtonClickAndChangeCoutJiFen:(NSString *)countStringJiFen {
    debugLog(@"积分代理调用了");

    self.numberOfJiFen.attributedText = [self originalString:@"积分" insertString:countStringJiFen];
}



- (NSAttributedString *)originalString:(NSString *)original insertString:(NSString *)insert {
    NSAttributedString *strInsert = [[NSAttributedString alloc] initWithString:insert];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:original];
    [str insertAttributedString:strInsert atIndex:0];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, insert.length)];
    return str;
}



- (IBAction)chongZhiButton:(UIButton *)sender {

    [self presentViewController:self.chongZhiVC animated:YES completion:nil];
    
    
}



/**
 *  领取金币
 *
 *  @param sender
 */
- (IBAction)getGoldButton:(UIButton *)sender {
    
}

/**
 *  金币提现
 *
 *  @param sender
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
