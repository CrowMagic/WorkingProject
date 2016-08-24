//
//  BuyCountTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UILabel *gouLbl;//购买数量
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
