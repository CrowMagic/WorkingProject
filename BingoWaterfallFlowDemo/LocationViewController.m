//
//  LocationViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LocationViewController.h"
#import "DataTools.h"
static LocationViewController *loca = nil;
@interface LocationViewController ()

@end

@implementation LocationViewController
+(instancetype)shareLocation
{
    if (loca == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            loca = [[LocationViewController alloc]init];
        });
    }
    return loca;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mapView];
    self.backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backBtn.frame = CGRectMake(10, self.view.frame.size.height/15, 40, 20);
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.backBtn];
    _segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"地图",@"卫星", nil]];
    _segmentControl.frame = CGRectMake(self.view.frame.size.width-100-10, self.view.frame.size.height/10,100, 20);
    _segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentControl];
    [_segmentControl addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    [[DataTools shareDataTool] startLocation];//开启定位
    _mapView.showsUserLocation = YES;//显示定位图层
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];//编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    _annotation = [[BMKPointAnnotation alloc]init];//大头针
    //显示多个标注 数据固定还未能动态获取
    for (int i = 0; i < 3; i++) {
        BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor1;
        coor1.latitude = 22.915 + i*0.023;
        coor1.longitude = 113.404 + i*0.128;
        annotation1.coordinate = coor1;
        annotation1.title = @"这里是北京";
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:annotation1];
        [_mapView addAnnotations:array];
    }
}
-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [DataTools shareDataTool].locService.delegate = self;
    _geocodesearch.delegate = self;//设置代理为self
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    [DataTools shareDataTool].locService.delegate = nil;
    _geocodesearch.delegate = nil;//设置代理为self
}
//-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    //处理方向变更信息
//   // NSLog(@"heading is %@",userLocation.heading);
//}
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //处理位置坐标更新
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
    //大头针
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    _annotation.coordinate = coor;
    //
    CLLocationCoordinate2D pt ;
    pt.latitude = userLocation.location.coordinate.latitude;
    pt.longitude = userLocation.location.coordinate.longitude;
    _reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    BOOL flag = [_geocodesearch reverseGeoCode:_reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
       // NSLog(@"反geo检索发送成功%f %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    self.lat = userLocation.location.coordinate.latitude;
    self.lon = userLocation.location.coordinate.longitude;
}
-(void)controlPressed:(id)sender
{
    NSInteger selectIndex = _segmentControl.selectedSegmentIndex;
    switch (selectIndex) {
        case 0:
            //切换为普通地图
            [_mapView setMapType:BMKMapTypeStandard];
            break;
         case 1:
            //切换为卫星图
            [_mapView setMapType:BMKMapTypeSatellite];
            break;
        default:
            break;
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        //newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
//    _annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    _annotation.coordinate = coor;
    _annotation.title =[NSString stringWithFormat:@"%@",result.address];;
    [_mapView addAnnotation:_annotation];
    
}
//暂时添加的
-(void)didStopLocatingUser
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
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
