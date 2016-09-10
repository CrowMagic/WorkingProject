
//
//  DataTools.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/31.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "DataTools.h"
//#import "AFHTTPRequestOperation.h"
#import "LocationViewController.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
static DataTools *dataTool = nil;
@implementation DataTools
+(instancetype)shareDataTool
{
    if (dataTool == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            dataTool = [[DataTools alloc]init];
        });
    }
    return dataTool;
}
-(void)getDataWithUrlWithString:(NSString *)Urlstring WithPassValue:(passValue)pass
{
//    self.dictionary = [NSDictionary dictionary];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Urlstring]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *html = operation.responseString;
//        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
//        self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        pass(self.dictionary);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
//    }];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
}
-(void)startLocation
{
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
   // _mapView.showsUserLocation = YES;//显示定位图层
   // _geocodesearch = [[BMKGeoCodeSearch alloc] init];//编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _locService.delegate = self;
    //_geocodesearch.delegate = self;//设置代理为self
}
-(void)sendDataWithStrLat:(NSString *)lat StrLon:(NSString *)lon WithPassValue:(passValue)pass
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        //申明返回的结果是json类型
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        //申明请求的数据是json类型
//        manager.requestSerializer=[AFJSONRequestSerializer serializer];
//        //如果报接受类型不一致请替换一致text/html或别的
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
//        //self.strLat = [NSString stringWithFormat:@"%f",[LocationViewController shareLocation].lat];
//    
//        //传入的参数
//        NSDictionary *parameters = @{@"latStr":lat,
//                                     @"lngStr":lon};
//        //你的接口地址
//        NSString *url=@"http://192.168.2.13:8080/shop/store/view";
//        //发送请求
//        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"JSON: %@", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//            NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//            if (pass) {
//                pass(dicss);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
}
//-(void)sendDataWithString:(NSString *)url WithPassValue:(passValueArray)pass
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    self.strLat = [NSString stringWithFormat:@"%f",[LocationViewController shareLocation].lat];
//    //传入的参数
//    NSDictionary *parameters = @{@"latStr":@"XXXX",
//                                 @"lngStr":@"XXXX"};
//    //你的接口地址
//   // NSString *url=@"http://192.168.2.14:8080/shop/store/view";
//    //发送请求
//    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}
/*-(void)sendDataWithString:(DataModel *)model WithPassValue:(passValueArray)pass
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    NSDictionary *parameters = @{@"latStr":@"XXXX",
                                 @"lngStr":@"XXXX"};
    //你的接口地址
    NSString *url=@"http://192.168.2.14:8080/shop/store/view";
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}*/

@end
