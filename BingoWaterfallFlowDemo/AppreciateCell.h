//
//  AppreciateCell.h
//  FirstPage
//
//  Created by 李 宇亮 on 4/22/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppreciateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *blackBorderView;

@property (weak, nonatomic) IBOutlet UIImageView *appreciateImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end
