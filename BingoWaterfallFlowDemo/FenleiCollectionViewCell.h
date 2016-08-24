//
//  FenleiCollectionViewCell.h
//  分类界面
//
//  Created by giikylee on 16/7/6.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenleiCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *backLbl;

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@end
