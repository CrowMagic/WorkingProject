//
//  SouthJadeRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "SouthJadeRequest.h"
#import "AFHTTPSessionManager.h"
#import "SouthJadeModel.h"
@implementation SouthJadeRequest
+ (void)ss_southJadeHTTPRequest:(SouthJadeModel *)model request:(void(^)(NSMutableArray *object))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.22:8090/wap/product/list";
    NSDictionary *dic = @{@"orderType":@"news", @"start":@"1", @"count":@"10"};
    
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
            

            SouthJadeModel *model = [SouthJadeModel southJadeDetailDictionary:dic];
            debugLog(@"model.image=====%@", model.image);
            debugLog(@"model.width=====%d", model.width);
            debugLog(@"model.height=====%d", model.height);

            model.image = imageDic[@"url"];
            model.width  = [imageDic[@"width"] intValue];
            model.height = [imageDic[@"height"] intValue];
             debugLog(@"model.image=====%@", model.image);
            debugLog(@"model.width=====%d", model.width);
            debugLog(@"model.height=====%d", model.height);

            [array addObject:model];

        }
        
        debugLog(@"=============array=============%lu", (unsigned long)array.count);
        
        if (complete) {
            complete(array);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@",error);
    }];
    
}
@end
