//
//  RightTableViewCell.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *proImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locaImageView;
@property (weak, nonatomic) IBOutlet UIButton *disBtn;

@end
