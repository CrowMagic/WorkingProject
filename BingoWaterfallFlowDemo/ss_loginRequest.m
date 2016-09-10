//
//  ss_loginRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/31/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_loginRequest.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ss_loginModel.h"


@implementation ss_loginRequest

+ (void)ss_loginHTTPRequestModel:(ss_loginModel *)model request:(void(^)(NSDictionary *dic))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];

    NSString *urlString = @"http://192.168.2.22:8090/wap/login";
    NSDictionary *dic = @{@"username":@"test", @"password":@"666666"};
    
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         debugLog(@"登录success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         debugLog(@"登录error == %@", error);
    }];
    
    
//    AFHTTPSessionManager *manager = [self getManager];
//    
//    NSString *urlString = @"http://192.168.2.13:8080//shop/login/submit";
//    NSDictionary *dic = @{@"username":model.username,@"password":model.password};
//    [manager POST:urlString
//       parameters:dic
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"success == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:nil];
//            if (complete) {
//                complete(dicss);
//            }
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//    }];
}

+ (void)ss_logoutHTTPRequest:(void(^)(NSDictionary *dic))complete {
    AFHTTPSessionManager *manager = [self getManager];
    NSString *urlString = @"http://192.168.2.12:8080/shop/logout/logout";
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"success == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData
//                                                              options:NSJSONReadingMutableContainers error:nil];
//        if (complete) {
//            complete(dicss);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//
//    }];

}

+ (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    return manager;
}

@end
