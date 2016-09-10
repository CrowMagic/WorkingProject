//
//  AppreciateRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "AppreciateRequest.h"
#import "AFHTTPSessionManager.h"
#import "AppreciateModel.h"
@implementation AppreciateRequest
+ (void)ss_appreciateHTTPRequest:(NSString *)choseType page:(NSString *)chosePage request:(void(^)(NSMutableArray *object))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    
    NSString *urlString = @"http://192.168.2.22:8090/wap/appraisal/list";
    NSDictionary *paraDic = @{@"type":choseType, @"start":chosePage, @"count":@"10"};
    [manager POST:urlString parameters:paraDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"鉴赏success = %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *dataArray = dic[@"data"];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArray) {
            AppreciateModel *model = [AppreciateModel appreciateDictionary:dataDic];
            [array addObject:model];
            
            debugLog(@"model.logoURL = %@", model.logoUrl);
            
        }
        
        if (complete) {
            complete(array);
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"鉴赏error = %@", error);
    }];

}

@end
