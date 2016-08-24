//
//  MyCollectionViewCell.m
//  CollectionView带编辑状态
//
//  Created by 李东旭 on 16/5/19.
//  Copyright © 2016年 李东旭. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backGroundLbl = [[UILabel alloc]initWithFrame:self.bounds];
        self.backGroundLbl.layer.borderWidth = 1;
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
        [self.contentView addSubview:self.imageV];
        
        self.nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageV.frame), self.bounds.size.width, 20)];
        self.nameLbl.textAlignment = NSTextAlignmentCenter;
        self.nameLbl.font = [UIFont systemFontOfSize:9.f];
        self.nameLbl.text = @"只要是美丽的石头就是玉和田";
        self.nameLbl.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.nameLbl];
        
        self.addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLbl.frame), self.bounds.size.width/2, 20)];
        //self.addressLbl.backgroundColor = [UIColor redColor];
        self.addressLbl.text = @"深圳 包邮";
        self.addressLbl.textColor = [UIColor grayColor];
        self.addressLbl.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.addressLbl];
        
        self.priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressLbl.frame), CGRectGetMaxY(self.nameLbl.frame), self.bounds.size.width-CGRectGetWidth(self.addressLbl.frame)-10, 20)];
        self.priceLbl.textColor = [UIColor redColor];
        self.priceLbl.text = @"¥888.0";
        self.priceLbl.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.priceLbl];
        
        self.simpleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.simpleBtn.frame = CGRectMake(self.bounds.size.width/2-30, CGRectGetMaxY(self.addressLbl.frame)+5, 60, 20);
        [self.simpleBtn setTitle:@"找相似" forState:UIControlStateNormal];
        [self.simpleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.simpleBtn setFont:[UIFont systemFontOfSize:11.f]];
        self.simpleBtn.layer.cornerRadius = 6;
        self.simpleBtn.layer.borderWidth = 1;
        self.simpleBtn.layer.borderColor = [UIColor greenColor].CGColor;
        self.simpleBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:self.simpleBtn];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 30, CGRectGetMaxY(self.simpleBtn.frame)-10, 30, 15)];
        self.myLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.myLabel];

     
    }
    
    return self;
}

@end
