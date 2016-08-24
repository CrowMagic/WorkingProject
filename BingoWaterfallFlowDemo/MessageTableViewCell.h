//
//  MessageTableViewCell.h
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *messLbl;

@property (weak, nonatomic) IBOutlet UITextView *liuyanTextView;
@end
