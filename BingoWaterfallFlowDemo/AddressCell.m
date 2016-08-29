//
//  AddressCell.m
//  MyAddress
//
//  Created by 李 宇亮 on 5/20/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "AddressCell.h"
@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.editButton setImage:[UIImage imageNamed:@"ss_edit_address@2x.png"] forState:UIControlStateNormal];
    self.editButton.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    [self.deleteButton setImage:[UIImage imageNamed:@"ss_delete_address@2x.png"] forState:UIControlStateNormal];
    self.deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    
//    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 8, 8)];
//    blueView.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
//    blueView.layer.cornerRadius = 4;
//
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    circleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    circleView.layer.borderWidth = 1;
    circleView.layer.cornerRadius = 8;
//    [circleView addSubview:blueView];
    UIGraphicsBeginImageContext(circleView.bounds.size);
    [circleView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.addressMoRenButton setImage:image forState:UIControlStateNormal];
    self.addressMoRenButton.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    self.addressMoRenButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);
//    debugLog(@"刷新调用了吗");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
