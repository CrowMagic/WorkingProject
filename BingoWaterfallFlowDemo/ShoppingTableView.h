//
//  ShoppingTableView.h
//  TDS
//
//  Created by 黎金 on 16/3/24.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ShoppingTableViewDelegate <NSObject>
//
//-(void)EditButtonActionToCouponViewWithIndex:(NSInteger)index;
//-(void)creatViewWithButtonTag:(NSInteger)tag;//领取优惠劵
//@end
@interface ShoppingTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIButton *editBtn;
//@property (nonatomic,weak)id<ShoppingTableViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *shoppingArray;

-(void)allBtn:(BOOL)isbool;

-(void)editBtn:(BOOL)isbool;

-(void)deleteBtn:(BOOL)isbool;


@end
