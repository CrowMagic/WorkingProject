//
//  MyOrderViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/7/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderCell.h"

#import "PayCellTableViewCell.h"

#import "SingleChooseTable.h"
@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *OrderTableView;
@property (nonatomic,strong)SingleChooseTable * MyTable;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UIView *backView;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
//    [self creatBarItem];
//    self.navigationController.navigationBarHidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
    self.OrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen-64)];
    self.OrderTableView.delegate = self;
    self.OrderTableView.dataSource = self;
    self.OrderTableView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.OrderTableView];
    [self.OrderTableView registerNib:[UINib nibWithNibName:@"MyOrderCell" bundle:nil] forCellReuseIdentifier:@"moCell"];
    [self.OrderTableView registerNib:[UINib nibWithNibName:@"PayCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    /**
     *  在ios7中使用group类型UITableView时，第一个section距离navigationbar的距离很大，不符合设计要求。使用myTableView.sectionHeaderHeight = 8;无效。
     *  解决办法是：通过设置tableview的headerview高度来控制这个距离。使用方法是-(CGFolat)tableview:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sction
     *  {return 8;}
     *  但是对于第一个和第二个section 之间的距离设置则不能使用-(CGFloat)tableView:(UITableView *)tableview heightForFooterInSection:(NSInteger)section这个方法。需要使用
     *  myTableView.sectionFooterHeight = 1.0;这个距离的计算是header的高度加上footer的高度。
     */
    self.OrderTableView.sectionFooterHeight = 1;
    
}
/*-(void)creatBarItem
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
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)leftAction:(UIBarButtonItem *)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
//}
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
    if (section == 1) {
        return 37;
    }
    return 7;
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
    if (self.OrderTableView.editing == YES) {
        [self.OrderTableView setEditing:NO];
    }
    else
    {
        [self.OrderTableView setEditing:YES];
    }
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen)];
    _backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //_backView.alpha = 0.4;
    [self.view addSubview:_backView];
    UIView *alphView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, 200)];
    alphView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //[_backView addSubview:alphView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, wKscreen, 40)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"请选择取消订单的理由";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor greenColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [_backView addSubview:titleLabel];
    UILabel *lineLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 200 + 40, wKscreen, 1)];
    lineLbl.backgroundColor = [UIColor greenColor];
    [_backView addSubview:lineLbl];
    
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithObjects:@"我不想买了",@"信息填写错误，重新拍",@"卖家缺货",@"同城见面交易",@"拍错商品",@"6", nil];
    //_MyTable = [[SingleChooseTable alloc]initWithFrame:CGRectMake(10, 100, wKscreen - 20, self.view.frame.size.height-100-10)];
    _MyTable.backgroundColor = [UIColor whiteColor];
    _MyTable = [SingleChooseTable ShareTableWithFrame:CGRectMake(0, CGRectGetMaxY(lineLbl.frame), wKscreen, self.view.frame.size.height-241-40)];
    _MyTable.dataArr = _dataArr;
    [_MyTable ReloadData];
    //选中内容
    _MyTable.block = ^(NSString *chooseContent,NSIndexPath *indexPath){
        NSLog(@"数据：%@ ；第%ld行",chooseContent,indexPath.row);
    };
    //    [self.view addSubview:_MyTable];
    
    [_backView addSubview:_MyTable];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_MyTable.frame), wKscreen/2, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(viewDissmisAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:cancelButton];
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sureButton.frame = CGRectMake(CGRectGetMaxX(cancelButton.frame), CGRectGetMaxY(_MyTable.frame), wKscreen/2, 40);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:sureButton];
    NSLog(@"取消");
}
-(void)viewDissmisAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        _backView.frame = CGRectMake(0, hKscreen, wKscreen, 0);
    }];
}
-(void)sureAction:(UIButton *)sender
{
    NSLog(@"确定");
    [UIView animateWithDuration:0.5f animations:^{
        _backView.frame = CGRectMake(0, hKscreen, wKscreen, 0);
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 65;
}
// 去掉 UITableView   headerView footerView  黏性
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.OrderTableView)
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
// UITableView  处于编辑状态
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
