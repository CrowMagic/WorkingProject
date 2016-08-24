//
//  MyCouponController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/23.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyCouponController.h"
#import "MyCouponController.h"
#import "CouponTableViewCell.h"
@interface MyCouponController ()
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation MyCouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"我的优惠券";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orderInforma"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"CouponTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"conCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)rightAction:(UIBarButtonItem *)sender
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conCell" forIndexPath:indexPath];
    cell.storeImageView.image = [UIImage imageNamed:@"2.jpg"];
    cell.nameLbl.text = @"周大福金黄的旗舰店";
    cell.orderLbl.text = @"订单满500元即可使用";
    NSString *s1 = @"2016-05-08";
    NSString *s2 = @"2016-07-08";
    NSString *string = [NSString stringWithFormat:@"使用期限:%@至%@",s1,s2];
    cell.timeLbl.text = string;
    cell.priceLbl.text = @"50";
    if (indexPath.row %3 ==0) {
        cell.backgroundImageView.image = [UIImage imageNamed:@"orang"];
    }
    if (indexPath.row%3 == 1) {
        cell.backgroundImageView.image = [UIImage imageNamed:@"green"];
    }
    if (indexPath.row%3 == 2) {
        cell.backgroundImageView.image = [UIImage imageNamed:@"blue"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.titleArray = [NSArray arrayWithObjects:@"店铺优惠",@"他人赠送",@"到期事件", nil];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(wKscreen/3 *i, 0, wKscreen/3, headerView.frame.size.height);
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        btn.tintColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be 
 .
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
