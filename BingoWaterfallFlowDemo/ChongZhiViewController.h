//
//  ChongZhiViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/8/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ChongZhiViewController;

@protocol  ChongZhiViewControllerDelegate<NSObject>

- (void)ensureButtonClickAndChangeCoutJinBi:(NSString *)countStringJinBi;
- (void)ensureButtonClickAndChangeCoutJiFen:(NSString *)countStringJiFen;

@end

@interface ChongZhiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *leftSelectView;//选择金币的View
@property (weak, nonatomic) IBOutlet UIImageView *leftSelectImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftJinBi;
@property (weak, nonatomic) IBOutlet UILabel *rightYue;

@property (weak, nonatomic) IBOutlet UIView *rightSelectView;
@property (weak, nonatomic) IBOutlet UIImageView *rightSelectImageView;

@property (weak, nonatomic) IBOutlet UITextField *chongZhiTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;


@property (weak, nonatomic) IBOutlet UIButton *leftSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *rightSelectButton;
@property (nonatomic, weak) id <ChongZhiViewControllerDelegate> delegate;

- (IBAction)leftSelectButton:(UIButton *)sender;
- (IBAction)rightSelectButton:(UIButton *)sender;
- (IBAction)ensureChongZhi:(UIButton *)sender;
- (IBAction)chnageMoney:(UITextField *)sender;


@end
