//
//  ShoppingCartViewController.m
//  TDS
//
//  Created by giikylee on 16/6/19.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "Util.h"
//#import "Header.h"
#import "ShoppingTableView.h"
#import "ShoppingModel.h"

#import "CouponView.h"
#import "CouponTableViewCell.h"
@interface ShoppingCartViewController ()
{

    BOOL isbool;
    
    BOOL editbool;
    
    NSString *numString;
    
    ShoppingTableView *shopping;
    
    NSArray *cellArray;
}
@property (nonatomic,strong)CouponView *cView;
@end

@implementation ShoppingCartViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.tabBarController.tabBar.hidden = NO;
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"购物车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(EditBtn:)];
    //shopping.delegate = self;
    [self creatView];
    
    [self setInit];
}
-(void)creatView
{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, hKscreen-44-55, wKscreen, 55)];
    //_bottomView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_bottomView];
    _allImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 25, 25)];
    _allImage.image = [UIImage imageNamed:@"iconfont-yuanquan"];
    [_bottomView addSubview:_allImage];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 17, 34, 12)];
    _nameLabel.text = @"全选";
    _nameLabel.font = [UIFont systemFontOfSize:14.f];
    _nameLabel.textColor = [UIColor grayColor];
    [_bottomView addSubview:_nameLabel];
    _allBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _allBtn.frame = CGRectMake(0, 0, 89, 55);
    [_allBtn addTarget:self action:@selector(AllBtn:) forControlEvents:UIControlEventTouchUpInside];
    _allBtn.backgroundColor = [UIColor clearColor];
    [_bottomView addSubview:_allBtn];
    _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(92, 8, 172, 21)];
    //_allPriceLabel.backgroundColor = [UIColor blueColor];
    _allPriceLabel.text = @"总价：¥0.00";
    _allPriceLabel.textColor = [UIColor grayColor];
    _allPriceLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_allPriceLabel];
    
    _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(92, 29, 172, 18)];
    _subLabel.backgroundColor = [UIColor blueColor];
    [_bottomView addSubview:_subLabel];
    
    _settlementLabel = [[UILabel alloc]initWithFrame:CGRectMake(92+172, 8, 100, 18)];
    _settlementLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:65/255.0 blue:129/255.0 alpha:1];
    _settlementLabel.text = @"结算(0)";
    _settlementLabel.textColor = [UIColor whiteColor];
    [_bottomView addSubview:_settlementLabel];
    _settlementButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _settlementButton.frame = CGRectMake(92+172, 8, 172, 30);
    //_settlementButton setTitle:<#(nullable NSString *)#> forState:<#(UIControlState)#>
    [_settlementButton addTarget:self action:@selector(SettlementBtn:) forControlEvents:UIControlEventTouchUpInside];
    //_settlementButton.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_settlementButton];
    
}
-(void)setInit{

    numString = @"0";
    [Util setFoursides:_bottomView Direction:@"top" sizeW:SCREEN_WIDTH];
    [Util setFoursides:_naviView Direction:@"bottom" sizeW:SCREEN_WIDTH];
    
    shopping = [[ShoppingTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -55 -44) style:UITableViewStyleGrouped];
    [self.view addSubview:shopping];
    [self setData];
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPrice:) name:@"AllPrice" object:nil];
    [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:@"￥0.00" Color:BACKGROUNDCOLOR Font:15 Underline:NO];
}
#pragma mark 通知
- (void)AllPrice:(NSNotification *)text{
    _allPriceLabel.text = [NSString stringWithFormat:@"总价: %@",text.userInfo[@"allPrice"]];
    [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:text.userInfo[@"allPrice"] Color:BACKGROUNDCOLOR Font:15 Underline:NO];
    numString = text.userInfo[@"num"];
    [self setTlementLabel];
    [self setAllBtnState:[text.userInfo[@"allState"]  isEqual: @"YES"]?NO:YES];
    cellArray =  text.userInfo[@"cellModel"];
}

#pragma mark 设置结算按钮状态
-(void)setTlementLabel{
    NSString *string = editbool?@"删除":@"结算";
    _settlementLabel.text = [NSString stringWithFormat:@"%@(%@)",string,numString];
}

#pragma mark 数据
-(void)setData{
    NSDictionary *dicts = @{
                            @"item":@[
                                @{
                                    @"headID":@"10",
                                    @"headState":@1,
                                    @"discount":@"9",
                                    @"headCellArray":@[
                                            @{
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@1,
                                                @"ID":@"10",
                                                },
                                            @{
                                                
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@1,
                                                @"ID":@"11",
                                                },
                                            @{
                                                
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@0,
                                                @"ID":@"12",
                                                },
                                            ]
                                        
                                    },
                                @{
                                    @"headID":@"11",
                                    @"headState":@1,
                                    @"discount":@"9",
                                    @"headCellArray":@[
                                            @{
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@1,
                                                @"ID":@"13",
                                                },
                                            @{
                                                
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@0,
                                                @"ID":@"14",
                                                },
                                            ]
                                    
                                    },
                                @{
                                    @"headID":@"10",
                                    @"headState":@0,
                                    @"discount":@"9",
                                    @"headCellArray":@[
                                            @{
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@0,
                                                @"ID":@"15",
                                                },
                            
                                            ]
                                    
                                    },
                                @{
                                    @"headID":@"10",
                                    @"headState":@0,
                                    @"discount":@"9",
                                    @"headCellArray":@[
                                            @{
                                                @"imageUrl":@"headurl.png",
                                                @"title":@"韩版宽松杂色马海毛休闲",
                                                @"color":@"浅蓝",
                                                @"size":@"s",
                                                @"price":@"100.00",
                                                @"numInt":@2,
                                                @"inventoryInt":@10,
                                                @"mustInteger":@0,
                                                @"ID":@"16",
                                                },
                                            
                                            ]
                                    
                                    },
                                
                                
                                ]
                            };
    
    
    NSMutableArray *arrayl = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dicts[@"item"]) {
        
        NSMutableArray *dictarray = [[NSMutableArray alloc] init];
        ShoppingModel *model = [[ShoppingModel alloc] initWithShopDict:dict];
        [dictarray addObject:model];
        
        [arrayl addObject:model];
        
    }
    
    shopping.shoppingArray = arrayl;
    
}

#pragma mark 编辑
-(void)EditBtn:(UIButton *)sender {
    
    if (editbool) {
        
        [shopping editBtn:editbool];
        editbool = NO;
    }else{
        
        
        [shopping editBtn:editbool];
        editbool = YES;
    }
    
    [_editLabel setTitle:editbool?@"完成":@"编辑" forState:UIControlStateNormal];
    [self setTlementLabel];
    _allPriceLabel.hidden = editbool;
    
}
#pragma mark 返回
- (IBAction)ReturnBtn:(UIButton *)sender {
    
}

#pragma 全选
//- (IBAction)AllBtn:(UIButton *)sender {
//    
//    [shopping allBtn:!isbool];
//}
-(void)AllBtn:(UIButton *)sender{
    [shopping allBtn:!isbool];
}
#pragma mark 全选
-(void)setAllBtnState:(BOOL)_bool{

    if (_bool) {
        
        _allImage.image = [UIImage imageNamed:@"iconfont-yuanquan"];
        isbool = NO;
        
    }else{
        
        _allImage.image = [UIImage imageNamed:@"iconfont-zhengque"];
        isbool = YES;
    }
}

#pragma mark 结算
//- (IBAction)SettlementBtn:(UIButton *)sender {
//    
//    if (editbool) {
//        
//        [shopping deleteBtn:editbool];
//        
//    }else{
//    
//        
//        NSLog(@"结算:%@",cellArray);
//    }
//    
//}
-(void)SettlementBtn:(UIButton *)sender
{
    if (editbool) {
        [shopping deleteBtn:editbool];
    }else{
        NSLog(@"结算:%@",cellArray);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
