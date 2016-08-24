//
//  LogisticsViewController.m
//  FirstPage
//
//  Created by 李 宇亮 on 4/20/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "LogisticsViewController.h"
#import "DrawView.h"


@interface LogisticsViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageHeight;



@property (weak, nonatomic) IBOutlet UIView *myTwoImagesView;
@property (weak, nonatomic) IBOutlet UIButton *xiaDanButton;
@property (weak, nonatomic) IBOutlet UIButton *wangDianButton;
@property (weak, nonatomic) IBOutlet UIButton *dignDan;
@property (weak, nonatomic) IBOutlet UIButton *keFu;
@property (weak, nonatomic) IBOutlet UIButton *gognJu;
@property (weak, nonatomic) IBOutlet UIButton *chajian;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lianxiHeightC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lianxiWidthC;
@property (weak, nonatomic) IBOutlet UILabel *lianxiLbael;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiyongWidthC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiyongHeightC;
@property (weak, nonatomic) IBOutlet UILabel *shiyongLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fujinWidthC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fujinHeightC;
@property (weak, nonatomic) IBOutlet UILabel *fujinLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wodeWidthC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wodeHeightC;
@property (weak, nonatomic) IBOutlet UILabel *wodeLabel;


@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([UIScreen mainScreen].bounds.size.width > 400) {
        self.topImageWidth.constant = 104;
        self.topImageHeight.constant = 104;
    } else if ([UIScreen mainScreen].bounds.size.width > 350) {
        self.topImageWidth.constant = 94;
        self.topImageHeight.constant = 94;
    }
    
    
    [self cornRadious];
}
- (void)cornRadious {
    _xiaDanButton.layer.cornerRadius = 5;
    
//    _xiaDanButton.layer.masksToBounds = YES;
    _wangDianButton.layer.cornerRadius = 5;
//    _wangDianButton.layer.masksToBounds = YES;
    _dignDan.layer.cornerRadius = 5;
//    _dignDan.layer.masksToBounds = YES;
    _keFu.layer.cornerRadius = 5;
//    _keFu.layer.masksToBounds = YES;
    _gognJu.layer.cornerRadius = 5;
//    _gognJu.layer.masksToBounds = YES;
    _chajian.layer.cornerRadius = 5;
//    _chajian.layer.masksToBounds = YES;
    
    self.myTwoImagesView.layer.cornerRadius = 5;
    self.myTwoImagesView.layer.masksToBounds = YES;
    
    /*
    DrawView *aView = [[DrawView alloc] initWithFrame:CGRectMake(_xiaDanButton.frame.size.width/2-25, _xiaDanButton.frame.size.height/2-55, 50, 50)];
    aView.backgroundColor = _xiaDanButton.backgroundColor;
    
    [_xiaDanButton addSubview:aView];
    */

    
    
    if ([UIScreen mainScreen].bounds.size.width < 350) {
        //联系客服
        self.lianxiWidthC.constant = 48;
        self.lianxiHeightC.constant = 53;
        self.lianxiLbael.font = [UIFont systemFontOfSize:12];
        //实用工具
        self.shiyongWidthC.constant = 48;
        self.shiyongHeightC.constant = 53;
        self.shiyongLabel.font = [UIFont systemFontOfSize:12];
        //附近网点
        self.fujinWidthC.constant = 48;
        self.fujinHeightC.constant = 53;
        self.fujinLabel.font = [UIFont systemFontOfSize:12];
        //我的订单
        self.wodeWidthC.constant = 48;
        self.wodeHeightC.constant = 53;
        self.wodeLabel.font = [UIFont systemFontOfSize:12];

        
    }
    
    
    
}



- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
            //一键下单
        case 100: {
            debugLog(@"一键下单");
        }
            break;
            //联系客服
        case 101: {
            debugLog(@"联系客服");
        }
            break;
            //实用工具
        case 102: {
            debugLog(@"实用工具");
        }
            break;
            //附件网点
        case 103: {
            debugLog(@"附件网点");
        }
            break;
            //我的订单
        case 104: {
            debugLog(@"我的订单");
        }
            break;
            //我要查件
        case 105: {
            debugLog(@"我要查件");
        }
            break;
            
        default:
            break;
    }

}


//
//- (void)viewWillAppear:(BOOL)animated {
////    self.tabBarController.tabBar.hidden = NO;
//    debugLog(@"我是物流选项");
//    self.navigationController.tabBarController.tabBar.hidden = NO;
//
//}


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
