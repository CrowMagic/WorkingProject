//
//  ZzwCollectionViewCell.h
//  瀑布流demo
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shopModel.h"
@interface ZzwCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property(nonatomic,retain)shopModel * shop;
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;
@end
