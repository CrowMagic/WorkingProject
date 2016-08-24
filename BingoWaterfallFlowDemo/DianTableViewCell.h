//
//  DianTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DianTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *prouctImage;

@property (weak, nonatomic) IBOutlet UILabel *detailLbl;

@property (weak, nonatomic) IBOutlet UILabel *smallLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@end
