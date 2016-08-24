//
//  FirstSemTableViewCell.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/25.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstSemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *updataLbl;
@property (weak, nonatomic) IBOutlet UILabel *updataNumLbl;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
