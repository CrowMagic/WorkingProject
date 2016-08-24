//
//  ss_loginRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/31/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_loginRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "ss_loginModel.h"


@implementation ss_loginRequest

+ (void)ss_loginHTTPRequestModel:(ss_loginModel *)model request:(void(^)(NSDictionary *dic))complete {
    
    
    
    AFHTTPRequestOperationManager *manager = [self getManager];
    
    NSString *urlString = @"http://192.168.2.13:8080//shop/login/submit";
    NSDictionary *dic = @{@"username":model.username,@"password":model.password};
    [manager POST:urlString
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        debugLog(@"success == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
            if (complete) {
                complete(dicss);
            }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);
    }];
}

+ (void)ss_logoutHTTPRequest:(void(^)(NSDictionary *dic))complete {
    AFHTTPRequestOperationManager *manager = [self getManager];
    NSString *urlString = @"http://192.168.2.12:8080/shop/logout/logout";
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        debugLog(@"success == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers error:nil];
        if (complete) {
            complete(dicss);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];

}

+ (AFHTTPRequestOperationManager *)getManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    return manager;
}

@end
