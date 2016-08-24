
//
//  GuideViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/16.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "GuideViewController.h"
#import <MapKit/MapKit.h>
#import "MBProgressHUD+MJ.h"
@interface GuideViewController ()
@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UITextField *startField;
@property (nonatomic, strong) UITextField *endField;
//地理编码
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) UIButton *startNavButton;//开始导航
@end

@implementation GuideViewController
//#warning geocoder懒加载
-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLabelAndTextField];
}
- (void)startDaoHang{
    //获取用户输入的起点和终点
    NSString *startStr = self.startField.text;
    NSString *endStr = self.endField.text;
    if (startStr == nil||startStr.length == 0||endStr == nil||endStr.length == 0) {
        [MBProgressHUD showError:@"请正确输入您要输入的地址"];
        return;
    }
    //利用GEO对象进行地理编码获取地标对象
    //获取开始位置的地标
    [self.geocoder geocodeAddressString:startStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0||error !=nil) {
            [MBProgressHUD showError:@"请正确输入您要输入的地址"];
            return ;
        }
        //开始位置的地标
        CLPlacemark *starPlacemark = [placemarks firstObject];
        //获取结束位置的地标
        [self.geocoder geocodeAddressString:endStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count == 0||error!=nil) {
                [MBProgressHUD showError:@"请正确输入您要输入的地址"];
                return ;
            }
            CLPlacemark *endPlacemark = [placemarks firstObject];
            //获得地标后开始导航
            [self startNavigationWithStartPlacemark:starPlacemark endPlacemark:endPlacemark];
        }];
    }];
}
/**
 *  利用地标位置开始设置导航
 *
 *  @param startPlacemark 开始位置的地标
 *  @param endPlacemark   结束位置的地标
 */
-(void)startNavigationWithStartPlacemark:(CLPlacemark *)startPlacemark endPlacemark:(CLPlacemark*)endPlacemark
{
    //0,创建起点
    MKPlacemark * startMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:startPlacemark];
    //0,创建终点
    MKPlacemark * endMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:endPlacemark];
    
    //1,设置起点位置
    MKMapItem * startItem = [[MKMapItem alloc]initWithPlacemark:startMKPlacemark];
    //2,设置终点位置
    MKMapItem * endItem = [[MKMapItem alloc]initWithPlacemark:endMKPlacemark];
    //3,起点,终点数组
    NSArray * items = @[ startItem ,endItem];
    
    //4,设置地图的附加参数,是个字典
    NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
    //导航模式(驾车,步行)
    dictM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //地图显示的模式
    dictM[MKLaunchOptionsMapTypeKey] = MKMapTypeStandard;
    
    
    //只要调用MKMapItem的open方法,就可以调用系统自带地图的导航
    //Items:告诉系统地图从哪到哪
    //launchOptions:启动地图APP参数(导航的模式/是否需要先交通状况/地图的模式/..)
    
    [MKMapItem openMapsWithItems:items launchOptions:dictM];
}

- (void)createLabelAndTextField{
    _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 60, 40)];
    _startLabel.text = @"起点:";
    [self.view addSubview:_startLabel];
    _startField = [[UITextField alloc] initWithFrame:CGRectMake(105, 50, 300, 40)];
    _startField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_startField];
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 60, 40)];
    _endLabel.text = @"终点:";
    [self.view addSubview:_endLabel];
    _endField = [[UITextField alloc] initWithFrame:CGRectMake(105, 150, 300, 40)];
    _endField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_endField];
    
    _startNavButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 40, 50)];
    [_startNavButton setTitle:@"点击开始导航" forState:UIControlStateNormal];
    _startNavButton.backgroundColor = [UIColor blueColor];
    [_startNavButton addTarget:self action:@selector(startDaoHang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startNavButton];
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
