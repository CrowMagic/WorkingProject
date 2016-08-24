//
//  MyOrderTableViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyOrderTableViewController.h"
#import "MyOrderCell.h"

#import "PayCellTableViewCell.h"

#import "SingleChooseTable.h"
@interface MyOrderTableViewController ()
@property (nonatomic,strong)SingleChooseTable * MyTable;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation MyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    [self creatBarItem];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.backgroundColor = [UIColor cyanColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyOrderCell" bundle:nil] forCellReuseIdentifier:@"moCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    //[self.tableView registerNib:[UINib nibWithNibName:@"HeaderViewCell" bundle:nil] forCellReuseIdentifier:@"hCell"];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 285;
    }
    if (indexPath.section == 2) {
        return 285;
    }
    return 146;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.section == 2) {
        
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        PayCellTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell" forIndexPath:indexPath];
        pCell.picImageView.image = [UIImage imageNamed:@"2.jpg"];
        pCell.detailLbl.text = @"豪8印象 翡翠手镯 缅甸玉石玉器玉镯 正品带证书 包顺丰S16防伪码";
        pCell.styleLbl.text = @"规格：大款－－虎";
        pCell.backgroundColor = [UIColor clearColor];
        return pCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        return view;
    }
    if (section == 2) {
        UIView *view = [[UIView alloc]init];
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor yellowColor];
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
        logoImageView.image = [UIImage imageNamed:@"orderWait"];
        [view addSubview:logoImageView];
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame)+10, 0, wKscreen-CGRectGetMaxX(logoImageView.frame)-10, 30)];
        titleLbl.text = @"NUIHBNUOO >     等待买家付款";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"NUIHBNUOO >            等待买家付款"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(22, 7)];
        titleLbl.attributedText = str;
        [view addSubview:titleLbl];
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame)+5, wKscreen, 1)];
        [view addSubview:lineImageView];
        UIGraphicsBeginImageContext(lineImageView.frame.size);
        [lineImageView.image drawInRect:CGRectMake(0, 0, lineImageView.frame.size.width, lineImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGFloat lengths[] = {10,8};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0.0, 1.0);    //开始画线
        CGContextAddLineToPoint(line, wKscreen, 1.0);
        CGContextStrokePath(line);
        
        lineImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        return view;
    }
    if (section == 2) {
        UIView *view = [[UIView alloc]init];
        return view;
    }
    
        UIView *footView = [[UIView alloc]init];
        footView.backgroundColor = [UIColor yellowColor];
        UILabel *moneyLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wKscreen-10, 20)];
        moneyLbl.textAlignment = NSTextAlignmentRight;
        moneyLbl.text = @"共2件商品  实付款：¥ 188";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"共2件商品  实付款：¥ 188"];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold"size:25.0] range:NSMakeRange(11, 5)];
        moneyLbl.attributedText = str;
        [footView addSubview:moneyLbl];
        UIButton *cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelOrderBtn.frame = CGRectMake(160, CGRectGetMaxY(moneyLbl.frame)+10, 100, 30);
        cancelOrderBtn.layer.cornerRadius = 3;
        cancelOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        cancelOrderBtn.layer.borderWidth = 1;
        cancelOrderBtn.layer.masksToBounds = YES;
        [cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelOrderBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:cancelOrderBtn];
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        payBtn.frame = CGRectMake(CGRectGetMaxX(cancelOrderBtn.frame)+5, CGRectGetMaxY(moneyLbl.frame)+10, 100, 30);
        payBtn.layer.cornerRadius = 3;
        payBtn.layer.borderColor = [UIColor grayColor].CGColor;
        payBtn.layer.borderWidth = 1;
        [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:payBtn];
        return footView;
    
}
-(void)cancelAction:(UIButton *)sender
{
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithObjects:@"我不想买了",@"信息填写错误，重新拍",@"卖家缺货",@"同城见面交易",@"拍错商品",@"6", nil];
    //_MyTable = [[SingleChooseTable alloc]initWithFrame:CGRectMake(10, 100, wKscreen - 20, self.view.frame.size.height-100-10)];
    _MyTable = [SingleChooseTable ShareTableWithFrame:CGRectMake(10, 800, wKscreen-20, self.view.frame.size.height-100-10)];
    _MyTable.dataArr = _dataArr;
    [_MyTable ReloadData];
    //选中内容
    _MyTable.block = ^(NSString *chooseContent,NSIndexPath *indexPath){
        NSLog(@"数据：%@ ；第%ld行",chooseContent,indexPath.row);
    };
//    [self.view addSubview:_MyTable];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 800, wKscreen, hKscreen)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.4;
    [self.view addSubview:backView];
    [backView addSubview:_MyTable];
    NSLog(@"取消");
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 65;
}
// 去掉 UITableView   headerView footerView  黏性
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView)
        {
            UITableView *tableview = (UITableView *)scrollView;
            CGFloat sectionHeaderHeight = 40;
            CGFloat sectionFooterHeight = 65;
            CGFloat offsetY = tableview.contentOffset.y;
            if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
                {
                    tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
                }
            else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
                {
                    tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
                }
            else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
                {
                    tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
                                
                }
        }
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 40; //sectionHeaderHeight
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}
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
    // Return NO if you do not want the item to be re-orderable.
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
