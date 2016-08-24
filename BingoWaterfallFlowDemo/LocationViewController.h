//
//  LocationViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface LocationViewController : UIViewController<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
@property ( nonatomic, strong) BMKLocationService *locService;
@property ( nonatomic ,strong) BMKMapView *mapView;
@property (nonatomic,strong)UISegmentedControl *segmentControl;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong)BMKPointAnnotation* annotation;
@property (nonatomic, strong)BMKReverseGeoCodeOption *reverseGeocodeSearchOption;
@property (nonatomic) CGFloat lat;
@property (nonatomic) CGFloat lon;
+(instancetype)shareLocation;
@property (nonatomic,strong)UIButton *backBtn;//返回
@end
