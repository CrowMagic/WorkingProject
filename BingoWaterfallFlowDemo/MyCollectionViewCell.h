//
//  MyCollectionViewCell.h
//  CollectionView带编辑状态
//
//  Created by 李东旭 on 16/5/19.
//  Copyright © 2016年 李东旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIImageView *imageV;

//
@property (nonatomic, strong) UILabel *backGroundLbl;//背景框
@property (nonatomic, strong) UILabel *nameLbl;//介绍
@property (nonatomic, strong) UILabel *addressLbl;//深圳包邮
@property (nonatomic, strong) UILabel *priceLbl;//价格
@property (nonatomic, strong) UIButton *simpleBtn;//找相似
@end
