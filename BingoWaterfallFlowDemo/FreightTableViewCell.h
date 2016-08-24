//
//  FreightTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreightTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *freightLbl;
@property (weak, nonatomic) IBOutlet UILabel *paofeiLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@end
