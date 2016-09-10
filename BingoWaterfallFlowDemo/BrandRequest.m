//
//  BrandRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "BrandRequest.h"
#import "AFHTTPSessionManager.h"
#import "BrandModel.h"
@implementation BrandRequest
+ (void)ss_brandHTTPRequestPara:(NSString *)modelPara request:(void(^)(NSMutableArray *object))complete{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.22:8090/wap/brand/list";
    NSDictionary *dic = @{@"orderType":modelPara, @"start":@"1", @"count":@"10"};
//    debugLog(@"传递的参数为 = %@", modelPara);
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrayBig = dic[@"data"];
        
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < arrayBig.count; i++) {
            NSDictionary *dic = arrayBig[i];
            NSDictionary *imageDic = dic[@"image"];
            NSDictionary *logoDic = dic[@"logo"];
            BrandModel *mode = [BrandModel brandDictionary:dic];
            //来自image字典
            mode.imageUrl = imageDic[@"url"];
            mode.imageWidth = [imageDic[@"width"] intValue] ;
            mode.imageHeight = [imageDic[@"height"] intValue];
            //来自logo字典
            mode.logoUrl = logoDic[@"url"];
            mode.logoWidth = [logoDic[@"width"] intValue];
            mode.logoHeight = [logoDic[@"height"] intValue];
            
            [array addObject:mode];
          
        }
        
        if (complete) {
            complete(array);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@",error);
    }];

}
@end
