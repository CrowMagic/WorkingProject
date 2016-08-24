//
//  DataTools.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/31.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@class DataModel;
typedef void(^passValue)(NSDictionary *dictionary);//传字典

typedef void(^passValueArray)(NSArray *array);//传数组

@interface DataTools : NSObject<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
@property(nonatomic,strong)NSDictionary *dictionary;
+(instancetype)shareDataTool;
-(void)getDataWithUrlWithString:(NSString *)Urlstring WithPassValue:(passValue)pass;//请求数据方法

//-(void)sendDataWithString:(DataModel *)model WithPassValue:(passValueArray)pass;//传经纬
//-(void)sendDataWithString:(NSString *)url WithPassValue:(passValueArray)pass;
-(void)sendDataWithStrLat:(NSString *)lat StrLon:(NSString *)lon WithPassValue:(passValue)pass;

@property (nonatomic , strong) BMKLocationService *locService;
@property (nonatomic , assign) CGFloat lat;//经度
@property (nonatomic , assign) CGFloat lon;//纬度
-(void)startLocation;//开始定位
@property (nonatomic ,strong) NSString *strLat;
@property (nonatomic ,strong) NSString *strLon;
@end
