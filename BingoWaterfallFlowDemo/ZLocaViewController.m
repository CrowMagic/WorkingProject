//
//  ZLocaViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/16.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ZLocaViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "DataModel.h"
@interface ZLocaViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
@property ( nonatomic , strong) CLLocationManager *locationManager;
@property ( nonatomic , strong) MKMapView *mapView;
@property ( nonatomic , strong) CLGeocoder *geocoder;
@property ( nonatomic , strong) DataModel *m;
@property ( nonatomic , strong)KCAnnotation *annotation1;
@end

@implementation ZLocaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _geocoder=[[CLGeocoder alloc]init];
    _m = [[DataModel alloc]init];
   // [self getCoordinateByAddress:@"北京"];
    _annotation1=[[KCAnnotation alloc]init];
    
   
}
#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
       // NSLog(@"详细信息:%@",placemark.addressDictionary);
        
        
        [_m setValuesForKeysWithDictionary:placemark.addressDictionary];
        
        CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(self.lat, self.lon);
        
        _annotation1.title=@"CMJ Studio";
        NSLog(@"wwww%@",_m.Name);
        _annotation1.subtitle=_m.Name;
        _annotation1.coordinate=location1;
        [_mapView addAnnotation:_annotation1];
        
    }];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=userLocation.coordinate;//位置坐标
    self.lat = userLocation.coordinate.latitude;//更新后的经度
    self.lon = userLocation.coordinate.longitude;//更新后的纬度
    /*MKCoordinateSpan theSpan;//设定显示范围
     theSpan.latitudeDelta = 0.01;
     theSpan.longitudeDelta = 0.01;
     MKCoordinateRegion theRegion;//设置地图显示的中心及范围
     theRegion.center = coordinate;
     theRegion.span = theSpan;
     [_mapView setRegion:theRegion];*/
    [self getAddressByLatitude:self.lat longitude:self.lon];
    // NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *location=[locations firstObject];//取出第一个位置
//    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
//    self.lat = location.coordinate.latitude;//更新后的经度
//    self.lon = location.coordinate.longitude;//更新后的纬度
//    /*MKCoordinateSpan theSpan;//设定显示范围
//    theSpan.latitudeDelta = 0.01;
//    theSpan.longitudeDelta = 0.01;
//    MKCoordinateRegion theRegion;//设置地图显示的中心及范围
//    theRegion.center = coordinate;
//    theRegion.span = theSpan;
//    [_mapView setRegion:theRegion];*/
//    
//   // NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
//    //如果不需要实时定位，使用完即使关闭定位服务
//    [_locationManager stopUpdatingLocation];
//}


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
