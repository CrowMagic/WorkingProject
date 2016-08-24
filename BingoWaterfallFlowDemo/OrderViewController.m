//
//  OrderViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/7/16.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "OrderViewController.h"
#import "UIView+WZLBadge.h"
#import "UIBarButtonItem+WZLBadge.h"
#import "UITabBarItem+WZLBadge.h"

#import "MyOrderViewController.h"
@interface OrderViewController ()
@property(nonatomic,strong)UILabel *cLbl;
@property(nonatomic,strong)UIImageView *pic;
@property(nonatomic,strong)NSArray * imgArr;
@property(nonatomic,strong)NSArray *seImageArr;
@property(nonatomic,strong)MyOrderViewController *myOrderVC;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    [self creatBarItem];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    NSArray * nameArr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
    _imgArr = @[@"pay@2x",@"send@2x",@"inboundGray@2x",@"evaluatedGray@2x",@"aftermarketGray@2x"];
    _seImageArr = @[@"paySelect@2x",@"sendSelect@2x",@"inboundGreen@2x",@"evaluatedGreen@2x",@"aftermarketGreen@2x"];
    //
    
    
    WBadgeStyle styles[] = {WBadgeStyleRedDot, WBadgeStyleNew, WBadgeStyleNumber, WBadgeStyleNumber,WBadgeStyleNumber};
    for (NSInteger i = 0; i < 5; i++) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(wKscreen/5*i, 64+10, wKscreen/5, 40);
        _btn.tag = i;
        [_btn setImage:[UIImage imageNamed:_imgArr[i]] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:_seImageArr[i]] forState:UIControlStateSelected];
        //btn.layer.cornerRadius = btn.frame.size.width / 2;
        if (i == 1) {
            [_btn showBadgeWithStyle:WBadgeStyleNumber value:4 animationType:WBadgeAnimTypeNone];
        } else if (i == 2) {
            [_btn showBadgeWithStyle:WBadgeStyleNumber value:88 animationType:WBadgeAnimTypeNone];
            }
        else if (i == 3){
            [_btn showBadgeWithStyle:WBadgeStyleNumber value:67 animationType:WBadgeAnimTypeNone];
        }
        else if (i == 0){
            [_btn showBadgeWithStyle:WBadgeStyleNumber value:99 animationType:WBadgeAnimTypeNone];
        }
        else if (i == 4){
            [_btn showBadgeWithStyle:WBadgeStyleNumber value:34 animationType:WBadgeAnimTypeNone];
        }
        //[_btn showBadgeWithStyle:styles[i] value:100 animationType:WBadgeAnimTypeNone];
        _btn.badgeCenterOffset = CGPointMake(-30, 10);
        [_btn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btn];
        _nameLbl = [[UILabel alloc]init];
        _nameLbl.frame = CGRectMake(wKscreen/5*i, CGRectGetMaxY(_btn.frame), wKscreen/5, 20);
        _nameLbl.text = nameArr[i];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl.textColor = [UIColor grayColor];
        _nameLbl.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_nameLbl];
    }
    self.backMainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLbl.frame), wKscreen, hKscreen-CGRectGetMaxY(self.nameLbl.frame))];
    self.backMainScrollView.backgroundColor = [UIColor greenColor];
    self.backMainScrollView.contentSize = CGSizeMake(5 * wKscreen, CGRectGetWidth(self.backMainScrollView.frame));
    self.backMainScrollView.pagingEnabled =YES;
    self.backMainScrollView.bounces = NO;
    self.backMainScrollView.alwaysBounceVertical = NO;
    [self.view addSubview:self.backMainScrollView];
    _myOrderVC = [[MyOrderViewController alloc]init];
    [self.backMainScrollView addSubview:_myOrderVC.view];
    
}
-(void)dismissAction:(UIButton *)sender
{
    [sender clearBadge];
    self.backMainScrollView.contentOffset =CGPointMake(sender.tag * wKscreen, 0);
}
-(void)creatBarItem
{
    NSMutableArray *buttons = [[NSMutableArray alloc]initWithCapacity:4];
    
    //设置添加按钮的数量
    
    UIBarButtonItem *flexibleSpaceItem;
    flexibleSpaceItem =[[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                        target:self
                        action:NULL];
    [buttons addObject:flexibleSpaceItem];
    
    //UIBarButtonSystemItemFixedSpace和UIBarButtonSystemItemFlexibleSpace都是系统提供的用于占位的按钮样式。
    //使按钮与按钮之间有间距
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, wKscreen/1.6, 40.0f)];
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textAlignment=UITextAlignmentCenter;
    myLabel.text  = @"全部订单";
    UIBarButtonItem *myButtonItem = [[UIBarButtonItem alloc]initWithCustomView:myLabel];
    [buttons addObject: myButtonItem];
    _ItemSearch = [[UIBarButtonItem alloc]
                   initWithImage:[UIImage imageNamed:@"orderSearch.png"]
                   style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(search:)];
    _ItemSearch.tintColor = [UIColor grayColor];
    [buttons addObject:_ItemSearch];
    //添加第一个图标按钮
    _ItemInfor = [[UIBarButtonItem alloc]
                  initWithImage:[UIImage imageNamed:@"orderInforma.png"]
                  style:UIBarButtonItemStylePlain
                  target:self
                  action:@selector(infor:)];
    _ItemInfor.tintColor = [UIColor grayColor];
    [buttons addObject:_ItemInfor];
    
    //添加第二个图标按钮
    
    flexibleSpaceItem = [[UIBarButtonItem alloc]
                         initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                         target:self
                         action:NULL];
    [buttons addObject:flexibleSpaceItem];
    
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    //toolBar.barStyle = UIBarStyleBlackOpaque ;
    
    [toolBar setItems:buttons animated:YES];
    [toolBar sizeToFit];
    self.navigationItem.titleView = toolBar ;
}
-(void)back:(UIBarButtonItem *)sender
{
    NSLog(@"back");
}
-(void)search:(UIBarButtonItem *)sender
{
    NSLog(@"搜索框");
}
-(void)infor:(UIBarButtonItem *)sender
{
    NSLog(@"消息列表");
}
-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
