//
//  ss_firstRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_firstRequest.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@implementation ss_firstRequest
+ (void)ss_firstRequestModel:(NSString *)str request:(void(^)(NSDictionary *dic))complete {
    
    AFHTTPSessionManager *manager = [self getManager];
    NSString *urlString = @"http://192.168.2.22:8090/wap/product/list";
    NSDictionary *dic = @{@"orderType":@"news", @"start":@"1", @"count":@"10"};

    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@",error);

    }];
    
    

}


+ (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    return manager;
}


@end
