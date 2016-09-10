//
//  ss_MasterRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_MasterRequest.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ss_MasterModel.h"
@implementation ss_MasterRequest

+ (void)ss_masterHTTPRequest:(NSString *)choseType page:(NSString *)chosePage request:(void(^)(NSMutableArray *object))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];

    
    
    NSString *urlString = @"http://192.168.2.22:8090/wap/master/list";
    NSDictionary *dic = @{@"orderType":choseType, @"start":chosePage, @"count":@"10"};
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataDic = dic[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in dataDic) {
            ss_MasterModel *model = [ss_MasterModel masterDictionary:dic];
            [array addObject:model];
        }
        
        if (complete) {
            complete(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@",error);
    }];
}


+ (void)ss_masterUpHTTPRequest:(NSString *)idString request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];

    NSString *urlString = @"http://192.168.2.22:8090/wap/member/likes/add";
    [manager POST:urlString parameters:@{@"id":@"6"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"点赞success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"点赞error == %@",error);

    }];
}

+ (void)ss_masterDownHTTPRequest:(NSString *)idString request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    
    NSString *urlString = @"http://192.168.2.22:8090/wap/member/likes/delete";
    [manager POST:urlString parameters:@{@"id":@"6"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"取消点赞success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"取消点赞error == %@",error);
        
    }];

}


@end
