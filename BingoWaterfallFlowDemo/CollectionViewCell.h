//
//  CollectionViewCell.h
//  FirstPage
//
//  Created by 李 宇亮 on 4/26/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *artPicture;//艺术家图片(头像)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *artPictureWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *artPictureHeight;



@property (weak, nonatomic) IBOutlet UIImageView *isThumbUp;//点赞的大拇指图片
@property (weak, nonatomic) IBOutlet UILabel *thumbUpCount;//点赞的次数
@property (weak, nonatomic) IBOutlet UILabel *artName;//艺术家的名字
@property (weak, nonatomic) IBOutlet UIView *dottedLineView;//画虚线的View
@property (weak, nonatomic) IBOutlet UIButton *isThumbUpButton;//点赞按钮

-(void)config:(NSInteger)index andData:(NSMutableArray*)flagArr;

@end
