//
//  MakeSureViewController.m
//  结算购物车
//
//  Created by giikylee on 16/6/3.
//  Copyright © 2016年 giikylee. All rights reserved.
//

#import "MakeSureViewController.h"
#import "AddressTableViewCell.h"
#import "DianTableViewCell.h"
#import "BuyCountTableViewCell.h"
#import "ReturnGoodsTableViewCell.h"
#import "FreightTableViewCell.h"
#import "MessageTableViewCell.h"
#import "PriceTableViewCell.h"
#import "PayView.h"
#import "BankCarTableViewCell.h"
#import "BankCarView.h"
@interface MakeSureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)PayView *payView;
@property(nonatomic,strong)BankCarView *carView;
@end

@implementation MakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height/8-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_sureOrderTableView];
    self.sureOrderTableView.delegate = self;
    self.sureOrderTableView.dataSource = self;
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"aCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"DianTableViewCell" bundle:nil] forCellReuseIdentifier:@"DianCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"BuyCountTableViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"ReturnGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"rCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"FreightTableViewCell" bundle:nil] forCellReuseIdentifier:@"fCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mCell"];
    [self.sureOrderTableView registerNib:[UINib nibWithNibName:@"PriceTableViewCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sureOrderTableView.frame), self.view.frame.size.width, self.view.frame.size.height/8)];
    self.bottomView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_bottomView];
    self.priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 0, 60, CGRectGetHeight(self.bottomView.frame)/2)];
    self.priceLbl.text = @"总金额:";
    [self.bottomView addSubview:self.priceLbl];
    self.allPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-6, 0, 80, CGRectGetHeight(self.bottomView.frame)/2)];
    self.allPriceLbl.text = @"¥ 280.00";
    self.allPriceLbl.textColor = [UIColor redColor];
    [self.bottomView addSubview:_allPriceLbl];
    self.payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.payBtn.frame = CGRectMake(0, CGRectGetMaxY(self.allPriceLbl.frame), self.view.frame.size.width, CGRectGetHeight(self.bottomView.frame)/2);
    self.payBtn.backgroundColor = [UIColor orangeColor];
    [self.payBtn setTitle:@"结算" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_payBtn];
    self.payView = [[PayView alloc]initWithFrame:[UIScreen mainScreen].bounds];//付款详情
}
//结算
-(void)payBtnAction:(UIButton *)sender
{
    //self.payView = [[PayView alloc]initWithFrame:[UIScreen mainScreen].bounds];//付款详情
    [self.view addSubview:self.payView];//付款详情
    self.payView.bankCarLbl.text = @"wowowowowwo";
    [self.payView.dissmissBtn addTarget:self action:@selector(dissBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView.questionBtn addTarget:self action:@selector(questionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView.payStyBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
//选择银行卡付款
-(void)payBtn:(UIButton *)sender
{
    self.carView = [[BankCarView alloc]initWithFrame:[UIScreen mainScreen].bounds];//选择付款方式
    [self.view addSubview:self.carView];
    self.carView.bankTableView.delegate = self;
    self.carView.bankTableView.dataSource = self;
    [self.carView.bankTableView registerNib:[UINib nibWithNibName:@"BankCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
}
-(void)dissBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.payView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}
-(void)questionBtn:(UIButton *)sender
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.sureOrderTableView ) {
        return 3;
    }
    else{
    return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.sureOrderTableView) {
        if (section == 0) {
            return 1;
        }
        if (section == 1) {
            return 6;
        }
        else
        {
            return 5;
        }
    }
    else
    {
        return 10;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sureOrderTableView) {
        if (indexPath.section == 0) {
            AddressTableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
            aCell.nameLbl.text = @"刘琴";
            aCell.phoneLbl.text = @"15116405974";
            aCell.addressLbl.text = @"收获地址：凯旋玉业和田白玉吊坠足金镶玉玉坠男女十二生肖猴年";
            return aCell;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            DianTableViewCell *dCell = [tableView dequeueReusableCellWithIdentifier:@"DianCell"];
            dCell.logoImage.image = [UIImage imageNamed:@"1.jpg"];
            dCell.storeNameLbl.text = @"凯旋旗舰店";
            dCell.prouctImage.image = [UIImage imageNamed:@"2.jpg"];
            dCell.detailLbl.text = @"凯旋玉业和田白玉吊坠足金镶玉玉坠男女十二生肖猴年本命年玉牌";
            dCell.smallLbl.text = @"规格:小款---猪";
            dCell.priceLbl.text = @"¥280.00";
            dCell.countLbl.text = @"X123";
            return dCell;
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            BuyCountTableViewCell *bCell = [tableView dequeueReusableCellWithIdentifier:@"bCell"];
            bCell.pictureImage.image = [UIImage imageNamed:@"huabei"];
            bCell.numLbl.text = @"2";
            bCell.gouLbl.text = @"购买数量";
            return bCell;
        }
        if (indexPath.section == 1 && indexPath.row == 2) {
            ReturnGoodsTableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:@"rCell"];
            rCell.pictureImage.image = [UIImage imageNamed:@"huabei"];
            rCell.nosupLbl.text = @"此商品不支持7天退货";
            return rCell;
        }
        if (indexPath.section == 1 && indexPath.row == 3) {
            ReturnGoodsTableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:@"rCell"];
            rCell.pictureImage.image = [UIImage imageNamed:@"huabei"];
            rCell.nosupLbl.text = @"配送方式";
            return rCell;
        }
        if (indexPath.section == 1 && indexPath.row == 4) {
            FreightTableViewCell *fCell = [tableView dequeueReusableCellWithIdentifier:@"fCell"];
            fCell.picImage.image = [UIImage imageNamed:@"huabei"];
            fCell.freightLbl.text = @"运费险";
            fCell.paofeiLbl.text = @"卖家已为您的运费投保，最高赔付25元";
            fCell.moneyLbl.text = @"0.00元";
            return fCell;
        }
        if (indexPath.section == 1 && indexPath.row == 5) {
            MessageTableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:@"mCell"];
            mCell.picImage.image = [UIImage imageNamed:@"huabei"];
            mCell.messLbl.text = @"买家留言:";
            //        mCell.liuyanTextView.text
            return mCell;
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
            PriceTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            pCell.deLb.text = @"可用854天猫积分抵¥8.54";
            pCell.picImage.image = [UIImage imageNamed:@"huabei"];
            //[pCell.selectBtn setImage:[UIImage imageNamed:@"icon_ksss_off@3x"] forState:UIControlStateNormal];
            return pCell;
        }
        if (indexPath.section == 2 && indexPath.row == 1) {
            PriceTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            pCell.deLb.text = @"使用天猫点券";
            pCell.picImage.image = [UIImage imageNamed:@"huabei"];
            //[pCell.selectBtn setImage:[UIImage imageNamed:@"icon_ksss_off@3x"] forState:UIControlStateNormal];
            return pCell;
        }
        if (indexPath.section == 2 && indexPath.row == 2)
        {
            PriceTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            pCell.deLb.text = @"花呗分期";
            pCell.picImage.image = [UIImage imageNamed:@"huabei"];
            //[pCell.selectBtn setImage:[UIImage imageNamed:@"icon_ksss_off@3x"] forState:UIControlStateNormal];
            return pCell;
        }
        if (indexPath.section == 2 && indexPath.row == 3){
            PriceTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            pCell.deLb.text = @"朋友代付";
            pCell.picImage.image = [UIImage imageNamed:@"huabei"];
            return pCell;
        }
        else {
            PriceTableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            pCell.deLb.text = @"匿名购买";
            pCell.picImage.image = [UIImage imageNamed:@"huabei"];
            return pCell;
        }
    }
    else
    {
        BankCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.bankCarLbl.text = [NSString stringWithFormat:@"中国银行%ld",indexPath.row];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0, 0.0, 55, 40)];
//        [button setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateHighlighted];
//        [button setTag:indexPath.row];
//        [button addTarget:self action:@selector(doClickPlaybillAction:)  forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundColor:[UIColor clearColor]];
//        [cell setAccessoryView:button];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.carView.bankTableView) {
        //    NSString *rowString = [self.list objectAtIndex:[indexPath row]];
        //    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //    [alter show];
        BankCarTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        //[tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
        self.payView.bankCarLbl.text =[NSString stringWithFormat:@"中国银行%ld",indexPath.row];
        // 当选择某个银行卡后，选择付款方式界面消失
        [UIView animateWithDuration:0.5 animations:^{
            self.carView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        } completion:nil];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.sureOrderTableView) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/9.6)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.height/6.4, 5, self.view.frame.size.height/3.2, self.view.frame.size.width/16)];
        titleLbl.text = @"选择付款方式";
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLbl];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame)+10, self.view.frame.size.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        backBtn.frame = CGRectMake(0, -10, self.view.frame.size.width/6.4, self.view.frame.size.height/12);
        [backBtn setTitle:@"<" forState:UIControlStateNormal];
        [backBtn setFont:[UIFont systemFontOfSize:20]];
        [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBtn];
        UIButton *shezhiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shezhiBtn.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width/6.4 - self.view.frame.size.width/32, -10, self.view.frame.size.width/6.4, self.view.frame.size.height/12);
        [shezhiBtn setTitle:@"设置" forState:UIControlStateNormal];
        [shezhiBtn addTarget:self action:@selector(sheBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:shezhiBtn];
        return view;
    }
    
}
-(void)backAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.carView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}
-(void)sheBtn:(UIButton *)sender
{
    
}
-(void)doClickPlaybillAction:(UIButton *)sender
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sureOrderTableView) {
        if (indexPath.section == 0) {
            return 90;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            return 155;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        return 50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.sureOrderTableView) {
        return 1;
    }
    else
    {
    return 50;
    }
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
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
