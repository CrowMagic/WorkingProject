//
//  ShoppingCartViewController.h
//  TDS
//
//  Created by 黎金 on 16/3/24.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *naviView;
@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *editLabel;
//
//@property (strong, nonatomic) IBOutlet UIView *bottomView;
//@property (strong, nonatomic) IBOutlet UIImageView *allImage;//
//@property (strong, nonatomic) IBOutlet UIButton *allBtn;//全选
//@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;
//@property (strong, nonatomic) IBOutlet UILabel *subLabel;//
//@property (strong, nonatomic) IBOutlet UIButton *settlementButton;//结算
//@property (strong, nonatomic) IBOutlet UILabel *settlementLabel;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *allImage;
@property (nonatomic,strong)UILabel *nameLabel;//全选
@property (nonatomic,strong)UIButton *allBtn;//全选
@property (nonatomic,strong)UILabel *allPriceLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,strong)UIButton *settlementButton;//结算
@property (nonatomic,strong)UILabel *settlementLabel;

@end
