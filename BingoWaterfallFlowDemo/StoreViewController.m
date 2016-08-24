//
//  StoreViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "StoreViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
//#import "QRCodeViewController.h"
//#import "AppDelegate.h"
//#import <AVFoundation/AVFoundation.h>
#import "DataTools.h"
#import "StoreModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "LocationViewController.h"
#import "DataTools.h"
#import "GuideViewController.h"
#import "StoreView.h"
@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) NSArray *myData;
@property (nonatomic ,assign) NSInteger selectedIndex;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *muArray;
@property(nonatomic,strong)NSMutableArray *arr;
//@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property (nonatomic,strong) BMKReverseGeoCodeOption *reverseGeocodeSearchOption;
@property (nonatomic,strong)StoreView *storeView;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBarHidden = YES;
    self.storeView = [[StoreView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.storeView];
    self.storeView.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.storeView.leftTableView.bounces = NO;
    self.storeView.leftTableView.showsVerticalScrollIndicator = NO;
    //    self.leftTableView.showsHorizontalScrollIndicator = NO;
    [self.storeView.leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"leftCell"];
    self.storeView.leftTableView.dataSource = self;
    self.storeView.leftTableView.delegate = self;
    [self.storeView.rightTableView registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightCell"];
    self.storeView.rightTableView.dataSource = self;
    self.storeView.rightTableView.delegate = self;
    self.storeView.rightTableView.bounces = NO;
    self.storeView.rightTableView.showsHorizontalScrollIndicator = NO;
    self.storeView.rightTableView.showsVerticalScrollIndicator = NO;
    [self.storeView.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView.locaBtn addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    _dataArr = [[NSArray alloc]initWithObjects:@"推荐分类", @"潮流女装",@"品牌男装",@"酒水饮料",@"家用电器",@"手机数码",@"电脑办公",@"图书",@"居家生活",@"运动户外",@"玩具乐器",@"钟表珠宝",@"食品生鲜",@"奢侈礼品",@"汽车用品",@"生活旅行",nil];
    _myData = [[NSArray alloc]initWithObjects:@"笔记本",@"休闲裤",@"牛仔裤",@"手机",@"净化器",@"火锅",@"OPPO",@"面膜",@"漱口水",@"测试",@"测试1", nil];
    [self getData];
    [[DataTools shareDataTool] startLocation];//启动定位服务
    [DataTools shareDataTool].locService.delegate = self;
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];//编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self
    _reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
//    NSLog(@"%f   %f",[LocationViewController shareLocation].lon,[LocationViewController shareLocation].lat);
//    [self senData];
    
}
-(void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    CLLocationCoordinate2D pt ;
    pt.latitude = userLocation.location.coordinate.latitude;
    pt.longitude = userLocation.location.coordinate.longitude;
    
    _reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    BOOL flag = [_geocodesearch reverseGeoCode:_reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        //NSLog(@"反geo检索发送成功%f %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    self.storeView.locaFiled.placeholder = [NSString stringWithFormat:@"%@",result.address];
    self.storeView.locaFiled.font = [UIFont systemFontOfSize:10];
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if ([tableView isEqual:_leftTableView]) {
//        return 1;
//    }
//    return 1;
//}
-(void)getData
{
    NSString *urlStr = [ALLUrl stringByAppendingString:@"store/view"];
    NSLog(@"urlStr = %@",urlStr);
    [[DataTools shareDataTool] getDataWithUrlWithString:urlStr
     WithPassValue:^(NSDictionary *dictionary) {
         //NSArray *array = dictionary[@"store"];
         self.muArray = [NSMutableArray array];
         NSArray *arr = [dictionary[@"store"] valueForKey:@"content"];
         //NSLog(@"dddd%@",arr);
         if (arr) {
             for (NSDictionary *dic in arr) {
                 StoreModel *model = [[StoreModel alloc]init];
                 [model setValuesForKeysWithDictionary:dic];
                 [self.muArray addObject:model];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.storeView.leftTableView reloadData];
                 });
             }
         }
         
     }];
}
-(void)senData
{
    [[DataTools shareDataTool]sendDataWithStrLat:[NSString stringWithFormat:@"%f",[LocationViewController shareLocation].lat] StrLon:[NSString stringWithFormat:@"%f",[LocationViewController shareLocation].lon] WithPassValue:^(NSDictionary *dictionary) {
        //NSLog(@"  ww%@",dictionary);
    }];
}


// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%ld -- %ld", column, row);
}
-(void)locationAction:(UIButton *)sender
{
    LocationViewController *lVC = [[LocationViewController alloc]init];
    [self.navigationController pushViewController:lVC animated:YES];
}
//扫一扫
- (IBAction)positionBtn:(id)sender {
    LocationViewController *lVC = [[LocationViewController alloc]init];
    [self.navigationController pushViewController:lVC animated:YES];
/*    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        if (IS_VAILABLE_IOS8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self canOpenSystemSettingView]) {
                    [self systemSettingView];
                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }
        
        return;
    }
    
    //self.navigationController.navigationBarHidden = YES;
    QRCodeViewController *qrcodeVC = [[QRCodeViewController alloc] init];
    qrcodeVC.view.alpha = 0;
    [qrcodeVC setDidReceiveBlock:^(NSString *result) {
        NSLog(@"%@", result);
    }];
    [self.navigationController pushViewController:qrcodeVC animated:YES];
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window.rootViewController addChildViewController:qrcodeVC];
    [del.window.rootViewController.view addSubview:qrcodeVC.view];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        qrcodeVC.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];*/
}
//是否可以打开设置页面
/*- (BOOL)canOpenSystemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}
//跳到系统设置页面
- (void)systemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.storeView.leftTableView]) {
        return _muArray.count;
    }
    return _myData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.storeView.leftTableView]) {
        LeftTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        StoreModel *sModel = self.muArray[indexPath.row];
        //leftCell.productLabel.text = _dataArr[indexPath.row];
        leftCell.productLabel.text = sModel.storeName;
        //NSLog(@"%@",sModel.storeName);
        leftCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        return leftCell;
    }
    else
    {
        RightTableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        rightCell.nameLabel.text = _myData[indexPath.row];
        //rightCell.disLabel.text = _myData[indexPath.row];
        [rightCell.disBtn setTitle:_myData[indexPath.row] forState:UIControlStateNormal];
       // rightCell.logoImageView.image = [UIImage imageNamed:@"1.jpg"];
        
        //rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.storeView.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return rightCell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.storeView.leftTableView]) {
        [self.storeView.leftTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        _selectedIndex = indexPath.row;
    }
    
    
    /*RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
    switch (_selectedIndex) {
        case 0:
            cell.nameLabel.text = _myData[indexPath.row];
            cell.logoImageView.image = [UIImage imageNamed:@"1"];
          //  cell.logoImageView.image = [UIImage imageNamed:@"1"];
            cell.disLabel.text = @"距离11km";
            break;
        case 1:
            cell.locaImageView.image = [UIImage imageNamed:@"2"];
           // cell.logoImageView.image = [UIImage imageNamed:@"2"];
            break;
            
        default:
            break;
    }*/
    if ([tableView isEqual:self.storeView.rightTableView]) {
        NSLog(@"righttableview");
        GuideViewController *v = [[GuideViewController alloc]init];
        [self.navigationController pushViewController:v animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.storeView.leftTableView]) {
        return 30;
    }
    else
        return 180;
    
}
//添加leftTableView的headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if ([tableView isEqual:self.storeView.leftTableView]) {
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        headerLabel.backgroundColor = [UIColor greenColor];
        //headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor grayColor];
        headerLabel.text = @"店家";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont boldSystemFontOfSize:18];
        [customView addSubview:headerLabel];
        return customView;
    }
    else
    {
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        return customView;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
//设置UITableViewStylePlain的headerView不浮动（去掉UITableView headerview黏性(sticky)）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.storeView.leftTableView)
    {
        CGFloat sectionHeaderHeight = 35; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
/**
 *  传经度纬度参数
 */
-(void)viewWillAppear:(BOOL)animated
{
    //NSURL *url = [NSURL URLWithString:@"http://192.168.2.13:8080/shop/store/view"];
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
