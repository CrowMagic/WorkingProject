//
//  AddressTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;//地址的姓名

@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;//手机号码

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;//地址
@end
